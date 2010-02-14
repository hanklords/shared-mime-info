# Copyright (c) 2006 Mael Clerambault <mael@clerambault.fr>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.


require 'rexml/document'
require 'magics'

# This provides a way to guess the mime type of a file by doing both
# filename lookups and _magic_ file checks. This implementation tries to
# follow the version 0.13 of the
# specification[http://standards.freedesktop.org/shared-mime-info-spec/shared-mime-info-spec-0.13.html].
module MIME
  VERSION = '0.1'

  module Magic # :nodoc: all
    class BadMagic < StandardError; end

    class Entry
      attr_reader :indent
      def initialize(indent, start_offset, value_length, value, mask, word_size, range_length)
        @indent = indent
        @start_offset = start_offset
        @value_length = value_length
        @value = value.freeze
        @mask = mask.freeze
        @word_size = word_size
        @range_length = range_length
        @sub_entries = []
      end

      def add_subentry(entry)
        if entry.indent == @indent + 1
          @sub_entries << entry
        elsif entry.indent > @indent + 1
          if not @sub_entries.empty?
            @sub_entries.last.add_subentry entry
          else
            raise BadMagic
          end
        else 
          raise BadMagic
        end
      end

      def =~(f)
        check_file(f) and (@sub_entries.empty? || @sub_entries.any? {|e| e =~ f})
      end

      private
      def check_file(f)
        f.pos = @start_offset
        r = (f.read(@value_length + @range_length -1)|| '').unpack("c*")
        range_length = 0
        found = false
        while not found and range_length < r.size
          found = @value.zip(@mask, r[range_length, @value_length]).all? {|vb, mb, rb| (rb & mb) == (vb & mb) }
          range_length = range_length + 1
        end
        found
      end
    end

    class RootEntry < Entry
      attr_reader :priority, :type
      def initialize(type, priority)
        @indent = -1
        @type = type
        @priority = priority
        @sub_entries = []
      end

      private
      def check_file(*args) true end
    end
  end

  # Type represents a single mime type such as <b>text/html</b>.
  class Type
    # Returns the type of a mime type as a String, such as <b>text/html</b>.
    attr_reader :type

    attr_reader :magics, :glob_patterns

    # Returns the media part of the type of a mime type as a string,
    # such as <b>text</b> for a type of <b>text/html</b>.
    def media; @type.split('/', 2).first; end

    # Returns the subtype part of the type of a mime type as a string,
    # such as <b>html</b> for a type of <b>text/html</b>.
    def subtype; @type.split('/', 2).last; end

    # Synonym of type.
    def to_s; @type end

    # Returns a Hash of the comments associated with a mime type in
    # different languages.
    #
    #  MIME['text/html'].comment.default
    #   => "HTML page"
    #
    #  MIME['text/html'].comment['fr']
    #   => "page HTML"
    def comment
      file = ''
      MIME.mime_dirs.each { |dir|
        file = "#{dir}/#{@type}.xml"
        break if File.file? file
      }

      comments = {}
      open(file) { |f|
        doc = REXML::Document.new f
        REXML::XPath.match(doc, '*/comment').each { |c|
          if att = c.attributes['xml:lang']
            comments[att] = c.text
          else
            comments.default = c.text
          end
        }
      }
      comments
    end

    # Returns all the types this type is a subclass of.
    def parents
      file = ''
      MIME.mime_dirs.each { |dir|
        file = "#{dir}/#{@type}.xml"
        break if File.file? file
      }

      open(file) { |f|
        doc = REXML::Document.new f
        REXML::XPath.match(doc, '*/sub-class-of').collect { |c|
          MIME[c.attributes['type']]
        }
      }
    end

    # Equality test.
    #
    #  MIME['text/html'] == 'text/html'
    #   => true
    def ==(type)
      if type.is_a? Type
        @type == type.type
      elsif type.respond_to? :to_str
        @type == type
      else
        false
      end
    end

    # Check if _filename_ is of this particular type by comparing it to
    # some common extensions.
    #
    #  MIME['text/html'].match_filename? 'index.html'
    #   => true
    def match_filename?(filename)
      basename = File.basename(filename)
      @glob_patterns.any? {|pattern| File.fnmatch pattern, basename}
    end

    # Check if _file_ is of this particular type by looking for precise
    # patterns (_magic_ numbers) in different locations of the file.
    #
    # _file_ must be an IO object opened with read permissions.
    def match_file?(f)
      @magics.any? {|m| m =~ f }
    end

    def initialize(type) # :nodoc:
      @type = type
      @glob_patterns = []
      @magics = []
    end
  end

  class << self
    attr_reader :mime_dirs # :nodoc:

    # Returns the MIME::Type object corresponding to _type_.
    def [](type)
      @types.fetch type, nil
    end

    # Look for the type of a file by doing successive checks on
    # the filename patterns.
    #
    # Returns a MIME::Type object or _nil_ if nothing matches.
    def check_globs(filename)
      basename = File.basename(filename)
      found = @globs.each_key.select { |pattern| File.fnmatch pattern, basename }

      if found.empty?
        downcase_basename = basename.downcase
        found = @globs.each_key.select { |pattern|
          File.fnmatch pattern, downcase_basename
        }
      end

      @globs[found.max]
    end

    # Look for the type of a file by doing successive checks on
    # _magic_ numbers.
    #
    # Returns a MIME::Type object or _nil_ if nothing matches.
    def check_magics(file)
      if file.respond_to? :read
        check_magics_type(file, @magics)
      else
        open(file) {|f| check_magics_type(f, @magics) }
      end
    end

    # Look for the type of a file by doing successive checks with
    # the filename patterns or magic numbers. If none of the matches
    # are successful, returns a type of <b>application/octet-stream</b> if
    # the file contains control characters at its beginning, or <b>text/plain</b> otherwise.
    #
    # Returns a MIME::Type object.
    def check(filename)
      check_special(filename) ||
      open(filename) { |f|
        check_magics_gt80(f) ||
        check_globs(filename) ||
        check_magics_lt80(f) ||
        check_default(f)
      }
    end

    private
    def check_magics_type(f, set); c = set.find {|m| m =~ f} and MIME[c.type] end
    def check_magics_gt80(f); check_magics_type(f, @magics_gt80) end
    def check_magics_lt80(f); check_magics_type(f, @magics_lt80) end

    def check_special(filename)
      case File.ftype(filename)
      when 'directory' then @types['inode/directory']
      when 'characterSpecial' then @types['inode/chardevice']
      when 'blockSpecial' then @types['inode/blockdevice']
      when 'fifo' then @types['inode/fifo']
      when 'socket' then @types['inode/socket']
      else
        nil
      end
    end

    def check_default(f)
      f.pos = 0
      firsts = f.read(32) || ''
      bytes = firsts.unpack('C*')
      if bytes.any? {|byte| byte < 32 && ![9, 10, 13].include?(byte) }
        @types['application/octet-stream']
      else
        @types['text/plain']
      end
    end

    def load_globs(file)
      open(file) { |f|
        f.each { |line|
          next if line =~ /^#/
          cline = line.chomp
          type, pattern = cline.split ':', 2
          @types[type].glob_patterns << pattern
          @globs[pattern] = @types[type] unless @globs.has_key? pattern
        }
      }
    end

    def load_magic(file)
      @magics.concat Magic.parse_magic(File.read(file))
    end
  end

  xdg_data_home = ENV['XDG_DATA_HOME'] || "#{ENV['HOME']}/.local/share"
  xdg_data_dirs = ENV['XDG_DATA_DIRS'] || "/usr/local/share/:/usr/share"

  @mime_dirs = (xdg_data_home + ':' + xdg_data_dirs).split(':').collect { |dir|
    "#{dir}/mime"
  }

  @types = Hash.new {|h,k| h[k] = Type.new(k)}
  @magics = []
  @globs = {}

  @mime_dirs.each {|dir|
    glob_file =  "#{dir}/globs"
    load_globs glob_file if File.file? glob_file

    magic_file =  "#{dir}/magic"
    load_magic magic_file if File.file? magic_file
  }

  @magics.sort! {|a,b| b.priority <=> a.priority}
  @magics.each {|m| @types[m.type].magics << m}
  @magics_gt80, @magics_lt80 = @magics.partition {|m| m.priority >= 80}
end
