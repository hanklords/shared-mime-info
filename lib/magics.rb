
# line 1 "magics.rl"
module MIME
module Magic

# line 7 "lib/magics.rb"
class << self
	attr_accessor :_magic_actions
	private :_magic_actions, :_magic_actions=
end
self._magic_actions = [
	0, 1, 0, 1, 1, 1, 3, 1, 
	5, 1, 12, 1, 13, 2, 0, 1, 
	2, 2, 6, 2, 2, 7, 2, 2, 
	9, 2, 11, 12, 3, 2, 8, 4, 
	3, 2, 9, 13, 3, 2, 10, 13, 
	3, 12, 0, 1, 4, 11, 12, 0, 
	1
]

class << self
	attr_accessor :_magic_key_offsets
	private :_magic_key_offsets, :_magic_key_offsets=
end
self._magic_key_offsets = [
	0, 0, 1, 2, 3, 4, 5, 6, 
	7, 8, 9, 10, 11, 12, 14, 17, 
	27, 36, 46, 57, 58, 61, 64, 66, 
	69, 73, 76, 78, 81, 83, 87, 88
]

class << self
	attr_accessor :_magic_trans_keys
	private :_magic_trans_keys, :_magic_trans_keys=
end
self._magic_trans_keys = [
	77, 73, 77, 69, 45, 77, 97, 103, 
	105, 99, 0, 10, 48, 57, 58, 48, 
	57, 43, 95, 45, 46, 48, 57, 65, 
	90, 97, 122, 43, 47, 95, 45, 57, 
	65, 90, 97, 122, 43, 95, 45, 46, 
	48, 57, 65, 90, 97, 122, 43, 93, 
	95, 45, 46, 48, 57, 65, 90, 97, 
	122, 10, 62, 48, 57, 62, 48, 57, 
	48, 57, 61, 48, 57, 10, 38, 43, 
	126, 10, 43, 126, 48, 57, 10, 48, 
	57, 48, 57, 10, 43, 48, 57, 91, 
	62, 91, 48, 57, 0
]

class << self
	attr_accessor :_magic_single_lengths
	private :_magic_single_lengths, :_magic_single_lengths=
end
self._magic_single_lengths = [
	0, 1, 1, 1, 1, 1, 1, 1, 
	1, 1, 1, 1, 1, 0, 1, 2, 
	3, 2, 3, 1, 1, 1, 0, 1, 
	4, 3, 0, 1, 0, 2, 1, 2
]

class << self
	attr_accessor :_magic_range_lengths
	private :_magic_range_lengths, :_magic_range_lengths=
end
self._magic_range_lengths = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 1, 1, 4, 
	3, 4, 4, 0, 1, 1, 1, 1, 
	0, 0, 1, 1, 1, 1, 0, 1
]

class << self
	attr_accessor :_magic_index_offsets
	private :_magic_index_offsets, :_magic_index_offsets=
end
self._magic_index_offsets = [
	0, 0, 2, 4, 6, 8, 10, 12, 
	14, 16, 18, 20, 22, 24, 26, 29, 
	36, 43, 50, 58, 60, 63, 66, 68, 
	71, 76, 80, 82, 85, 87, 91, 93
]

class << self
	attr_accessor :_magic_indicies
	private :_magic_indicies, :_magic_indicies=
end
self._magic_indicies = [
	0, 1, 2, 1, 3, 1, 4, 1, 
	5, 1, 6, 1, 7, 1, 8, 1, 
	9, 1, 10, 1, 11, 1, 12, 1, 
	13, 1, 15, 14, 1, 16, 16, 16, 
	16, 16, 16, 1, 17, 18, 17, 17, 
	17, 17, 1, 19, 19, 19, 19, 19, 
	19, 1, 19, 20, 19, 19, 19, 19, 
	19, 1, 21, 1, 23, 22, 1, 25, 
	24, 1, 26, 1, 28, 27, 1, 29, 
	30, 31, 32, 1, 29, 31, 32, 1, 
	33, 1, 34, 35, 1, 36, 1, 37, 
	38, 39, 1, 40, 1, 42, 40, 41, 
	1, 0
]

class << self
	attr_accessor :_magic_trans_targs
	private :_magic_trans_targs, :_magic_trans_targs=
end
self._magic_trans_targs = [
	2, 0, 3, 4, 5, 6, 7, 8, 
	9, 10, 11, 12, 30, 14, 14, 15, 
	16, 16, 17, 18, 19, 20, 21, 22, 
	21, 22, 23, 23, 24, 31, 25, 26, 
	28, 27, 31, 27, 29, 31, 26, 29, 
	13, 21, 22
]

class << self
	attr_accessor :_magic_trans_actions
	private :_magic_trans_actions, :_magic_trans_actions=
end
self._magic_trans_actions = [
	0, 0, 0, 0, 0, 0, 0, 0, 
	0, 0, 0, 0, 0, 13, 3, 16, 
	1, 0, 0, 3, 5, 0, 44, 25, 
	3, 19, 13, 3, 28, 11, 7, 0, 
	0, 13, 36, 3, 13, 32, 22, 3, 
	0, 40, 9
]

class << self
	attr_accessor :magic_start
end
self.magic_start = 1;
class << self
	attr_accessor :magic_first_final
