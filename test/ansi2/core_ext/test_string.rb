require_relative '../../test_helper'

require_relative '../../../lib/ansi2/core_ext/string'

class TestString < Minitest::Test
	def test_red_hello
		actual = ANSI2.red { 'hello' }

		actual.ansi_replace do |match|
			case match
				when ANSI2::RED then
					'(red)'
				when ANSI2::RESET_COLOR then
					'(normal)'
				else
					raise "not expected: #{match}"
			end
		end

		assert_equal '(red)hello(normal)', actual
	end


	def test_move_up_hello_move_down
		actual = ANSI2.move_up + ' hello ' + ANSI2.move_down
		assert_equal [ANSI2::CURSOR_UP, ANSI2::CURSOR_DOWN], actual.ansi_sequences

		actual.replace_ansi do |match|
			case match
				when ANSI2::CURSOR_UP
					'(up)'
				when ANSI2::CURSOR_DOWN
					'(down)'
				else
					raise "not expected: #{match}"
			end
		end
		assert_equal '(up) hello (down)', actual
	end


	def test_red_hello_reset_color
		actual = ANSI2.red { 'hello there' }
		assert_equal [ANSI2::RED, ANSI2::RESET_COLOR], actual.ansi_sequences
	end


	def test_the_regular_expression
		actual = ANSI2.blink_red_on_white
		assert String::ANSI2_ESCAPE_SEQUENCE_RX =~ actual
		assert_equal '5;31;47', $~[2]

		ANSI2.dynamically_defined_methods.each do |method_name|
			sequence = ANSI2.generate_sequence method_name
			assert_match String::ANSI2_ESCAPE_SEQUENCE_RX, sequence
		end
	end
end
