# The main module for producing and/or parsing ANSI escape sequences. You can include this module into your class, or
# access it directly:
#
#   ANSI.red { "a red string" }
#
#   include ANSI
#   red { "a red string" }
#
#
# To see which ANSI escape sequences can be generated, take a look at the following files:
#   lib/ansi/cursor.rb   - sequences related to the cursor position
#   lib/ansi/color.rb    - sequences related to text color and decoration
#   lib/ansi/display.rb  - sequences related to the display, such as resolution
#   lib/ansi/vt100.rb    - sequences compatible with VT100 terminals
#
# You can also define your own ANSI sequences. Obviously, they won't actually work unless the target system supports
# them, but this is useful in case you need one that I somehow missed.
#
#   ANSI.define("sequence_name", "sn") { |an_argument| "the sequence with #{an_argument}" }
#
# Now you can use the new sequence like so:
#
#   ANSI.sequence_name(1) #=> "the sequence with 1"
#   ANSI.sn(7)            #=> "the sequence with 7"
#
# You can also define sequences that take blocks. In this case, the block argument will be the last argument:
#
#   ANSI.define("block_sequence", "bss") { |arg1, block| "the seq #{arg1} with #{block.call}" }
#
#   ANSI.block_sequence(1) { 55 }
#   #=> "the seq 1 with 55"
#
#   ANSI.bss(35) { 72 }
#   #=> "the seq 35 with 72"
#
# Obviously, the ability to define these sequences (with or without blocks) is probably more useful to me than to you
# -- but it's in there if you need it.
#
require_relative 'ansi2/version'

require_relative 'ansi2/code'
require_relative 'ansi2/color'
require_relative 'ansi2/cursor'
require_relative 'ansi2/display'
#require_relative 'ansi2/vt100'

require_relative 'ansi2/core_ext/object'
require_relative 'ansi2/core_ext/regexp'
require_relative 'ansi2/core_ext/string'

module ANSI2
	class << self
		def codes
			@codes ||= []
		end


		def method_missing(method_name, *args, &block)
			candidate_wrong_arity = []
			@codes.each do |code|
				if code.respond_to? method_name
					method = code.method method_name
					required_param_count = method.parameters.select{|p| p[0] == :req}.count
					candidate_wrong_arity << code
					return method.call *args, &block if args.length >= required_param_count
				end
			end
			block_message = " { #{block.inspect} }" if block
			error_message = "No method with same name and arity as '#{method_name}(#{args.join(', ')})#{block_message}' - possible candidates: #{candidate_wrong_arity.inspect}"
			raise NoMethodError.new(error_message, method_name, args)
		end


		def discover_codes(base_class = ANSI2::Code)
			base_class.ansi2_extension__subclasses.each do |klass|
				@codes << klass
			end
		end

		# # Dynamically generates an escape sequence for the specified method name. Arguments are replaced
		# # with "{?}".
		# def generate_sequence(method_name)
		# 	test_sequence(arities[method_name]) { |*args| send(method_name, *args) }
		# end
		#
		# def test_sequence(arity, &block)
		# 	args = []
		# 	arity.times { args << '{?}' } if arity
		# 	begin
		# 		return block.call(*args)
		# 	rescue TypeError => err
		# 		if err.message =~ /\(expected Proc\)/
		# 			args.pop
		# 			args << nil
		# 			retry
		# 		else
		# 			raise err
		# 		end
		# 	end
		# end


		# Attempts to find an ANSI escape sequence which matches the specified string. The string
		# is expected to use the notation "{?}" for each parameter instead of a real value. For
		# instance, the sequence which would return MOVE_UP would look like: "\e[{?}A" instead of
		# "\e[1A"
		# def recognize(str)
		# 	match = nil
		# 	String::ANSI2_ESCAPE_SEQUENCE_RX =~ str
		# 	if $~ && args = $~[2].split(';')
		# 		codes.uniq.each do |code|
		# 			_args = args.dup
		# 			begin
		# 				result = code.generate(*_args)
		# 			rescue TypeError => err
		# 				if err.message =~ /\(expected Proc\)/ && !_args.empty?
		# 					_args.pop
		# 					retry
		# 				end
		# 				next
		# 			end
		#
		# 			if result == str
		# 				match ||= ANSI2::Match.new(_args)
		# 				match.codes << code
		# 			end
		# 		end
		# 	end
		# 	return match if match
		# 	raise "ANSI sequence not found: #{str.inspect}"
		# end


		# Aliases a specific code with the given names. This way you don't need to redefine a new constant, so performance
		# is improved a little bit. Note that the code is expected to be an actual instance of ANSI::Code, and not an
		# arbitrary string.
		# def alias_code(code, *names, &block)
		# 	code.add_methods! *names
		# 	delegate_names_for(code, *names, &block)
		# end


		# def define(*names, &block)
		# 	code = ANSI2::Code.new names, &block
		# 	#code.add_methods!(*names)
		# 	codes << code
		# 	delegate_names_for(code, *names, &block)
		# 	code
		# end


		# def define(*names, &block)
		# 	class_name = names[0].split('_').map(&:capitalize).join
		# 	aliases = ''
		#
		# 	names[1..-1].each do |name|
		# 		aliases += "alias_method :#{name}, :#{names[0]}\n"
		# 	end
		#
		# 	module_eval <<-END
		# 		class #{class_name} < Code
		# 			def #{names[0]}(*args, &block)
		# 				block.call *args
		# 			end
		# 			#{aliases}
		# 		end
		# 	END
		# end

		# private
		# def delegate_names_for(code, *names, &block) #:nodoc:
		# 	code_index = codes.index(code)
		# 	names.flatten.each do |name|
		# 		const_name = name.to_s.upcase
		# 		const_set(const_name, code) unless const_defined?(const_name)
		#
		# 		arities[name] = code.arity
		# 		if method_defined?(name)
		# 			warn "Warning: about to overwrite method '#{name}'..."
		# 		end
		#
		# 		line = __LINE__ + 1
		# 		rbcode = <<-end_code
		# 			def #{name}(*args, &block)										# def red(*args, &block)
		# 				args << block if block_given?								#   args << block if block_given?
		# 				ANSI2.codes[#{code_index}].send(#{name.inspect}, *args)		#   ANSI.code[1].send('red', *args)
		# 			end																# end
		# 		end_code
		#
		# 		class_eval rbcode, __FILE__, line
		# 		ANSI2.instance_eval rbcode
		# 		@dynamically_defined_methods << name
		# 	end
		# end
	end
end

::ANSI2.discover_codes if ::ANSI2.codes.length == 0
