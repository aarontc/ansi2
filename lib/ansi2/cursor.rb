require_relative 'code'

module ANSI2
	# Defines ANSI escape codes relating to cursor movement:
	#
	#   move_to    - accepts an X and Y screen location; X is the column and Y is the row.
	#   move       - accepts a key (A, B, C, D) and an amount which defaults to 1.
	#   move_up    - accepts an amount, which defaults to 1.
	#   move_down  - accepts an amount, which defaults to 1.
	#   move_right - accepts an amount, which defaults to 1.
	#   move_left  - accepts an amount, which defaults to 1.
	#
	#   save_cursor_position    - saves the current cursor position.
	#   restore_cursor_position - restores the cursor position.
	#
	module Cursor
		# ANSI2.define('move_to') { |x, y| "\e[#{y || 0};#{x || 0}H" }
		#
		# ANSI2.define('move') { |key, amt| "\e[#{amt || 1}#{key}" }
		# ANSI2.define('move_up', 'cursor_up', 'cuu') { |amt| move('A', amt) }
		# ANSI2.define('move_down', 'cursor_down', 'cud') { |amt| move('B', amt) }
		# ANSI2.define('move_right', 'cursor_forward', 'cuf') { |amt| move('C', amt) }
		# ANSI2.define('move_left', 'cursor_backward', 'cub') { |amt| move('D', amt) }

		# ANSI2.define('save_cursor_position') { "\e[s" }
		# ANSI2.define('restore_cursor_position') { "\e[u" }


		class MoveTo < Code
			class << self
				def move_to(x = 0, y = 0)
					"\e[#{y};#{x}H"
				end
			end
		end


		class Move < Code
			class << self
				def move(key, amt = 1)
					"\e[#{amt}#{key}"
				end
			end
		end


		class MoveUp < Move
			class << self
				def move_up(amount = 1)
					move 'A', amount
				end

				alias_method :cursor_up, :move_up
				alias_method :cuu, :move_up
			end
		end


		class MoveDown < Move
			class << self
				def move_down(amount = 1)
					move 'B', amount
				end

				alias_method :cursor_down, :move_down
				alias_method :cud, :move_down
			end
		end


		class MoveRight < Move
			class << self
				def move_right(amount = 1)
					move 'C', amount
				end

				alias_method :cursor_right, :move_right
				alias_method :cuf, :move_right
			end
		end


		class MoveLeft < Move
			class << self
				def move_left(amount = 1)
					move 'D', amount
				end

				alias_method :cursor_left, :move_left
				alias_method :cub, :move_left
			end
		end


		class SaveCursorPosition < Code
			class << self
				def save_cursor_position
					"\e[s"
				end
			end
		end


		class RestoreCursorPosition < Code
			class << self
				def restore_cursor_position
					"\e[u"
				end
			end
		end
	end
end
