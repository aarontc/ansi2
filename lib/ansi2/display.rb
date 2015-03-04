require_relative 'code'

module ANSI2
	# Defines ANSI2.codes for changing screen resolution. Sequences with the following names are created:
	#
	# * erase_display, clear_display, clear, cls
	#   * Clears the screen.
	# * erase_line, clear_line, clr
	#   * Erases a line beginning with the cursor position.
	# * set_mode, mode
	#   * Sets a particular display mode. Expects a numeric value.
	# * unset_mode, reset_mode
	#   * Resets a specified display mode. Expects a numeric value.
	#
	#   set_40x25m      - enters 40x25 monochrome mode.
	#   set_40x25       - enters 40x25 color mode.
	#   set_80x25m      - enters 80x25 monochrome mode.
	#   set_320x200_4   - enters 320x200 4-color mode.
	#   set_320x200m    - enters 320x200 monochrome mode.
	#   set_320x200     - enters 320x200 color mode.
	#   set_320x200_256 - enters 320x200 256-color mode.
	#   set_640x200m    - enters 640x200 monochrome mode.
	#   set_640x200     - enters 640x200 color mode.
	#   set_640x350m    - enters 640x350 monochrome mode.
	#   set_640x350     - enters 640x350 color mode.
	#   set_640x480m    - enters 640x480 monochrome mode.
	#   set_640x480     - enters 640x480 color mode.
	#
	#   All of the above modes also have an unset_ or reset_ counterpart.
	#
	#   wrap   - turns on word wrapping.
	#   unwrap - turns off word wrapping.
	#
	module Display

		class EraseDisplay < Code
			class << self
				def erase_display
					"\e[2J"
				end

				alias_method :clear_display, :erase_display
				alias_method :clear, :erase_display
				alias_method :cls, :erase_display
			end
		end


		class EraseLine < Code
			class << self
				def erase_line
					"\e[K"
				end

				alias_method :clear_line, :erase_line
				alias_method :clr, :erase_line
			end
		end


		class SetMode < Code
			class << self
				def set_mode(value = 0)
					"\e[=#{value}h"
				end
				alias_method :mode, :set_mode

			end
		end


		class UnsetMode < Code
			class << self
				def unset_mode(value = 0)
					"\e[=#{value}l"
				end
				alias_method :reset_mode, :unset_mode
			end
		end


		class SetModeSpecifier < SetMode
			class << self
				def set_40x25m; set_mode 0; end
				def set_40x25; set_mode 1; end
				def set_80x25m; set_mode 2; end
				def set_80x25; set_mode 3; end
				def set_320x200_4; set_mode 4; end
				def set_320x200m; set_mode 5; end
				def set_640x200m; set_mode 6; end
				def set_320x200; set_mode 13; end
				def set_640x200; set_mode 14; end
				def set_640x350m; set_mode 15; end
				def set_640x350; set_mode 16; end
				def set_640x480m; set_mode 17; end
				def set_640x480; set_mode 18; end
				def set_320x200_256; set_mode 19; end
			end
		end

		class UnsetModeSpecifier < UnsetMode
			class << self
				def unset_40x25m; unset_mode 0; end
				def unset_40x25; unset_mode 1; end
				def unset_80x25m; unset_mode 2; end
				def unset_80x25; unset_mode 3; end
				def unset_320x200_4; unset_mode 4; end
				def unset_320x200m; unset_mode 5; end
				def unset_640x200m; unset_mode 6; end
				def unset_320x200; unset_mode 13; end
				def unset_640x200; unset_mode 14; end
				def unset_640x350m; unset_mode 15; end
				def unset_640x350; unset_mode 16; end
				def unset_640x480m; unset_mode 17; end
				def unset_640x480; unset_mode 18; end
				def unset_320x200_256; unset_mode 19; end
			end
		end

		class Wrap < SetMode
			class << self
				def wrap
					set_mode 7
				end
			end
		end


		class Unwrap < UnsetMode
			class << self
				def unwrap
					unset_mode 7
				end
			end
		end
	end
end
