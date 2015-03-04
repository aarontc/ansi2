require_relative 'test_helper'

require_relative '../lib/ansi2'

class TestANSI2 < Minitest::Test
	def test_works_for_blink
		actual = ANSI2.generate_sequence 'blink'
		assert_equal "\e[5m", actual
	end

	def test_works_for_color
		assert_equal "\e[m", ANSI2.generate_sequence('color')
	end

	def test_works_for_move
		assert_equal "\e[{?}{?}", ANSI2.generate_sequence('move')
	end

	def test_works_for_move_up
		assert_equal "\e[{?}A", ANSI2.generate_sequence('move_up')
	end

end
