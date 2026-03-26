TB  = ../tb/calc4_tb.sv
TB_RANDOM = ../tb/calc4_tb_random.sv
RTL = ../rtl/calc4.sv
DIR = ./sim

sim-xrun:
	mkdir -p $(DIR)
	cd $(DIR) && \
	xrun $(TB) $(RTL) -access +rwc

sim-xrun-random:
        mkdir -p $(DIR)
        cd $(DIR) && \
        xrun $(TB_RANDOM) $(RTL) -access +rwc

sim-gui-xrun:
	mkdir -p $(DIR)
	cd $(DIR) && \
	xrun $(TB) $(RTL) -gui -access +rwc -coverage all

sim-gui-xrun-random:
        mkdir -p $(DIR)
        cd $(DIR) && \
        xrun $(TB_RANDOM) $(RTL) -gui -access +rwc -coverage all

sim-vcs:
	mkdir -p $(DIR)
	cd $(DIR) && \
	vcs -sverilog -full64 -debug_access+all $(RTL)

sim-gui-vcs:
	mkdir -p $(DIR)
	cd $(DIR) && \
	vcs -sverilog -full64 -debug_access+all -kdb $(RTL) $(TB) -o simv && \
	./simv -verdi

sim-gui-vcs-random:
        mkdir -p $(DIR)
        cd $(DIR) && \
        vcs -sverilog -full64 -debug_access+all -kdb $(RTL) $(TB_RANDOM) -o simv && \
        ./simv -verdi


clean:
	rm -rf $(DIR)

help:
	@echo "Targets disponíveis:"
	@echo "make sim*      - roda simulação"
	@echo "make sim-gui*  - roda com interface gráfica"
	@echo "make clean    - limpa tudo"
