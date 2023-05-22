
# Makefile

ifeq ($(PROGRAM),)										# Check if a value has been inputed for PROGRAM
PROGRAMS := $(wildcard programs/*)
$(info Available programs:)
$(foreach p,$(notdir $(PROGRAMS)), $(info $(p)))
$(error PROGRAM variable is not set. Please provide a value for PROGRAM.)
else ifeq ($(wildcard programs/$(PROGRAM)),)			# Check if the program file exists
PROGRAMS := $(wildcard programs/*)
$(info Available programs:)
$(foreach p,$(notdir $(PROGRAMS)), $(info $(p)))
$(error Program '$(PROGRAM)' does not exist. Please provide a valid program name.)
endif

all: pre build

pre:
	cp programs/$(PROGRAM) imem.dat

build:
	$(MAKE) -C ./sims/top/

