require_relative 'code'

module ANSI2
	# Defines various ANSI escape sequences relating to terminal color manipulation.
	#
	# A few low-level methods are defined:
	#
	# * set_color(*values)
	#   * takes 1 or more numeric color/attribute codes and produces the appropriate escape sequence.
	# * reset_color
	#   * takes no arguments and resets terminal color and attributes to normal.
	#
	# A number of higher-level methods are defined. None of them take any arguments, and they have the effect
	# that their name implies:
	#
	# Attribute methods:
	#   regular    (same as reset_color)
	#   bold
	#   underscore
	#   blink
	#   reverse_video
	#   concealed
	#
	# Foreground color methods:
	#   black   / fg_black
	#   red     / fg_red
	#   green   / fg_green
	#   yellow  / fg_yellow
	#   blue    / fg_blue
	#   magenta / fg_magenta
	#   cyan    / fg_cyan
	#   white   / fg_white
	#
	# Background color methods:
	#   bg_black
	#   bg_red
	#   bg_green
	#   bg_yellow
	#   bg_blue
	#   bg_magenta
	#   bg_cyan
	#   bg_white
	#
	# Every combination of the above is also generated as a single method call, producing results including (but not
	# limited to):
	#   regular_red
	#   bold_red
	#   underscore_red
	#   blink_red
	#   reverse_video_red
	#   concealed_red
	#   red_on_white / regular_red_on_white
	#   bold_red_on_white
	#   underscore_red_on_white
	#   blink_red_on_white
	#   . . .
	#
	module Color
		# class << ANSI2
		# 	# Defines the escape sequence, and then delegates to it from within String. This makes it possible to do things
		# 	# like "this is red".red and so forth. Note that to keep a clean namespace, we'll undef and unalias all of this
		# 	# at the end of the Color module.
		# 	def define_with_extension(*names, &block) #:nodoc:
		# 		_define(*names, &block)
		# 		names.flatten.each do |name|
		# 			String.class_eval { define_method(name) { ANSI2.send(name) { self } } }
		# 			Symbol.class_eval { define_method(name) { self.to_s.send(name) } }
		# 		end
		# 	end
		#
		# 	alias _define define #:nodoc:
		# 	alias define define_with_extension #:nodoc:
		# end

		class SetColor < Code
			class << self
				def set_color(*values, &block)
					color = "\e[#{values.join(';')}m"
					if block
						color + block.call.to_s + reset_color
					else
						color
					end
				end

				alias_method :color, :set_color

				def reset_color
					set_color 0
				end

				alias_method :reset, :reset_color
			end
		end


		# ANSI2.define('set_color', 'color') do |*values|
		# 	block = values.last.kind_of?(Proc) ? values.pop : nil
		# 	colr = "\e[#{values.join(';')}m"
		# 	if block
		# 		colr + block.call.to_s + reset_color
		# 	else
		# 		colr
		# 	end
		# end
		# ANSI2.define('reset_color', 'reset') { color(0) }

		# Various combinations of colors and text attributes:
		#   bold, underscore, blink, reverse_video, concealed
		#   red, fg_red, bg_red, red_on_red, bold_red, bold_red_on_red
		# etc.
		# colors = %w(black red green yellow blue magenta cyan white)
		# attrs = {'regular' => 0, 'bold' => 1, 'underscore' => 4, 'blink' => 5, 'reverse_video' => 7, 'concealed' => 8}
		#
		# attrs.each do |attr_name, attr_value|
		# 	ANSI2.define(attr_name) { |block| color(attr_value, &block) } # 0-8
		# end

		class Regular < SetColor
			class << self
				def regular(&block)
					set_color 0, &block
				end
			end
		end
		class Bold < SetColor
			class << self
				def bold(&block)
					set_color 1, &block
				end
			end
		end
		class Underscore < SetColor
			class << self
				def underscore(&block)
					set_color 4, &block
				end
			end
		end
		class Blink < SetColor
			class << self
				def blink(&block)
					set_color 5, &block
				end
			end
		end
		class ReverseVideo < SetColor
			class << self
				def reverse_video(&block)
					set_color 7, &block
				end
			end
		end
		class Concealed < SetColor
			class << self
				def concealed(&block)
					set_color 8, &block
				end
			end
		end


		class Black < SetColor
			FG_VALUE = 0
			class << self
				def fg_black(&block)
					color FG_VALUE, &block
				end

				def bg_black(&block)
					color FG_VALUE + 10, &block
				end
			end
		end

		class Red < SetColor
			FG_VALUE = 1
			class << self
				def fg_red(&block)
					color FG_VALUE, &block
				end
				def bg_red(&block)
					color FG_VALUE + 10, &block
				end

				alias_method :red, :fg_red
			end
		end

		class Green < SetColor
			FG_VALUE = 2
			class << self
				def fg_green(&block)
					color FG_VALUE, &block
				end

				def bg_green(&block)
					color FG_VALUE + 10, &block
				end
			end
		end

		class Yellow < SetColor
			FG_VALUE = 3
			class << self
				def fg_yellow(&block)
					color FG_VALUE, &block
				end

				def bg_yellow(&block)
					color FG_VALUE + 10, &block
				end
			end
		end

		class Blue < SetColor
			FG_VALUE = 4
			class << self
				def fg_blue(&block)
					color FG_VALUE, &block
				end

				def bg_blue(&block)
					color FG_VALUE + 10, &block
				end
			end
		end

		class Magenta < SetColor
			FG_VALUE = 5
			class << self
				def fg_magenta(&block)
					color FG_VALUE, &block
				end

				def bg_magenta(&block)
					color FG_VALUE + 10, &block
				end
			end
		end

		class Cyan < SetColor
			FG_VALUE = 6
			class << self
				def fg_cyan(&block)
					color FG_VALUE, &block
				end

				def bg_cyan(&block)
					color FG_VALUE + 10, &block
				end
			end
		end

		class White < SetColor
			FG_VALUE = 7
			class << self
				def fg_white(&block)
					color FG_VALUE, &block
				end

				def bg_white(&block)
					color FG_VALUE + 10, &block
				end
			end
		end



		# colors.each_with_index do |fg_name, fg_value|
		# 	fg_value += 30
		# 	ANSI2.define(fg_name, "fg_#{fg_name}") { |block| color(fg_value, &block) } # 30-37  (ie red, fg_red)
		# 	ANSI2.define("bg_#{fg_name}") { |block| color(fg_value + 10, &block) } # 40-47  (ie bg_red)
		#
		# 	attrs.each do |attr_name, attr_value|
		# 		if attr_name.length > 0
		# 			# (ie bold_red)
		# 			ANSI2.define("#{attr_name}_#{fg_name}") { |block| color(attr_value, fg_value, &block) }
		# 		end
		# 	end
		#
		# 	colors.each_with_index do |bg_name, bg_value|
		# 		bg_value += 40
		# 		# (ie red_on_blue)
		# 		ANSI2.define("#{fg_name}_on_#{bg_name}") { |block| color(fg_value, bg_value, &block) }
		#
		# 		attrs.each do |attr_name, attr_value|
		# 			ANSI2.define("#{attr_name}_#{fg_name}_#{bg_name}", "#{attr_name}_#{fg_name}_on_#{bg_name}") do |block|
		# 				color(attr_value, fg_value, bg_value, &block)
		# 			end
		# 		end
		# 	end
		# end

		# class << ANSI2
		# 	# Cleaning up after ourselves...
		# 	alias define _define #:nodoc:
		# 	undef define_with_extension
		# 	undef _define
		# end
	end
end
