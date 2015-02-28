module ANSI2
	class Match
		attr_reader :codes, :args

		# An object is considered to be equal to an ANSI2::Match if:
		# - it is an instance of ANSI2::Match and both its arguments and relevant instances of ANSI2::Code are equal.
		# - it is an instance of ANSI2::Code which is contained in the #codes array of this ANSI2::Match.
		def ==(other)
			if other.kind_of?(ANSI2::Match)
				other.codes == @codes && other.args == @args
			elsif other.kind_of?(ANSI2::Code)
				@codes.include?(other)
			else
				false
			end
		end

		def inspect
			"#<ANSI2::Match(#{@codes.join('|')}) args=#{@args.inspect}>"
		end

		alias to_s inspect

		def initialize(*args)
			args.flatten!
			@args = args
			@codes = []
		end

		# Shorthand for adding an ANSI2::Code to the #codes array.
		def <<(code)
			@codes << code
		end
	end
end
