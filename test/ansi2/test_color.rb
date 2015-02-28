require_relative '../test_helper'

class TestColor < Minitest::Test
	include ANSI2

	def test_wrap_single_fg_color_string_using_block
		assert_equal ANSI2.red + 'a string!' + ANSI2.reset_color, ANSI2.red { 'a string!' }
	end

	def test_add_single_fg_color_to_string
		assert_equal ANSI2.red + 'a string!' + ANSI2.reset_color, 'a string!'.red
	end

	def test_add_single_fg_color_to_symbol
		assert_Equal red + 'a_string!' + reset_color, :a_string!.red
	end

	# context "a single attribute color" do
	# 	it "should wrap a string using a block" do
	# 		blink { "a string!" }.should == blink + "a string!" + reset_color
	# 	end
	#
	# 	it "should be added to String" do
	# 		"a string!".blink.should == blink + "a string!" + reset_color
	# 	end
	#
	# 	it "should be added to Symbol" do
	# 		:a_string!.blink.should == blink + "a_string!" + reset_color
	# 	end
	# end
	#
	# context "a single bg color" do
	# 	it "should wrap a string using a block" do
	# 		bg_red { "a string!" }.should == bg_red + "a string!" + reset_color
	# 	end
	#
	# 	it "should be added to String" do
	# 		"a string!".bg_red.should == bg_red + "a string!" + reset_color
	# 	end
	#
	# 	it "should be added to Symbol" do
	# 		:a_string!.bg_red.should == bg_red + "a_string!" + reset_color
	# 	end
	# end
	#
	# context "a combo of attribute, fg_color" do
	# 	it "should wrap a string using a block" do
	# 		blink_red { "a string!" }.should == blink_red + "a string!" + reset_color
	# 	end
	#
	# 	it "should be added to String" do
	# 		"a string!".blink_red.should == blink_red + "a string!" + reset_color
	# 	end
	#
	# 	it "should be added to Symbol" do
	# 		:a_string!.blink_red.should == blink_red + "a_string!" + reset_color
	# 	end
	# end
	#
	# context "a combo of fg_color, bg_color" do
	# 	it "should wrap a string using a block" do
	# 		red_on_white { "a string!" }.should == red_on_white + "a string!" + reset_color
	# 	end
	#
	# 	it "should be added to String" do
	# 		"a string!".red_on_white.should == red_on_white + "a string!" + reset_color
	# 	end
	#
	# 	it "should be added to Symbol" do
	# 		:a_string!.red_on_white.should == red_on_white + "a_string!" + reset_color
	# 	end
	# end
	#
	# context "a combo of attribute, fg_color, bg_color" do
	# 	it "should wrap a string using a block" do
	# 		blink_red_on_white { "a string!" }.should == blink_red_on_white + "a string!" + reset_color
	# 	end
	#
	# 	it "should be added to String" do
	# 		"a string!".blink_red_on_white.should == blink_red_on_white + "a string!" + reset_color
	# 	end
	#
	# 	it "should be added to Symbol" do
	# 		:a_string!.blink_red_on_white.should == blink_red_on_white + "a_string!" + reset_color
	# 	end
	# end
	#
	# it "should produce red" do
	# 	red.should == "\e[31m"
	# end
	#
	# it "should set color mode" do
	# 	set_color(1).should == "\e[1m"
	# 	set_color(1, 2, 3).should == "\e[1;2;3m"
	# end
	#
	# it "should reset color mode" do
	# 	reset_color.should == "\e[0m"
	# end
end
