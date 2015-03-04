module ANSI2
	# The object that calling ANSI2.define(...) actually creates. This is managed internally and you should rarely
	# have to interface with it directly.
	class Code
# 		attr_reader :method_name, :arity, :block
#
# 		# The name of this code. This is assigned to the first non-nil method name that this object uses.
# 		def name
# 			@name ||= @method_name.to_s.upcase
# 		end
#
# 		alias to_s name
# 		alias inspect name
#
# 		# Returns true if the other object is a kind_of ANSI2::Code, *or* if the other object is a kind_of
# 		# ANSI2::Match and this ANSI2::Code is contained in that match. In other words:
# 		#
# 		#   code = ANSI2::Code.new("a_code") {}
# 		#   match = ANSI2::Match.new
# 		#
# 		#   code === match
# 		#   #=> false
# 		#
# 		#   match << code
# 		#   code === match
# 		#   #=> true
# 		#
# 		def ===(other)
# 			other.kind_of?(ANSI2::Code) or (other.kind_of?(ANSI2::Match) && other == self)
# 		end
#
# 		# Creates methods with the specified names which are aliases of #generate. These methods are singletons
# 		# of this instance of ANSI2::Code, so adding method names using this method is only useful within the
# 		# context of this instance.
# 		#
# 		def add_methods!(*names) #:nodoc:
# 			names = names.flatten
# 			return if names.empty?
# 			@method_name ||= names.first.to_s
#
# 			names.each do |name|
# #				self.instance_eval do
# 				class << self
# 					alias_method name, :generate
# 				end
#
# #				end
# 			end
# 		end
#
# 		# Takes an optional list of method aliases, which are sent to #add_methods!, and a mandatory block argument
# 		# which is bound to the #generate method.
# 		def initialize(*names, &block)
# 			@arity = block.arity || 0
# 			@block = block
#
# 			# eigen.instance_eval do
# 			# 	if block.arity > 0
# 			# 		# we need a list of arguments to pass to it.
# 			# 		define_method "generate" do |*args|
# 			# 			# this is to get around the warnings in Ruby 1.8
# 			# 			if args.length > block.arity && block.arity == 1
# 			# 				raise ArgumentError, "too many arguments (#{args.length} for #{block.arity})", caller
# 			# 			end
# 			#
# 			# 			# omitted args should be made nil. We do this explicitly to silence warnings in 1.8.
# 			# 			if (len = block.arity - args.length)
# 			# 				len.times { args << nil }
# 			# 			end
# 			#
# 			# 			instance_exec(*args, &block)
# 			# 		end
# 			# 	else
# 			# 		define_method("generate", &block)
# 			# 	end
# 			# end
#
# 			add_methods! *names
# 		end
#
# 		def generate(*args, &block)
# 			instance_exec *args, &block
# 		end
#
	end
end
