# make
Makefile for Atmega328P  
  
The makefile compiles **AVR** code (the AVR language is a "C" environment for programming Atmel chips) in the following manner:  
1. Compile C code ie. .c file to .s using avr-gcc
2. Convert .s file to .elf file  
3. Convert .elf file to .hex file using avr-objcopy  
  
Thereafter, the compiled .hex file is used to program the micro-controller using avrdude.  
Finally, the clean rule is used to remove all intermediate files created.     