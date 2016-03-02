CC=avr-gcc
# compiler collection

MCU=-mmcu=atmega328p
# micro-controller

CPU_SPEED=-DF_CPU=16000000UL
# clock speed

CFLAGS=-Wall -Os $(MCU) $(CPU_SPEED)
# compiler flags

CONVERTER=avr-objcopy
# for elf to hex conversion

SRC=main
# main c source file

UPLOADER=avrdude -F -V -c
# uploader

BOARD=arduino
# board

PORT=/dev/ttyUSB0
# port

BAUD_RATE=57600
# baud rate for communication

all : compile program clean
# rule for "make all" command

compile : $(SRC).hex
# compiler rule

$(SRC).hex : $(SRC).elf
#rule for conversion of elf file to hex file
	$(CONVERTER) -O ihex -R .eeprom $< $@
# -O output file name
# -R remove section

$(SRC).elf : $(SRC).s
#rule for conversion of s file to elf file
	$(CC) $(CFLAGS) -s -o $@ $<	
# -s Remove all symbol table and relocation information from the executable
# -o output file name

$(SRC).s : $(SRC).c
# rule for compilation of c file to s file
	$(CC) $(CFLAGS) -S -o $@ $<	
# -S Stop after the stage of compilation proper; do not assemble. 
#    The output is in the form of an assembler code file for each non-assembler input file specified
# -o output file name

program : $(SRC).hex
# rule to program micro-controller
	$(UPLOADER) $(BOARD) -p ATmega328P -P $(PORT) -b $(BAUD_RATE) -U flash:w:$<

# -F Normally, avrdude tries to verify that the device signature read from the part is reasonable before continuing.  Since
# 	 it can happen from time to time that a device has a broken (erased or overwritten) device signature but is otherwise
# 	 operating normally, this options is provided to override the check. 
# -c programmer-id Use the programmer specified by the argument
# -V Disable automatic verify check when uploading data
# -p part
# -P port
# -b baud rate
# -U memtype:op:filename:filefmt

.PHONY : clean
clean :
# rule to clean up s, elf and hex files
	rm -f *.s
	rm -f *.elf
	rm -f *.hex