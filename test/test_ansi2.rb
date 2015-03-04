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

	def test_define_new_ansi_code_with_no_arguments
		ANSI2.define(:bizarro) { "\e[asdf" }
		assert_equal "\e[asdf", ANSI2.bizarro
	end

	def test_new_code_accepts_0_arguments
		ANSI2.define(:bizarro) { |a| "\e[#{a}a" }
		assert_equal "\e[a", ANSI2.bizarro
	end

	def test_new_code_accepts_1_argument
		ANSI2.define(:bizarro) { |a| "\e[#{a}a" }
		assert_equal "\e[1a", ANSI2.bizarro(1)
	end

	def test_new_code_raises_with_2_arguments
		ANSI2.define(:bizarro) { |a| "\e[#{a}a" }
		assert_raises(ArgumentError) { ANSI2.bizarro(1, 2) }
	end
end
