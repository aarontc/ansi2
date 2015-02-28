require_relative '../../test_helper'

describe String do
	include ANSI2

	context "red { 'hello' }" do
		subject { ANSI2.red { "hello" } }

		# this example is used in String core ext docs, so it better work!
		it "another replace_ansi case test" do
			subject.replace_ansi do |match|
				case match
					when ANSI2::RED then
						"(red)"
					when ANSI2::RESET_COLOR then
						"(normal)"
					else
						raise "not expected: #{match}"
				end
			end.should == "(red)hello(normal)"
		end
	end

	context "move_up + hello + move_down" do
		subject { move_up + " hello " + move_down }

		it "should return an array of ANSI escape sequences" do
			subject.ansi_sequences.should == [ANSI::CURSOR_UP, ANSI::CURSOR_DOWN]
		end

		# This example is used in README, so it better work!
		it "should replace ansi with custom content" do
			subject.replace_ansi do |match|
				case match
					when ANSI::CURSOR_UP
						"(up)"
					when ANSI::CURSOR_DOWN
						"(down)"
					else
						raise "not expected: #{match}"
				end
			end.should == "(up) hello (down)"
		end
	end

	context "red + hello + reset_color" do
		subject { red { "hello there" } }

		it "should return an array of ANSI escape sequences" do
			subject.ansi_sequences.should == [ANSI2::RED, ANSI2::RESET_COLOR]
		end
	end

	context "the regular expression" do
		subject { String::ANSI2_ESCAPE_SEQUENCE_RX }

		it "should be able to find args in 'blink_red_on_white'" do
			subject =~ blink_red_on_white
			$~[2].must_equal "5;31;47"
		end

		it "should match all defined escape sequences" do
			ANSI2.dynamically_defined_methods.each do |method_name|
				sequence = ANSI2.generate_sequence(method_name)
				begin
					assert subject.match(sequence)
				rescue
					raise "Regexp #{String::ANSI2_ESCAPE_SEQUENCE_RX} did not match sequence #{sequence.inspect} (for #{method_name})"
				end
			end
		end
	end
end
