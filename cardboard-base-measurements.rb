#!/usr/bin/ruby

# NOTE:
# This didn't work. Cardboard is too wobbly, even if I could cut it precisely
# enough.


# keyboard measurements copied from piano-keyboard.scad

octave = 162.5
white_width = 21.8
white_gap = octave / 7.0 - white_width
black_width = 11.0
white_depth = 134.0
white_travel = 16.9 - 6.1
corner_radius = 1.5
white_thickness = 2*corner_radius

c_stem_width = 13.0
d_stem_width = 14.0
e_stem_width = 12.75
f_stem_width = 12.1
g_stem_width = 12.15
a_stem_width = 12.15
b_stem_width = 12.1

black_gap =
  (octave - 
    (
      c_stem_width +
      d_stem_width +
      e_stem_width +
      f_stem_width +
      g_stem_width +
      a_stem_width +
      b_stem_width +
      5*black_width +
      2*white_gap
    )
  ) / 10

# cardboard measurement

cardboard_thickness = 0.55

# derived values

# make the walls half the length of the keys, and short enough not to stick out
wall_depth = white_depth/2
$wall_height = white_travel/2 # + white_thickness?

# remainder of gap once cardboard fills part of it
white_gap_rem = white_gap - 2*cardboard_thickness
black_gap_rem = black_gap - 2*cardboard_thickness

# output depth

puts("wall depth: %5.2f cm" % [wall_depth/10])

# output mountain and valley folds in separate columns

puts "valley\tmountain\t(cm)"

$x = 0

def wall
  puts("%5.2f" % [$x/10])
  $x += $wall_height
  puts("\t%5.2f" % [$x/10])
  $x += $wall_height
  puts("%5.2f" % [$x/10])
end

wall
$x += c_stem_width + black_gap_rem
wall
$x += black_width + black_gap_rem
wall
$x += d_stem_width + black_gap_rem
wall
$x += black_width + black_gap_rem
wall
$x += e_stem_width + white_gap_rem
wall
$x += f_stem_width + black_gap_rem
wall
$x += black_width + black_gap_rem
wall
$x += g_stem_width + black_gap_rem
wall
$x += black_width + black_gap_rem
wall
$x += a_stem_width + black_gap_rem
wall
$x += black_width + black_gap_rem
wall
$x += b_stem_width + white_gap_rem
wall
