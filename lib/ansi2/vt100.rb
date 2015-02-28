module ANSI2
  # Defines escape sequences related VT100 terminals as well as VT52 compatibility mode. These codes
  # come from the VT100 user manual. Constants are created automatically using the UPPERCASE name of
  # each code name. For instance, both the "vt100_set_uk_g0_charset" and "setukg0" names (which both
  # refer to the same escape sequence) are converted to the constants VT100_SET_UK_G0_CHARSET and
  # SETUKG0, respectively.
  #
  # View the source of this file to see the full listing (it's not painful, I promise).
  #
  module VT100
    ANSI2.define("vt100_newline_mode")               { "\e[20h" }
    ANSI2.define("vt100_set_cursor_key_application") { "\e[?1h" }
    ANSI2.define("vt100_set_columns_132")            { "\e[?3h" }
    ANSI2.define("vt100_set_smooth_scrolling")       { "\e[?4h" }
    ANSI2.define("vt100_set_reverse_video")          { "\e[?5h" }
    ANSI2.define("vt100_set_origin_relative")        { "\e[?6h" }
    ANSI2.define("vt100_set_autowrap")               { "\e[?7h" }
    ANSI2.define("vt100_set_autorepeat")             { "\e[?8h" }
    ANSI2.define("vt100_set_interlacing")            { "\e[?9h" }
    
    ANSI2.define("vt100_set_line_feed_mode")    { "\e[20l" }
    ANSI2.define("vt100_set_cursor_key_cursor") { "\e[?1l" }
    ANSI2.define("vt100_set_vt52")              { "\e[?2l" }
    ANSI2.define("vt100_set_columns_80")        { "\e[?3l" }
    ANSI2.define("vt100_set_jump_scrolling")    { "\e[?4l" }
    ANSI2.define("vt100_set_normal_video")      { "\e[?5l" }
    ANSI2.define("vt100_set_origin_absolute")   { "\e[?6l" }
    ANSI2.define("vt100_reset_autowrap")        { "\e[?7l" }
    ANSI2.define("vt100_reset_autorepeat")      { "\e[?8l" }
    ANSI2.define("vt100_reset_interlacing")     { "\e[?9l" }
    
    ANSI2.define("vt100_set_alt_keypad") { "\e=" }
    ANSI2.define("vt100_set_num_keypad") { "\e>" }
    
    ANSI2.define("vt100_set_uk_g0_charset",            "setukg0")      { "\e(A" }
    ANSI2.define("vt100_set_uk_g1_charset",            "setukg1")      { "\e)A" }
    ANSI2.define("vt100_set_us_g0_charset",            "setusg0")      { "\e(B" }
    ANSI2.define("vt100_set_us_g1_charset",            "setusg1")      { "\e)B" }
    ANSI2.define("vt100_set_g0_special_charset",       "setspecg0")    { "\e(0" }
    ANSI2.define("vt100_set_g1_special_charset",       "setspecg1")    { "\e)0" }
    ANSI2.define("vt100_set_g0_alt_char_rom",          "setaltg0")     { "\e(1" }
    ANSI2.define("vt100_set_g1_alt_char_rom",          "setaltg1")     { "\e)1" }
    ANSI2.define("vt100_set_g0_alt_char_rom_graphics", "setaltspecg0") { "\e(2" }
    ANSI2.define("vt100_set_g1_alt_char_rom_graphics", "setaltspecg1") { "\e)2" }
    
    ANSI2.define("vt100_single_shift_2", "ss2") { "\eN" }
    ANSI2.define("vt100_single_shift_3", "ss3") { "\eO" }
    
    ANSI2.define("vt100_char_attrs_off", "sgr0") { "\e[0m" }
    ANSI2.define("vt100_bold",           "sgr1") { "\e[1m" }
    ANSI2.define("vt100_low_intensity",  "sgr2") { "\e[2m" }
    ANSI2.define("vt100_underline",      "sgr4") { "\e[4m" }
    ANSI2.define("vt100_blink",          "sgr5") { "\e[5m" }
    ANSI2.define("vt100_reverse_video",  "sgr7") { "\e[6m" }
    ANSI2.define("vt100_invisible_text", "sgr8") { "\e[8m" }
    
    ANSI2.define("vt100_set_top_and_bottom", "decstbm") { |a,b| "\e[#{a || 0};#{b || 0}r" }
    
    ANSI2.define("vt100_move_cursor_up",    "cuu") { |amt| "\e[#{amt || 1}A" }
    ANSI2.define("vt100_move_cursor_down",  "cud") { |amt| "\e[#{amt || 1}B" }
    ANSI2.define("vt100_move_cursor_left",  "cuf") { |amt| "\e[#{amt || 1}C" }
    ANSI2.define("vt100_move_cursor_right", "cub") { |amt| "\e[#{amt || 1}D" }
    ANSI2.define("vt100_move_cursor_home",  "cursorhome") { "\e[H" }
    ANSI2.define("vt100_move_cursor_to",    "cup") { |line,col| "\e[#{line};#{col}H" }
    ANSI2.define("hvhome")                         { "\e[f" }
    ANSI2.define("vt100_up", "ind")                { "\eD" }
    ANSI2.define("vt100_down", "ri")               { "\eM" }
    ANSI2.define("vt100_next_line", "nel")         { "\eE" }
    ANSI2.define("vt100_save_cursor", "decsc")     { "\e7" }
    ANSI2.define("vt100_restore_cursor", "decrc")  { "\e8" }
    
    ANSI2.define("vt100_set_tab", "hts")         { "\eH" }
    ANSI2.define("vt100_clear_tab", "tbc")       { "\e[0g" }
    ANSI2.define("vt100_clear_all_tabs", "tbca") { "\e[3g" }
    
    ANSI2.define("vt100_dbl_height_top") { "\e#3" }
    ANSI2.define("vt100_dbl_height_btm") { "\e#4" }
    ANSI2.define("vt100_sgl_width")      { "\e#5" }
    ANSI2.define("vt100_dbl_width")      { "\e#6" }
    
    ANSI2.define("vt100_clear_right", "el0") { "\e[0K" }
    ANSI2.define("vt100_clear_left",  "el1") { "\e[1K" }
    ANSI2.define("vt100_clear_line",  "el2") { "\e[2K" }
    ANSI2.define("vt100_clear_down",  "ed0") { "\e[0J" }
    ANSI2.define("vt100_clear_up",    "ed1") { "\e[1J" }
    ANSI2.define("vt100_clear_screen","ed2") { "\e[2J" }
    
    ANSI2.define("vt100_device_status_report", "dsr") { "\e5n" }
    # Responses from terminal:
    ANSI2.define("vt100_device_status_ok")            { "\e0n" }
    ANSI2.define("vt100_device_status_not_ok")        { "\e3n" }
    
    ANSI2.define("vt100_get_cursor_pos")  { "\e6n" }
    # Response from terminal:
    ANSI2.define("vt100_cursor_position") { |line, col| "\e#{line || 0};#{col || 0}R" }
    
    ANSI2.define("vt100_get_terminal_type") { "\e[c" }
    # Response from terminal:
    ANSI2.define("vt100_terminal_type") { |val| "\e[?1;#{val}0c" }
    
    ANSI2.define("vt100_reset_to_init") { "\ec" }
    
    ANSI2.define("vt100_screen_alignment_display") { "\e#8" }
    ANSI2.define("vt100_confidence_power_up_test") { "\e[2;1y" }
    ANSI2.define("vt100_confidence_loopback_test") { "\e[2;2y" }
    ANSI2.define("vt100_repeat_power_up_test")     { "\e[2;9y" }
    ANSI2.define("vt100_repeat_loopback_test")     { "\e[2;10y" }
    
    ANSI2.define("vt100_all_leds_off", "decll0") { "\e[0q" }
    ANSI2.define("vt100_led1_on",      "decll1") { "\e[1q" }
    ANSI2.define("vt100_led2_on",      "decll2") { "\e[2q" }
    ANSI2.define("vt100_led3_on",      "decll3") { "\e[3q" }
    ANSI2.define("vt100_led4_on",      "decll4") { "\e[4q" }
    
    # Codes for use in VT52 compatibility mode
    ANSI2.define("vt52_enter_ansi_mode", "vt100_exit_ansi_mode", "vt52_setansi")    { "\e<"  }
    ANSI2.define("vt52_enter_alt_keypad_mode",                   "vt52_altkeypad")  { "\e="  }
    ANSI2.define("vt52_exit_alt_keypad_mode",                    "vt52_numkeypad")  { "\e>"  }
    ANSI2.define("vt52_use_special_graphics_charset",            "vt52_setgr")      { "\eF"  }
    ANSI2.define("vt52_use_normal_charset",                      "vt52_resetgr")    { "\eG"  }
    ANSI2.define("vt52_move_cursor_up",                          "vt52_cursorup")   { "\eA"  }
    ANSI2.define("vt52_move_cursor_down",                        "vt52_cursordown") { "\eB"  }
    ANSI2.define("vt52_move_cursor_right",                       "vt52_cursorrt")   { "\eC"  }
    ANSI2.define("vt52_move_cursor_left",                        "vt52_cursorlf")   { "\eD"  }
    ANSI2.define("vt52_move_cursor_home",                        "vt52_cursorhome") { "\eH"  }
    ANSI2.define("vt52_generate_reverse_linefeed",               "vt52_revindex")   { "\eI"  }
    ANSI2.define("vt52_erase_to_eol",                            "vt52_cleareol")   { "\eK"  }
    ANSI2.define("vt52_erase_to_eos",                            "vt52_cleareos")   { "\eJ"  }
    ANSI2.define("vt52_identify",                                "vt52_ident")      { "\eZ"  }
    ANSI2.define("vt52_identify_response",                       "vt52_identresp")  { "\e/Z" }
    
    
    # VT100 Special Key Codes
    #
    # These are sent from the terminal back to the computer when the particular key
    # is pressed.	Note that the numeric keypad keys send different codes in numeric
    # mode than in alternate mode. See escape codes above to change keypad mode.
    
    # Function keys:
    ANSI2.define("vt100_sp_pf1", "pf1") { "\eOP" }
    ANSI2.define("vt100_sp_pf2", "pf2") { "\eOQ" }
    ANSI2.define("vt100_sp_pf3", "pf3") { "\eOR" }
    ANSI2.define("vt100_sp_pf4", "pf4") { "\eOS" }
    
    # Arrow keys:
    ANSI2.define("vt100_sp_up_reset")    { "\eA"  }
    ANSI2.define("vt100_sp_down_reset")  { "\eB"  }
    ANSI2.define("vt100_sp_right_reset") { "\eC"  }
    ANSI2.define("vt100_sp_left_reset")  { "\eD"  }
    ANSI2.define("vt100_sp_up_set")      { "\eOA" }
    ANSI2.define("vt100_sp_down_set")    { "\eOB" }
    ANSI2.define("vt100_sp_right_set")   { "\eOC" }
    ANSI2.define("vt100_sp_left_set")    { "\eOD" }
    
    # Numeric keypad keys:
    ANSI2.define("vt100_sp_num0")       { "\eOp" }
    ANSI2.define("vt100_sp_num1")       { "\eOq" }
    ANSI2.define("vt100_sp_num2")       { "\eOr" }
    ANSI2.define("vt100_sp_num3")       { "\eOs" }
    ANSI2.define("vt100_sp_num4")       { "\eOt" }
    ANSI2.define("vt100_sp_num5")       { "\eOu" }
    ANSI2.define("vt100_sp_num6")       { "\eOv" }
    ANSI2.define("vt100_sp_num7")       { "\eOw" }
    ANSI2.define("vt100_sp_num8")       { "\eOx" }
    ANSI2.define("vt100_sp_num9")       { "\eOy" }
    ANSI2.define("vt100_sp_num_minus")  { "\eOm" }
    ANSI2.define("vt100_sp_num_comma")  { "\eOl" }
    ANSI2.define("vt100_sp_num_period") { "\eOn" }
    ANSI2.define("vt100_sp_num_ctrl_m") { "\eOM" }
    
    # Printing:
    ANSI2.define("vt100_sp_print_screen")    { "\e[i"  }
    ANSI2.define("vt100_sp_print_line")      { "\e[1i" }
    ANSI2.define("vt100_sp_stop_print_log")  { "\e[4i" }
    ANSI2.define("vt100_sp_start_print_log") { "\e[5i" }
  end
end
