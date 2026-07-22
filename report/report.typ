#import "template.typ": report, note, warning

#show: report.with(
  title: "Keyboard Design Notes",
  subtitle: "Design and Pin Configuration Research",
  authors: ("Vahin",),
  date: "July 2026",
)

= Initial Design

#note[
  This section (ie 1. Inital Design) took about 2 hours for research, writing and drawing of the design. on 21/07
]
#note[
  The template used in this report is one I made for a school project.
]

The initial design was based on a drawing of the keyboard, shown in Figure 1. Since actual keyboards are staggered, this was done to make the schematic much easier to create.

#figure(
  image("../images/keys.png", width: 80%),
  caption: [Initial keyboard design drawing.]
)

The design contains a total of 11 empty keys:
#pad(left: 2em)[
+ 3 from r6 c11-13
+ 3 from r4 c14-16
+ 3 from r1 c17-c19
+ 2 from r5 c14 and 16
]

In total, it is a 19 x 6 matrix. Although this could be changed to an 18x6 matrix since I use 103 keys and the 18x6 can support 108 keys, while 19x6 supports 114 keys, I have not done this purely because its easier to make if I don't need to move a lot of keys around.

== Design Changes

The design changed slightly from the initial version since the rotary encoder takes 2 GPIO pins (if I ignore the button). The earlier design meant I would hit 30 pins, since I assumed a potentiometer was being used rather than a rotary encoder.

As such, I moved some keys around to create an 18x6 matrix, with only 5 empty slots.

The new GPIO usage is:
#pad(left: 2em)[
+ 18 GPIO pins for the matrix rows and columns
+ 2 GPIO pins for the rotary encoder
+ 1 GPIO pin for the addressable LEDs
+ 2 GPIO pins for the OLED using I2C
]

This gives a total of 24 + 2 + 1 + 2 = 29 GPIO pins, which is all the microcontroller has available.

In this instance, I have NOT used the pin that the encoder gives when pressed, since that is not something I care about.

Technically the OLED screen has 4 pins, but 1 is GND and one is VCC, so those do not require GPIO. Only the I2C clock and communication pins require GPIO.

== Edit V2

The Orpheus Pico only has 26 pins available, because GP23 is used for the user button, GP24 is used for neopixel, and GP25 is used for the User LED. As such, I need to use 2 MCP23017 modules, which each provide 16 GPIO pins. This means everything can go on those modules, and I can share the I2C pins with the OLED display, meaning fewer pins are needed. This means I have gone back to using more columns for the keys so wiring is simpler. In the end, I have a 21x6 matrix, and 3 rotary encoder pins on the expander, meaning I need 2 GPIO pins for I2C for the OLED display and the expanders, 1 GPIO pin for the LED data, and perhaps 1 more pin for an interrupt on the expander.

== Links

The following links are useful for when the BOM will be made.

#pad(left: 2em)[
+ MCP23017: https://www.aliexpress.com/item/1005009506514213.html
+ LED SK6812MINI-E: https://www.lcsc.com/product-detail/C5149201.html?s_z=n_SK6812%2520MINI-E
+ 0.91" OLED: https://www.aliexpress.com/item/32836691660.html
+ 100nF Capacitors: https://www.aliexpress.com/item/1005007470747384.html
+ 1N4148W OSD-123 Diode SMD-F: https://www.aliexpress.com/item/1005006323468521.html
]

= Schematic

#note[
  I spent roughly 2.5 hours on this section on 21/07
]

I made the schematic for the keyboard with everything wired up. I still have yet to add LEDs for each key.

#figure(
  image("../images/keys_schematic.png", width: 80%),
  caption: [Schematic of the keys]
)

#figure(
  image("../images/rotary_and_screen.png", width: 80%),
  caption: [Schematic of the Rotary Encoder and Screen]
)

#figure(
  image("../images/rpi_and_expansion.png", width: 80%),
  caption: [Schematic of the Pi Pico and Expansion Boards]
)

= New Day, New Keyboard

Originally, I was gonna make this like a proper report. Now, its just my ramblings.

#note[
  Spent 4 hours redesigning and its not done :(
]

So, I added LEDs, in this BIG MASSIVE block that looks really ugly. It also turns out that I had one extra extender that I just didn't need, so that was removed.
Finally, LEDS ARE AN ABSOLUTE PAIN DON'T GET ME STARTED. FIRST THEY NEED A RESISTOR ON THE DATA IN. SECOND THE SCHEMATIC ALONE TAKES UP 7 LIGHT YEARS OF SPACE AND THIRD
WHY ARE THEY SO ANNOYING TO PLACE ON THE PCB ITSELF. THEY NEED TO BE EXACTLY 5.08mm BELOW THE BOARD AND BACK AND THE TRACES ARE A PAIN.

sorry got slightly annoyed.

I moved to adding capacitors to each LED without taking a picture. there should be a commit with the leds done (without capacitors) but I didn't take a pic of it.

#figure(
  image("../images/pcb.png", width: 80%),
  caption: [Current PCB design without many traces and without hotswappable footprints]
)

I now plan to add capacitors to the LEDs and move to hotswappable switches.