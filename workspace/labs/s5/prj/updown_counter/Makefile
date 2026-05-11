BLOCK    = updown_counter

# RTL
RTL_FILES = rtl/$(BLOCK).v

# TB
TB_FILES  = tb/tb_$(BLOCK).v
TB_FILES2  = tb/tb_$(BLOCK).sv

# VCS
FSDB_FILE = $(BLOCK)
VCS_KDB   = -kdb 
VCS_DEBUG = -debug_access+all
VCS_FLAGS = -full64 -l ./vcs_logger.log $(VCS_KDB) $(VCS_DEBUG) -timescale=1ns/1ps
VCS_FLAGS2 =  -sverilog -full64 -l ./vcs_logger.log $(VCS_KDB) $(VCS_DEBUG) -timescale=1ns/1ps

vcs:
	vcs $(VCS_FLAGS) $(RTL_FILES) $(TB_FILES) 

vcs2:
	vcs $(VCS_FLAGS2) $(RTL_FILES) $(TB_FILES2) 
run: 
	./simv +FSDB=$(BLOCK).fsdb

gui:
	./simv -gui

verdi_wf:
	verdi -play cmd/$(BLOCK).cmd

verdi_wf_easy:
	verdi -nologo -ssf $(BLOCK).fsdb

verdi_sc:
	verdi -play schematic-top.cmd

clean:
	rm -rf csrc *.daidir simv *.log *.key *.conf *.rc *.fsdb verdiLog/
