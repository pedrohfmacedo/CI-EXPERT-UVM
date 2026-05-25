BLOCK  = robot_model

# Diretórios
WORK_DIR = work
LOG_DIR  = $(WORK_DIR)/logs

# RTL
RTL_FILES = rtl/$(BLOCK).v
RTL_FILES2 = rtl/$(BLOCK).sv

# TB
TB_FILES  = tb/$(BLOCK)_tb.v
TB_FILES2 = tb/$(BLOCK)_tb.sv

# Outputs
SIMV      = $(WORK_DIR)/simv
FSDB_FILE = $(WORK_DIR)/$(BLOCK).fsdb

# VCS
VCS_KDB   = -kdb
VCS_DEBUG = -debug_access+all

VCS_FLAGS  = -full64 \
              -l $(LOG_DIR)/vcs.log \
              $(VCS_KDB) $(VCS_DEBUG) \
              -Mdir=$(WORK_DIR)/csrc \
              -timescale=1ns/1ps \
              -o $(SIMV)

VCS_FLAGS2 = -sverilog \
              -full64 \
              -l $(LOG_DIR)/vcs.log \
              $(VCS_KDB) $(VCS_DEBUG) \
              -Mdir=$(WORK_DIR)/csrc \
              -timescale=1ns/1ps \
              -o $(SIMV)

setup:
	mkdir -p $(WORK_DIR) $(LOG_DIR)

vcs: setup
	vcs $(VCS_FLAGS) $(RTL_FILES) $(TB_FILES)

vcs2: setup
	vcs $(VCS_FLAGS2) $(RTL_FILES) $(TB_FILES2)

vcs3: setup
	vcs $(VCS_FLAGS2) $(RTL_FILES2) $(TB_FILES2)

run:
	cd $(WORK_DIR) && ./simv +FSDB=$(BLOCK).fsdb

gui:
	cd $(WORK_DIR) && ./simv -gui

verdi_wf:
	verdi -play cmd/$(BLOCK)wave.cmd

verdi_wf_easy:
	verdi -nologo -ssf $(FSDB_FILE)

verdi_sc:
	verdi -play cmd/$(BLOCK)sc.cmd

verdi_fsm:
	verdi -play cmd/$(BLOCK)fsm.cmd

clean:
	rm -rf $(WORK_DIR) \
		   sysProgressLog \
	       verdiLog \
	       novas* \
	       ucli.key \
	       .inter* \
			*.log \
			*.key \
			*.conf \
			*.rc \
			*.fsdb \
			*.vcd	\
			*.vpd	\
			sysProgressLog \
