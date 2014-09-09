###################################################################
# Output filename:
PROJECT		= firmware

# Architecture:
ARCH		= pic

# CPU type:
CPU		= 16f1826

# Source file:
SOURCES		= $(wildcard *.asm)
OBJECTS		= $(SOURCES:.asm=.o)
LIBS		= 

# Flags:
ASFLAGS		= -c -p$(CPU) -w 2 -e on
LDFLAGS		= -m -c -s $(CPU)_g.lkr


###################################################################

AS		= /usr/local/bin/gpasm
LD		= /usr/local/bin/gplink

GPUTILS_DIR 	= /usr/local/share/gputils


###################################################################
all: $(PROJECT).hex

###################################################################
$(PROJECT).hex: $(OBJECTS)
	@echo "*** Linking..."
	@$(LD) $(LDFLAGS) -o $(PROJECT).hex $(OBJECTS) $(LIBS)
	@echo ";PIC$(CPU)" >> $(PROJECT).hex


###################################################################
%.o: %.asm
	@echo "*** Assembling $<..."
	@$(AS) $(ASFLAGS) $<

	
###################################################################
clean:
	@$(RM) *.hex *.cof *.dasm *.lst *.o *.cod *.map
	@echo "*** Project directory cleaned."
	
	
.PHONY: clean all
