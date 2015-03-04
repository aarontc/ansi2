require_relative '../test_helper'

require_relative '../../lib/ansi2'

class TestDisplay < Minitest::Test
	def test_set_40x25m
		assert_equal "\e[=0h", ANSI2.set_40x25m
	end

	def test_unset_40x25m
		assert_equal "\e[=0l", ANSI2.unset_40x25m
	end

	def test_erase_display
		assert_equal "\e[2J", ANSI2.erase_display
	end

	def test_erase_line
		assert_equal "\e[K", ANSI2.erase_line
	end
end
