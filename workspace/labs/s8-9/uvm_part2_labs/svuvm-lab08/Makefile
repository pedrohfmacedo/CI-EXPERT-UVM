BLOCKNAME = blockname

#
# RTL
#
RTL_DIR   ?= ./rtl
DUT_FILES := $(wildcard $(RTL_DIR)/*.sv)

#
# Verification
#
TB_TOP_FILE = tb/$(BLOCKNAME)_tb_top.sv

PKG_FILES = \
	tb/$(BLOCKNAME)_pkg.sv

TESTNAME     = baseline
UVM_VERSION  = uvm-1.2
UVM_SEED     = 1
UVM_TESTNAME = $(BLOCKNAME)_test_$(TESTNAME)

#
# VCS / Verdi
#
SIM        = vcs
SIMV       = $(BLOCKNAME)

OUT_DIR    = build/vcs
LOG_DIR    = $(OUT_DIR)/logs

SRC_BUNDLE = $(PKG_FILES) $(DUT_FILES) $(TB_TOP_FILE)

COMPILE_FLAGS = \
	-sverilog \
	-full64 \
	-kdb \
	-debug_access+all \
	-timescale=1ns/1ps \
	-ntb_opts $(UVM_VERSION) \
	+incdir+tb \
	-l $(LOG_DIR)/vcs_comp.log

RUN_FLAGS = \
	+ntb_random_seed=$(UVM_SEED) \
	+UVM_TESTNAME=$(UVM_TESTNAME) \
	+UVM_TR_RECORD \
	+UVM_LOG_RECORD

#
# Compile + Run
#
all: compile run

compile:
	@echo "[VCS] Compiling"
	@mkdir -p $(LOG_DIR)
	$(SIM) \
		$(COMPILE_FLAGS) \
		$(SRC_BUNDLE) \
		-o $(SIMV)

run:
	@echo "[VCS] Running"
	./$(SIMV) \
		$(RUN_FLAGS) \
		-l $(LOG_DIR)/sim.log

#
# Verdi - interactive
#
verdi: compile
	@echo "[VCS] Launching simulation with Verdi"
	./$(SIMV) \
		-gui=verdi \
		$(RUN_FLAGS) \
		+UVM_VERDI_TRACE=UVM_AWARE+HIER+TLM+MSG+PRINT &

#
# Clean
#
clean:
	rm -rf \
		build \
		$(SIMV) \
		$(SIMV).daidir \
		csrc \
		*.key \
		*.fsdb \
		novas.* \
		verdi* \
		vc_hdrs.h \
		inter.* \
		*.log