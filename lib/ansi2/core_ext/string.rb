require_relative 'regexp'
require_relative '../../ansi2'
require_relative '../color'

class String
	prefix = "[]?><()#/"
	ANSI2_ESCAPE_SEQUENCE_RX = /\e(?:[#{Regexp::escape prefix}]?)(?:[0-9;\{\?\}]*)(?:[0-#{Regexp::escape 176.chr}])/

	# returns an array listing all detected ANSI sequences in self. These are instances of ANSI::Code.
	def ansi_sequences
		ANSI2_ESCAPE_SEQUENCE_RX.each_match(self).collect do |match|
			ANSI2.recognize match[0]
		end
	end


	def ansi2_raw_matches
		scan ANSI2_ESCAPE_SEQUENCE_RX
	end


	# Creates a new String that is a copy of this String. Takes a block
	# which will receive each occurrance of an ANSI escape sequence; the
	# escape sequence is replaced by the return value of the block.
	#
	# Example:
	#   ANSI.red { "hello" }.replace_ansi do |match|
	#     case match
	#       when RED then "(red)"
	#       when RESET_COLOR then "(normal)"
	#     end
	#   end
	#   #=> "(red)hello(normal)"
	#
	def ansi_replace
		copy = dup
		ANSI2_ESCAPE_SEQUENCE_RX.each_match(copy).collect do |match|
			ansi_match = ANSI2.recognize match[0]
			result = yield ansi_match
			copy.gsub! match[0], result
		end
		copy
	end


	def fg_black
		ANSI2.fg_black { self }
	end

	def fg_red
		ANSI2.fg_red { self }
	end
	alias_method :red, :fg_red
end
