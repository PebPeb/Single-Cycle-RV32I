
# This is my makefile..... oooooo Spooky Scary! 

PROGRAM =
PROGRAM_DIR =

# Compile 
ten_times_ten: _ten_times_ten _compile _update_imem simulate clean
_ten_times_ten:
	$(eval PROGRAM := ten_times_ten)
	$(eval PROGRAM_DIR := ./programs/Assembler/ten_times_ten/)

_compile:
	$(MAKE) -C $(PROGRAM_DIR)

_update_imem:
	cp $(PROGRAM_DIR)$(PROGRAM).hex source/imem.dat

clean:
	$(MAKE) clean -C $(PROGRAM_DIR)
	$(MAKE) clean -C sims/top/

re_build_sim:
	$(MAKE) build -C sims/top/

simulate:
	$(MAKE) -C sims/top/

