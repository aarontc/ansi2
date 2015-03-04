require_relative '../test_helper'

require_relative '../../lib/ansi2/cursor'

class TestCursor < Minitest::Test
	def test_save_position
		assert_equal "\e[s", ANSI2.save_cursor_position
	end


	def test_restore_position
		assert_equal "\e[u", ANSI2.restore_cursor_position
	end


	def test_move_up
		assert_equal "\e[2A", ANSI2.move_up(2)
		assert_equal "\e[1A", ANSI2.move_up
		assert_equal "\e[5A", ANSI2.move_up(5)
	end


	def test_move_to
		assert_equal "\e[2;1H", ANSI2.move_to(1, 2)
		assert_equal "\e[0;1H", ANSI2.move_to(1)
		assert_equal "\e[0;0H", ANSI2.move_to
	end
end
