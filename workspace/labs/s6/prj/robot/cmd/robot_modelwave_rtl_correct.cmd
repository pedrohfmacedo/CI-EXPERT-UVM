simSetSimulator "-vcssv" -exec "work/./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "work/./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiWindowResize -win $_Verdi_1 "313" "41" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
verdiSetActWin -win $_nWave3
srcHBDrag -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvDumpScope "robot_model_tb.dut"
wvSetPosition -win $_nWave3 {("dut" 0)}
wvRenameGroup -win $_nWave3 {G1} {dut}
wvAddSignal -win $_nWave3 "/robot_model_tb/dut/clock" \
           "/robot_model_tb/dut/reset_n" "/robot_model_tb/dut/s0_req" \
           "/robot_model_tb/dut/s1_req" "/robot_model_tb/dut/s2_req" \
           "/robot_model_tb/dut/s3_req" "/robot_model_tb/dut/s0_unloadstart" \
           "/robot_model_tb/dut/s1_unloadstart" \
           "/robot_model_tb/dut/s2_unloadstart" \
           "/robot_model_tb/dut/s3_unloadstart" \
           "/robot_model_tb/dut/s0_unload_done" \
           "/robot_model_tb/dut/s1_unload_done" \
           "/robot_model_tb/dut/s2_unload_done" \
           "/robot_model_tb/dut/s3_unload_done" \
           "/robot_model_tb/dut/load_start"
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSetPosition -win $_nWave3 {("dut" 15)}
wvSetPosition -win $_nWave3 {("dut" 15)}
srcTBRunSim
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
verdiSetActWin -win $_nWave3
wvZoomOut -win $_nWave3
wvScrollDown -win $_nWave3 1
wvScrollUp -win $_nWave3 8
verdiDockWidgetHide -dock widgetDock_<Watch>
srcTBSetHiddenView -view WatchView
wvSelectSignal -win $_nWave3 {( "dut" 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 )} 
wvSelectGroup -win $_nWave3 {dut}
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSetPosition -win $_nWave3 {("dut" 0)}
wvAddSubGroup -win $_nWave3 {dut-1}
wvSelectGroup -win $_nWave3 {dut}
wvSelectGroup -win $_nWave3 {dut/dut-1}
wvSelectGroup -win $_nWave3 {dut/dut-1}
wvRenameGroup -win $_nWave3 {dut/dut-1} {Request}
wvSelectGroup -win $_nWave3 {dut}
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSetPosition -win $_nWave3 {("dut" 0)}
wvAddSubGroup -win $_nWave3 {dut-2}
wvRenameGroup -win $_nWave3 {dut/dut-2} {Unload Start}
wvSelectGroup -win $_nWave3 {dut}
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSetPosition -win $_nWave3 {("dut" 0)}
wvAddSubGroup -win $_nWave3 {dut-3}
wvRenameGroup -win $_nWave3 {dut/dut-3} {Unload Done}
wvSelectGroup -win $_nWave3 {dut/Unload Done}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvAddSubGroup -win $_nWave3 {Unload Done-1}
wvRenameGroup -win $_nWave3 {dut/Unload Done/Unload Done-1} {FSM-States}
wvSelectGroup -win $_nWave3 {dut/Request}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSelectGroup -win $_nWave3 {dut/Unload Start}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Request" 0)}
wvSelectSignal -win $_nWave3 {( "dut" 5 )} 
wvSetPosition -win $_nWave3 {("dut" 5)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 0)}
wvSetPosition -win $_nWave3 {("dut" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSetPosition -win $_nWave3 {("dut" 1)}
wvSelectSignal -win $_nWave3 {( "dut" 6 )} 
wvSetPosition -win $_nWave3 {("dut" 6)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 0)}
wvSetPosition -win $_nWave3 {("dut" 1)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut" 1)}
wvSetPosition -win $_nWave3 {("dut" 2)}
wvSelectSignal -win $_nWave3 {( "dut" 7 )} 
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Request" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 1)}
wvSelectSignal -win $_nWave3 {( "dut" 8 )} 
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 1)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Request" 1)}
wvSetPosition -win $_nWave3 {("dut/Request" 2)}
wvSelectSignal -win $_nWave3 {( "dut" 9 )} 
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 2)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Request" 2)}
wvSetPosition -win $_nWave3 {("dut/Request" 3)}
wvScrollDown -win $_nWave3 5
wvSelectSignal -win $_nWave3 {( "dut" 15 )} 
wvSetPosition -win $_nWave3 {("dut" 14)}
wvSetPosition -win $_nWave3 {("dut" 13)}
wvSetPosition -win $_nWave3 {("dut" 12)}
wvSetPosition -win $_nWave3 {("dut" 11)}
wvSetPosition -win $_nWave3 {("dut" 10)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSelectSignal -win $_nWave3 {( "dut" 16 )} 
wvSetPosition -win $_nWave3 {("dut" 15)}
wvSetPosition -win $_nWave3 {("dut" 14)}
wvSetPosition -win $_nWave3 {("dut" 13)}
wvSetPosition -win $_nWave3 {("dut" 12)}
wvSetPosition -win $_nWave3 {("dut" 11)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSelectSignal -win $_nWave3 {( "dut" 16 )} 
wvSelectSignal -win $_nWave3 {( "dut" 17 )} 
wvSetPosition -win $_nWave3 {("dut" 16)}
wvSetPosition -win $_nWave3 {("dut" 15)}
wvSetPosition -win $_nWave3 {("dut" 14)}
wvSetPosition -win $_nWave3 {("dut" 13)}
wvSetPosition -win $_nWave3 {("dut" 12)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvScrollDown -win $_nWave3 2
wvSelectSignal -win $_nWave3 {( "dut" 18 )} 
wvSetPosition -win $_nWave3 {("dut" 17)}
wvSetPosition -win $_nWave3 {("dut" 16)}
wvSetPosition -win $_nWave3 {("dut" 15)}
wvSetPosition -win $_nWave3 {("dut" 14)}
wvSetPosition -win $_nWave3 {("dut" 13)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvSelectSignal -win $_nWave3 {( "dut" 14 )} 
wvSelectSignal -win $_nWave3 {( "dut" 15 )} 
wvSetPosition -win $_nWave3 {("dut" 14)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 1)}
wvSelectSignal -win $_nWave3 {( "dut" 16 )} 
wvSetPosition -win $_nWave3 {("dut" 15)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 1)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Start" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 2)}
wvSelectSignal -win $_nWave3 {( "dut" 17 )} 
wvSetPosition -win $_nWave3 {("dut" 16)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 2)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Start" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 3)}
wvSelectSignal -win $_nWave3 {( "dut" 17 )} 
wvSelectSignal -win $_nWave3 {( "dut" 18 )} 
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 3)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Start" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 4)}
wvSelectSignal -win $_nWave3 {( "dut" 19 )} 
wvSetPosition -win $_nWave3 {("dut" 18)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 4)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Start" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 5)}
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 3
wvScrollDown -win $_nWave3 5
wvSelectSignal -win $_nWave3 {( "dut" 19 )} 
wvSetPosition -win $_nWave3 {("dut" 19)}
wvSetPosition -win $_nWave3 {("dut/Unload Done/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 5)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 3)}
wvSetPosition -win $_nWave3 {("dut/Request" 2)}
wvSetPosition -win $_nWave3 {("dut/Request" 1)}
wvSetPosition -win $_nWave3 {("dut/Request" 0)}
wvSetPosition -win $_nWave3 {("dut" 2)}
wvSetPosition -win $_nWave3 {("dut" 1)}
wvSetPosition -win $_nWave3 {("dut/Request" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 1)}
wvSetPosition -win $_nWave3 {("dut/Request" 2)}
wvSetPosition -win $_nWave3 {("dut/Request" 3)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Request" 3)}
wvSetPosition -win $_nWave3 {("dut/Request" 4)}
wvScrollDown -win $_nWave3 6
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 7
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvSelectGroup -win $_nWave3 {dut/Unload Done/FSM-States}
wvGetSignalOpen -win $_nWave3
wvGetSignalSetScope -win $_nWave3 "/robot_model_tb"
wvGetSignalSetScope -win $_nWave3 "/robot_model_tb/dut"
wvGetSignalSetScope -win $_nWave3 "/robot_model_tb"
wvGetSignalSetScope -win $_nWave3 "/robot_model_tb/dut"
wvSetPosition -win $_nWave3 {("dut/Request" 12)}
wvSetPosition -win $_nWave3 {("dut/Request" 12)}
wvAddSignal -win $_nWave3 -clear
wvAddSignal -win $_nWave3 -group {"dut" \
{/robot_model_tb/dut/clock} -height 16 \
{/robot_model_tb/dut/reset_n} -height 16 \
}
wvAddSignal -win $_nWave3 -group {"dut/Request" \
{/robot_model_tb/dut/s0_req} -height 16 \
{/robot_model_tb/dut/s1_req} -height 16 \
{/robot_model_tb/dut/s2_req} -height 16 \
{/robot_model_tb/dut/s3_req} -height 16 \
{/robot_model_tb/dut/curr_state\[1:0\]} -height 16 \
{/robot_model_tb/dut/load_cstate\[1:0\]} -height 16 \
{/robot_model_tb/dut/load_nstate\[1:0\]} -height 16 \
{/robot_model_tb/dut/next_state\[1:0\]} -height 16 \
{/robot_model_tb/dut/next_station\[1:0\]} -height 16 \
{/robot_model_tb/dut/station\[1:0\]} -height 16 \
{/robot_model_tb/dut/unload_cstate\[2:0\]} -height 16 \
{/robot_model_tb/dut/unload_nstate\[2:0\]} -height 16 \
}
wvAddSignal -win $_nWave3 -group {"dut/Unload Start" \
{/robot_model_tb/dut/s0_unloadstart} -height 16 \
{/robot_model_tb/dut/s1_unloadstart} -height 16 \
{/robot_model_tb/dut/s2_unloadstart} -height 16 \
{/robot_model_tb/dut/s3_unloadstart} -height 16 \
{/robot_model_tb/dut/load_start} -height 16 \
}
wvAddSignal -win $_nWave3 -group {"dut/Unload Done" \
{/robot_model_tb/dut/s0_unload_done} -height 16 \
{/robot_model_tb/dut/s1_unload_done} -height 16 \
{/robot_model_tb/dut/s2_unload_done} -height 16 \
{/robot_model_tb/dut/s3_unload_done} -height 16 \
}
wvAddSignal -win $_nWave3 -group {"dut/Unload Done/FSM-States" \
}
wvAddSignal -win $_nWave3 -group {"G2" \
}
wvSelectSignal -win $_nWave3 {( "dut/Request" 5 6 7 8 9 10 11 12 )} 
wvSetPosition -win $_nWave3 {("dut/Request" 12)}
wvScrollUp -win $_nWave3 8
wvScrollUp -win $_nWave3 2
wvScrollDown -win $_nWave3 3
wvScrollDown -win $_nWave3 2
wvScrollDown -win $_nWave3 6
wvScrollDown -win $_nWave3 0
wvSelectGroup -win $_nWave3 {dut/Unload Done/FSM-States}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 5)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 12)}
wvSetPosition -win $_nWave3 {("dut/Request" 11)}
wvSetPosition -win $_nWave3 {("dut/Request" 10)}
wvSetPosition -win $_nWave3 {("dut/Request" 9)}
wvSetPosition -win $_nWave3 {("dut/Request" 8)}
wvSetPosition -win $_nWave3 {("dut/Request" 7)}
wvSetPosition -win $_nWave3 {("dut/Request" 6)}
wvSetPosition -win $_nWave3 {("dut/Request" 5)}
wvSetPosition -win $_nWave3 {("dut/Request" 4)}
wvSetPosition -win $_nWave3 {("dut/Request" 3)}
wvSetPosition -win $_nWave3 {("dut/Request" 2)}
wvSetPosition -win $_nWave3 {("dut/Request" 1)}
wvSetPosition -win $_nWave3 {("dut/Request" 0)}
wvSetPosition -win $_nWave3 {("dut" 2)}
wvSetPosition -win $_nWave3 {("dut" 1)}
wvSetPosition -win $_nWave3 {("dut" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 2)}
wvSetPosition -win $_nWave3 {("dut/Request" 3)}
wvSetPosition -win $_nWave3 {("dut/Request" 4)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Request" 4)}
wvScrollDown -win $_nWave3 7
wvScrollUp -win $_nWave3 4
wvScrollDown -win $_nWave3 8
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
schCreateWindow -delim "." -win $_nSchema1 -scope "robot_model_tb"
verdiSetActWin -win $_nSchema_4
schSelect -win $_nSchema4 -inst "dut"
schPushViewIn -win $_nSchema4
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
verdiSetActWin -win $_nWave3
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 16
verdiDockWidgetHide -dock widgetDock_<Member>
srcTBSetHiddenView -view MemberView
verdiDockWidgetHide -dock widgetDock_<Local>
srcTBSetHiddenView -view LocalView
verdiSetActWin -dock widgetDock_<Stack>
verdiSetActWin -win $_nWave3
verdiSetActWin -dock widgetDock_<Stack>
verdiSetActWin -win $_nWave3
wvScrollUp -win $_nWave3 14
wvScrollDown -win $_nWave3 3
wvSetPosition -win $_nWave3 {("dut/Request/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 6)}
wvSetPosition -win $_nWave3 {("dut/Request" 7)}
wvSetPosition -win $_nWave3 {("dut/Request" 8)}
wvSetPosition -win $_nWave3 {("dut/Request" 9)}
wvSetPosition -win $_nWave3 {("dut/Request" 10)}
wvSetPosition -win $_nWave3 {("dut/Request" 11)}
wvSetPosition -win $_nWave3 {("dut/Request" 12)}
wvSetPosition -win $_nWave3 {("dut/Request" 13)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Start/FSM-States" 0)}
wvSelectGroup -win $_nWave3 {dut/Unload Start}
wvSelectGroup -win $_nWave3 {dut/Unload Start/FSM-States}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 12)}
wvSetPosition -win $_nWave3 {("dut/Request" 11)}
wvSetPosition -win $_nWave3 {("dut/Request" 10)}
wvSetPosition -win $_nWave3 {("dut/Request" 9)}
wvSetPosition -win $_nWave3 {("dut/Request" 8)}
wvSetPosition -win $_nWave3 {("dut/Request" 7)}
wvSetPosition -win $_nWave3 {("dut/Request" 6)}
wvSetPosition -win $_nWave3 {("dut/Request" 5)}
wvSetPosition -win $_nWave3 {("dut/Request" 4)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Request" 4)}
wvSelectGroup -win $_nWave3 {dut/Request/FSM-States}
wvSelectSignal -win $_nWave3 {( "dut/Request" 7 )} 
wvSelectSignal -win $_nWave3 {( "dut/Request" 6 7 )} 
wvSelectGroup -win $_nWave3 {dut/Request/FSM-States}
wvSetPosition -win $_nWave3 {("dut/Request/FSM-States" 0)}
wvSetPosition -win $_nWave3 {("dut/Request" 6)}
wvSetPosition -win $_nWave3 {("dut/Request" 7)}
wvSetPosition -win $_nWave3 {("dut/Request" 8)}
wvSetPosition -win $_nWave3 {("dut/Request" 9)}
wvSetPosition -win $_nWave3 {("dut/Request" 10)}
wvSetPosition -win $_nWave3 {("dut/Request" 11)}
wvSetPosition -win $_nWave3 {("dut/Request" 12)}
wvSetPosition -win $_nWave3 {("dut/Request" 13)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("dut/Unload Start/FSM-States" 0)}
wvScrollDown -win $_nWave3 10
wvSelectGroup -win $_nWave3 {dut/Unload Start/FSM-States}
wvScrollDown -win $_nWave3 1
wvSetPosition -win $_nWave3 {("dut/Unload Start" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 5)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 6)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvSetPosition -win $_nWave3 {("G2" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM-States" 0)}
wvSelectGroup -win $_nWave3 {G2}
wvScrollUp -win $_nWave3 12
wvSelectSignal -win $_nWave3 {( "dut/Request" 5 )} 
wvSelectSignal -win $_nWave3 {( "dut/Request" 5 6 )} 
wvSelectSignal -win $_nWave3 {( "dut/Request" 5 6 7 )} 
wvSelectSignal -win $_nWave3 {( "dut/Request" 5 6 7 8 )} 
wvSelectSignal -win $_nWave3 {( "dut/Request" 5 6 7 8 9 )} 
wvSelectSignal -win $_nWave3 {( "dut/Request" 5 6 7 8 9 10 )} 
wvSelectSignal -win $_nWave3 {( "dut/Request" 5 6 7 8 9 10 11 )} 
wvSelectSignal -win $_nWave3 {( "dut/Request" 5 6 7 8 9 10 11 12 )} 
wvSetPosition -win $_nWave3 {("dut/Request" 6)}
wvSetPosition -win $_nWave3 {("dut/Request" 7)}
wvSetPosition -win $_nWave3 {("dut/Request" 8)}
wvSetPosition -win $_nWave3 {("dut/Request" 9)}
wvSetPosition -win $_nWave3 {("dut/Request" 10)}
wvSetPosition -win $_nWave3 {("dut/Request" 11)}
wvSetPosition -win $_nWave3 {("dut/Request" 12)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 4)}
wvSetPosition -win $_nWave3 {("dut/Unload Start" 5)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 1)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 2)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 3)}
wvSetPosition -win $_nWave3 {("dut/Unload Done" 4)}
wvSetPosition -win $_nWave3 {("FSM-States" 0)}
wvSetPosition -win $_nWave3 {("G2" 0)}
wvSetPosition -win $_nWave3 {("FSM-States" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM-States" 8)}
wvScrollUp -win $_nWave3 14
wvScrollDown -win $_nWave3 3
wvSelectSignal -win $_nWave3 {( "dut/Unload Start" 5 )} 
wvScrollUp -win $_nWave3 2
wvScrollDown -win $_nWave3 6
wvScrollUp -win $_nWave3 4
wvScrollDown -win $_nWave3 4
wvScrollDown -win $_nWave3 7
wvSelectSignal -win $_nWave3 {( "FSM-States" 5 )} 
wvSetPosition -win $_nWave3 {("FSM-States" 3)}
wvSetPosition -win $_nWave3 {("FSM-States" 2)}
wvSetPosition -win $_nWave3 {("FSM-States" 1)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM-States" 1)}
wvSetPosition -win $_nWave3 {("FSM-States" 2)}
wvSelectSignal -win $_nWave3 {( "FSM-States" 6 )} 
wvSetPosition -win $_nWave3 {("FSM-States" 5)}
wvSetPosition -win $_nWave3 {("FSM-States" 4)}
wvSetPosition -win $_nWave3 {("FSM-States" 3)}
wvSetPosition -win $_nWave3 {("FSM-States" 2)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM-States" 2)}
wvSetPosition -win $_nWave3 {("FSM-States" 3)}
wvSelectSignal -win $_nWave3 {( "FSM-States" 6 )} 
wvSetPosition -win $_nWave3 {("FSM-States" 5)}
wvSetPosition -win $_nWave3 {("FSM-States" 4)}
wvSetPosition -win $_nWave3 {("FSM-States" 3)}
wvSetPosition -win $_nWave3 {("FSM-States" 2)}
wvSetPosition -win $_nWave3 {("FSM-States" 1)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM-States" 1)}
wvSetPosition -win $_nWave3 {("FSM-States" 2)}
wvSelectSignal -win $_nWave3 {( "FSM-States" 1 )} 
wvSelectSignal -win $_nWave3 {( "FSM-States" 2 )} 
wvSelectSignal -win $_nWave3 {( "FSM-States" 3 )} 
wvSelectSignal -win $_nWave3 {( "FSM-States" 4 )} 
wvSetPosition -win $_nWave3 {("FSM-States" 3)}
wvSetPosition -win $_nWave3 {("FSM-States" 2)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM-States" 2)}
wvSetPosition -win $_nWave3 {("FSM-States" 3)}
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvScrollUp -win $_nWave3 11
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 1
wvScrollUp -win $_nWave3 1
