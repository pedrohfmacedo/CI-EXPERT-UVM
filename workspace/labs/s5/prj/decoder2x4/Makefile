BLOCK    = decoder2x4

# Diretórios
WORK_DIR = work
LOG_DIR  = $(WORK_DIR)/logs

# RTL
RTL_FILES = rtl/$(BLOCK).v

# TB
TB_FILES  = tb/tb_$(BLOCK).v
TB_FILES2  = tb/tb_$(BLOCK).sv

# Outputs
SIMV      = $(WORK_DIR)/simv
FSDB_FILE = $(WORK_DIR)/$(BLOCK).fsdb

# VCS
VCS_KDB   = -kdb 
VCS_DEBUG = -debug_access+all
VCS_FLAGS = -full64 -l $(LOG_DIR)/vcs.log $(VCS_KDB) $(VCS_DEBUG) -timescale=1ns/1ps -o $(SIMV)
VCS_FLAGS2 =  -sverilog -full64 -l $(LOG_DIR)/vcs.log $(VCS_KDB) $(VCS_DEBUG) -timescale=1ns/1ps -o $(SIMV)

setup:
	mkdir -p $(WORK_DIR) $(LOG_DIR)

vcs: setup
	vcs $(VCS_FLAGS) $(RTL_FILES) $(TB_FILES) 

vcs2: setup
	vcs $(VCS_FLAGS2) $(RTL_FILES) $(TB_FILES2) 

run: 
	$(SIMV) +FSDB=$(FSDB_FILE)

gui:
	$(SIMV) -gui

verdi_wf:
	verdi -play cmd/$(BLOCK)wave.cmd

verdi_wf_easy:
	verdi -nologo -ssf $(FSDB_FILE)

verdi_sc:
	verdi -play cmd/$(BLOCK)sc.cmd

clean:
	rm -rf $(WORK_DIR) sysProgressLog verdiLog novas* ucli.key .inter* *.log *.key *.conf *.rc *.fsdb *.vcd *.vpd
