module MIME
module Magic
%%{
  machine magic;

  action begin {b = p}
  action end   {e = data[ b .. p]}
  action number {n = e.to_i}
  number = digit+ >begin @end %number;

  # media-type
  action type {type = e}
  type_part = alnum | [\-_+.] ;
  type = (type_part+ "/" type_part+) >begin @end %type;

  # Section
  action value {
    value_length = data[p+1, 2].unpack('n').first
    p +=2
    value = data[p+1, value_length]
    mask = [0xff].pack('c') * value_length
    p += value_length 
  }
  action mask {
    mask = data[p+1, value_length]
    p += value_length
  }
  action priority {priority = n}
  action indent {indent = n}
  action start_offset {start_offset = n}
  action word_size {word_size = n}
  action range_length {range_length = n}
  action section_header {magics << RootEntry.new(type, priority)}
  action begin_section { indent = 0; word_size = 0; range_length = 1}
  action section {
    magics.last.add_subentry Entry.new(indent, start_offset, value_length, value, mask, word_size, range_length)
  }

  indent = number %indent;
  start_offset = ">" number %start_offset;
  value = "=" @value;
  mask = "&" @mask;
  word_size = "~" number %word_size;
  range_length = "+" number %range_length;

  priority = number %priority;
  section_header = "["  priority ":" type "]\n" %section_header ;
  section = indent? >begin_section start_offset value mask? word_size? range_length? "\n";
  sections = section_header section+ @section;
  main := "MIME-Magic\0\n" sections*;

  write data;
}%%

def self.parse_magic( data )
  magics = []

  %% write init;
  eof = pe
  %% write exec;
  if  cs < magic_first_final
    raise BadMagic
  end

  magics
end
end
end