end
self.magic_first_final = 30;
class << self
	attr_accessor :magic_error
end
self.magic_error = 0;

class << self
	attr_accessor :magic_en_main
end
self.magic_en_main = 1;


# line 53 "magics.rl"


def self.parse_magic( data )
  magics = []
  data = data.unpack("c*")

  
# line 158 "lib/magics.rb"
begin
	p ||= 0
	pe ||= data.length
	cs = magic_start
end

# line 60 "magics.rl"
  eof = pe
  
# line 168 "lib/magics.rb"
begin
	_klen, _trans, _keys, _acts, _nacts = nil
	_goto_level = 0
	_resume = 10
	_eof_trans = 15
	_again = 20
	_test_eof = 30
	_out = 40
	while true
	_trigger_goto = false
	if _goto_level <= 0
	if p == pe
		_goto_level = _test_eof
		next
	end
	if cs == 0
		_goto_level = _out
		next
	end
	end
	if _goto_level <= _resume
	_keys = _magic_key_offsets[cs]
	_trans = _magic_index_offsets[cs]
	_klen = _magic_single_lengths[cs]
	_break_match = false
	
	begin
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + _klen - 1

	     loop do
	        break if _upper < _lower
	        _mid = _lower + ( (_upper - _lower) >> 1 )

	        if data[p] < _magic_trans_keys[_mid]
	           _upper = _mid - 1
	        elsif data[p] > _magic_trans_keys[_mid]
	           _lower = _mid + 1
	        else
	           _trans += (_mid - _keys)
	           _break_match = true
	           break
	        end
	     end # loop
	     break if _break_match
	     _keys += _klen
	     _trans += _klen
	  end
	  _klen = _magic_range_lengths[cs]
	  if _klen > 0
	     _lower = _keys
	     _upper = _keys + (_klen << 1) - 2
	     loop do
	        break if _upper < _lower
	        _mid = _lower + (((_upper-_lower) >> 1) & ~1)
	        if data[p] < _magic_trans_keys[_mid]
	          _upper = _mid - 2
	        elsif data[p] > _magic_trans_keys[_mid+1]
	          _lower = _mid + 2
	        else
	          _trans += ((_mid - _keys) >> 1)
	          _break_match = true
	          break
	        end
	     end # loop
	     break if _break_match
	     _trans += _klen
	  end
	end while false
	_trans = _magic_indicies[_trans]
	cs = _magic_trans_targs[_trans]
	if _magic_trans_actions[_trans] != 0
		_acts = _magic_trans_actions[_trans]
		_nacts = _magic_actions[_acts]
		_acts += 1
		while _nacts > 0
			_nacts -= 1
			_acts += 1
			case _magic_actions[_acts - 1]
when 0 then
# line 6 "magics.rl"
		begin
b = p		end
# line 6 "magics.rl"
when 1 then
# line 7 "magics.rl"
		begin
e = data[ b .. p]		end
# line 7 "magics.rl"
when 2 then
# line 8 "magics.rl"
		begin
n = e.pack("c*").to_i		end
# line 8 "magics.rl"
when 3 then
# line 12 "magics.rl"
		begin
type = e.pack("c*")		end
# line 12 "magics.rl"
when 4 then
# line 17 "magics.rl"
		begin

    value_length = data[p+1, 2].pack("c*").unpack('n').first
    p +=2
    value = data[p+1, value_length]
    mask = [0xff] * value_length
    p += value_length 
  		end
# line 17 "magics.rl"
when 5 then
# line 24 "magics.rl"
		begin

    mask = data[p+1, value_length]
    p += value_length
  		end
# line 24 "magics.rl"
when 6 then
# line 28 "magics.rl"
		begin
priority = n		end
# line 28 "magics.rl"
when 7 then
# line 29 "magics.rl"
		begin
indent = n		end
# line 29 "magics.rl"
when 8 then
# line 30 "magics.rl"
		begin
start_offset = n		end
# line 30 "magics.rl"
when 9 then
# line 31 "magics.rl"
		begin
word_size = n		end
# line 31 "magics.rl"
when 10 then
# line 32 "magics.rl"
		begin
range_length = n		end
# line 32 "magics.rl"
when 11 then
# line 33 "magics.rl"
		begin
magics << RootEntry.new(type, priority)		end
# line 33 "magics.rl"
when 12 then
# line 34 "magics.rl"
		begin
 indent = 0; word_size = 0; range_length = 1		end
# line 34 "magics.rl"
when 13 then
# line 35 "magics.rl"
		begin

    magics.last.add_subentry Entry.new(indent, start_offset, value_length, value, mask, word_size, range_length)
  		end
# line 35 "magics.rl"
# line 330 "lib/magics.rb"
			end # action switch
		end
	end
	if _trigger_goto
		next
	end
	end
	if _goto_level <= _again
	if cs == 0
		_goto_level = _out
		next
	end
	p += 1
	if p != pe
		_goto_level = _resume
		next
	end
	end
	if _goto_level <= _test_eof
	end
	if _goto_level <= _out
		break
	end
	end
	end

# line 62 "magics.rl"
  if  cs < magic_first_final
    raise BadMagic
  end

  magics
end
end
end
