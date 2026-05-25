simSetSimulator "-vcssv" -exec "work/./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "work/./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Member>
verdiWindowResize -win $_Verdi_1 "1280" "0" "1279" "1411"
srcHBSelect "robot_model_tb.u_robot_model" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvCreateWindow
verdiSetActWin -win $_nWave3
srcHBDrag -win $_nTrace1
wvDumpScope "robot_model_tb.u_robot_model"
wvSetPosition -win $_nWave3 {("u_robot_model" 0)}
wvRenameGroup -win $_nWave3 {G1} {u_robot_model}
wvAddSignal -win $_nWave3 "/robot_model_tb/u_robot_model/clock" \
           "/robot_model_tb/u_robot_model/reset_n" \
           "/robot_model_tb/u_robot_model/s0_req" \
           "/robot_model_tb/u_robot_model/s1_req" \
           "/robot_model_tb/u_robot_model/s2_req" \
           "/robot_model_tb/u_robot_model/s3_req" \
           "/robot_model_tb/u_robot_model/s0_unloadstart" \
           "/robot_model_tb/u_robot_model/s1_unloadstart" \
           "/robot_model_tb/u_robot_model/s2_unloadstart" \
           "/robot_model_tb/u_robot_model/s3_unloadstart" \
           "/robot_model_tb/u_robot_model/s0_unload_done" \
           "/robot_model_tb/u_robot_model/s1_unload_done" \
           "/robot_model_tb/u_robot_model/s2_unload_done" \
           "/robot_model_tb/u_robot_model/s3_unload_done" \
           "/robot_model_tb/u_robot_model/load_start"
wvSetPosition -win $_nWave3 {("u_robot_model" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 15)}
wvSetPosition -win $_nWave3 {("u_robot_model" 15)}
verdiSetActWin -dock widgetDock_<Inst._Tree>
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
srcTBRunSim
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
wvZoomOut -win $_nWave3
verdiSetActWin -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
verdiDockWidgetHide -dock widgetDock_<Watch>
srcTBSetHiddenView -view WatchView
wvSelectSignal -win $_nWave3 {( "u_robot_model" 1 2 3 4 5 6 7 8 9 10 11 12 13 \
           14 15 )} 
wvSelectSignal -win $_nWave3 {( "u_robot_model" 1 2 3 4 5 6 7 8 9 10 11 12 13 \
           14 15 )} 
verdiWindowResize -win $_Verdi_1 "1186" "0" "1373" "1411"
wvScrollDown -win $_nWave3 0
wvSelectSignal -win $_nWave3 {( "u_robot_model" 1 2 3 4 5 6 7 8 9 10 11 12 13 \
           14 15 )} 
wvSelectGroup -win $_nWave3 {u_robot_model}
wvSelectGroup -win $_nWave3 {G2}
wvRenameGroup -win $_nWave3 {G2} {Request}
wvAddComment -win $_nWave3
wvSetPosition -win $_nWave3 {("u_robot_model" 15)}
wvSetPosition -win $_nWave3 {("u_robot_model" 16)}
wvSelectSignal -win $_nWave3 {( "u_robot_model" 16 )} 
wvCut -win $_nWave3
wvSetPosition -win $_nWave3 {("Request" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 15)}
wvSelectGroup -win $_nWave3 {Request}
wvSelectGroup -win $_nWave3 {Request}
wvSelectGroup -win $_nWave3 {u_robot_model}
wvSetPosition -win $_nWave3 {("u_robot_model" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 0)}
wvAddSubGroup -win $_nWave3 {u_robot_model-1}
wvRenameGroup -win $_nWave3 {u_robot_model/u_robot_model-1} {Request}
wvSelectSignal -win $_nWave3 {( "u_robot_model" 16 )} 
wvSelectSignal -win $_nWave3 {( "u_robot_model" 16 )} 
wvSelectGroup -win $_nWave3 {Request}
verdiWindowResize -win $_Verdi_1 "1280" "0" "1279" "1411"
wvSelectGroup -win $_nWave3 {u_robot_model/Request}
wvSetPosition -win $_nWave3 {("u_robot_model" 2)}
wvSetPosition -win $_nWave3 {("u_robot_model" 3)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("u_robot_model/Request" 0)}
wvSelectGroup -win $_nWave3 {Request}
wvSelectGroup -win $_nWave3 {Request}
wvSelectGroup -win $_nWave3 {Request}
wvSelectSignal -win $_nWave3 {( "u_robot_model" 16 )} 
wvSelectGroup -win $_nWave3 {Request}
wvSelectGroup -win $_nWave3 {u_robot_model/Request}
wvSelectGroup -win $_nWave3 {u_robot_model/Request}
wvSelectGroup -win $_nWave3 {u_robot_model/Request}
wvSelectSignal -win $_nWave3 {( "u_robot_model" 16 )} 
wvSelectGroup -win $_nWave3 {Request}
wvCut -win $_nWave3
wvSetPosition -win $_nWave3 {("u_robot_model/Request" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 16)}
wvSetPosition -win $_nWave3 {("u_robot_model" 16)}
wvSetPosition -win $_nWave3 {("u_robot_model/Request" 0)}
wvSelectGroup -win $_nWave3 {G2}
wvSetPosition -win $_nWave3 {("G2" 0)}
wvSetPosition -win $_nWave3 {("G2" 0)}
wvAddSubGroup -win $_nWave3 {G2-1}
wvSelectGroup -win $_nWave3 {G2}
wvSelectGroup -win $_nWave3 {G2}
wvSelectSignal -win $_nWave3 {( "u_robot_model" 4 )} 
wvSelectGroup -win $_nWave3 {u_robot_model/Request}
wvSelectGroup -win $_nWave3 {u_robot_model}
wvSetPosition -win $_nWave3 {("u_robot_model" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 0)}
wvAddSubGroup -win $_nWave3 {u_robot_model-2}
wvRenameGroup -win $_nWave3 {u_robot_model/u_robot_model-2} {Unload Start}
wvSetPosition -win $_nWave3 {("u_robot_model" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 0)}
wvAddSubGroup -win $_nWave3 {u_robot_model-3}
wvRenameGroup -win $_nWave3 {u_robot_model/u_robot_model-3} {Unload Done}
wvSelectGroup -win $_nWave3 {u_robot_model/Unload Done}
wvSelectGroup -win $_nWave3 {u_robot_model/Unload Start}
wvSetPosition -win $_nWave3 {("u_robot_model/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 3)}
wvSetPosition -win $_nWave3 {("u_robot_model" 4)}
wvSetPosition -win $_nWave3 {("u_robot_model/Request" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 6)}
wvSetPosition -win $_nWave3 {("u_robot_model" 7)}
wvSetPosition -win $_nWave3 {("u_robot_model" 8)}
wvSetPosition -win $_nWave3 {("u_robot_model" 9)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("u_robot_model/Unload Start" 0)}
wvSelectGroup -win $_nWave3 {u_robot_model/Unload Done}
wvSetPosition -win $_nWave3 {("u_robot_model" 2)}
wvSetPosition -win $_nWave3 {("u_robot_model" 3)}
wvSetPosition -win $_nWave3 {("u_robot_model/Request" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 5)}
wvSetPosition -win $_nWave3 {("u_robot_model" 6)}
wvSetPosition -win $_nWave3 {("u_robot_model" 8)}
wvSetPosition -win $_nWave3 {("u_robot_model/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 10)}
wvSetPosition -win $_nWave3 {("u_robot_model" 11)}
wvSetPosition -win $_nWave3 {("u_robot_model" 12)}
wvSetPosition -win $_nWave3 {("u_robot_model" 13)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("u_robot_model/Unload Done" 0)}
wvSelectSignal -win $_nWave3 {( "u_robot_model" 18 )} 
wvSetPosition -win $_nWave3 {("u_robot_model" 17)}
wvSetPosition -win $_nWave3 {("u_robot_model" 16)}
wvSetPosition -win $_nWave3 {("u_robot_model" 15)}
wvSetPosition -win $_nWave3 {("u_robot_model" 14)}
wvSetPosition -win $_nWave3 {("u_robot_model/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 12)}
wvSetPosition -win $_nWave3 {("u_robot_model" 11)}
wvSetPosition -win $_nWave3 {("u_robot_model" 10)}
wvSetPosition -win $_nWave3 {("u_robot_model" 9)}
wvSetPosition -win $_nWave3 {("u_robot_model/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 7)}
wvSetPosition -win $_nWave3 {("u_robot_model" 6)}
wvSetPosition -win $_nWave3 {("u_robot_model" 5)}
wvSetPosition -win $_nWave3 {("u_robot_model" 4)}
wvSetPosition -win $_nWave3 {("u_robot_model/Request" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 2)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("u_robot_model" 2)}
wvSetPosition -win $_nWave3 {("u_robot_model" 3)}
wvSelectGroup -win $_nWave3 {G2}
wvSelectGroup -win $_nWave3 {G2/G2-1}
wvSelectGroup -win $_nWave3 {G2}
wvSelectSignal -win $_nWave3 {( "u_robot_model" 18 )} 
wvSelectSignal -win $_nWave3 {( "u_robot_model" 18 )} 
wvSelectGroup -win $_nWave3 {G2}
wvGetSignalOpen -win $_nWave3
wvGetSignalSetScope -win $_nWave3 "/robot_model_tb"
wvGetSignalSetScope -win $_nWave3 "/robot_model_tb/u_robot_model"
wvGetSignalSetScope -win $_nWave3 "/robot_model_tb"
wvGetSignalSetScope -win $_nWave3 "/robot_model_tb/u_robot_model"
wvSetPosition -win $_nWave3 {("u_robot_model" 13)}
wvSetPosition -win $_nWave3 {("u_robot_model" 13)}
wvAddSignal -win $_nWave3 -clear
wvAddSignal -win $_nWave3 -group {"u_robot_model" \
{/robot_model_tb/u_robot_model/clock} \
{/robot_model_tb/u_robot_model/reset_n} \
{/robot_model_tb/u_robot_model/load_start} \
{/robot_model_tb/u_robot_model/curr_state\[1:0\]} \
{/robot_model_tb/u_robot_model/load_cstate\[1:0\]} \
{/robot_model_tb/u_robot_model/load_done_int} \
{/robot_model_tb/u_robot_model/load_nstate\[1:0\]} \
{/robot_model_tb/u_robot_model/next_state\[1:0\]} \
{/robot_model_tb/u_robot_model/s0ors2_req} \
{/robot_model_tb/u_robot_model/s1ors3_req} \
{/robot_model_tb/u_robot_model/unload_cstate\[1:0\]} \
{/robot_model_tb/u_robot_model/unload_done} \
{/robot_model_tb/u_robot_model/unload_nstate\[1:0\]} \
}
wvAddSignal -win $_nWave3 -group {"u_robot_model/Request" \
}
wvAddSignal -win $_nWave3 -group {"u_robot_model" {/robot_model_tb/u_robot_model/s0_req} \
{/robot_model_tb/u_robot_model/s1_req} \
{/robot_model_tb/u_robot_model/s2_req} \
{/robot_model_tb/u_robot_model/s3_req} \
}
wvAddSignal -win $_nWave3 -group {"u_robot_model/Unload Start" \
}
wvAddSignal -win $_nWave3 -group {"u_robot_model" {/robot_model_tb/u_robot_model/s0_unloadstart} \
{/robot_model_tb/u_robot_model/s1_unloadstart} \
{/robot_model_tb/u_robot_model/s2_unloadstart} \
{/robot_model_tb/u_robot_model/s3_unloadstart} \
}
wvAddSignal -win $_nWave3 -group {"u_robot_model/Unload Done" \
}
wvAddSignal -win $_nWave3 -group {"u_robot_model" {/robot_model_tb/u_robot_model/s0_unload_done} \
{/robot_model_tb/u_robot_model/s1_unload_done} \
{/robot_model_tb/u_robot_model/s2_unload_done} \
{/robot_model_tb/u_robot_model/s3_unload_done} \
}
wvAddSignal -win $_nWave3 -group {"G2" \
}
wvAddSignal -win $_nWave3 -group {"G2/G2-1" \
}
wvAddSignal -win $_nWave3 -group {"G3" \
}
wvSelectSignal -win $_nWave3 {( "u_robot_model" 4 5 6 7 8 9 10 11 12 13 )} 
wvSetPosition -win $_nWave3 {("u_robot_model" 13)}
wvGetSignalClose -win $_nWave3
wvScrollUp -win $_nWave3 7
wvSetPosition -win $_nWave3 {("u_robot_model" 4)}
wvSetPosition -win $_nWave3 {("u_robot_model" 5)}
wvSetPosition -win $_nWave3 {("u_robot_model" 6)}
wvSetPosition -win $_nWave3 {("u_robot_model" 7)}
wvSetPosition -win $_nWave3 {("u_robot_model" 8)}
wvSetPosition -win $_nWave3 {("u_robot_model" 9)}
wvSetPosition -win $_nWave3 {("u_robot_model" 10)}
wvSetPosition -win $_nWave3 {("u_robot_model" 11)}
wvSetPosition -win $_nWave3 {("u_robot_model" 12)}
wvSetPosition -win $_nWave3 {("u_robot_model" 13)}
wvSetPosition -win $_nWave3 {("u_robot_model/Request" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 15)}
wvSetPosition -win $_nWave3 {("u_robot_model" 16)}
wvSetPosition -win $_nWave3 {("u_robot_model" 17)}
wvSetPosition -win $_nWave3 {("u_robot_model" 18)}
wvSetPosition -win $_nWave3 {("u_robot_model/Unload Start" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 20)}
wvSetPosition -win $_nWave3 {("u_robot_model" 21)}
wvSetPosition -win $_nWave3 {("u_robot_model" 22)}
wvSetPosition -win $_nWave3 {("u_robot_model" 23)}
wvSetPosition -win $_nWave3 {("u_robot_model/Unload Done" 0)}
wvSetPosition -win $_nWave3 {("u_robot_model" 25)}
wvSetPosition -win $_nWave3 {("u_robot_model" 26)}
wvSetPosition -win $_nWave3 {("u_robot_model" 13)}
wvSetPosition -win $_nWave3 {("u_robot_model" 27)}
wvSetPosition -win $_nWave3 {("u_robot_model" 28)}
wvSetPosition -win $_nWave3 {("G2" 0)}
wvSetPosition -win $_nWave3 {("G2/G2-1" 0)}
wvSetPosition -win $_nWave3 {("G3" 0)}
wvSetPosition -win $_nWave3 {("G2/G2-1" 0)}
wvSetPosition -win $_nWave3 {("G2" 0)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("G2" 10)}
wvSelectGroup -win $_nWave3 {G2/G2-1}
wvCut -win $_nWave3
wvSetPosition -win $_nWave3 {("G2" 10)}
wvSelectGroup -win $_nWave3 {G3}
wvCut -win $_nWave3
wvSetPosition -win $_nWave3 {("G2" 10)}
wvSetPosition -win $_nWave3 {("G2" 10)}
wvScrollUp -win $_nWave3 5
wvScrollUp -win $_nWave3 1
wvScrollUp -win $_nWave3 1
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvSelectSignal -win $_nWave3 {( "u_robot_model" 1 )} 
wvSetCursor -win $_nWave3 20212.435471 -snap {("u_robot_model" 1)}
wvSetCursor -win $_nWave3 17542.868522 -snap {("u_robot_model" 1)}
srcActiveTrace "robot_model_tb.u_robot_model.clock" -TraceByDConWave -TraceTime \
           10000 -TraceValue 1 -win $_nTrace1
wvSetCursor -win $_nWave3 17476.804998 -snap {("u_robot_model" 1)}
wvSelectGroup -win $_nWave3 {u_robot_model}
wvSelectSignal -win $_nWave3 {( "u_robot_model" 1 )} 
wvSelectSignal -win $_nWave3 {( "u_robot_model" 1 )} 
verdiQtPrefEnv -show
verdiQtPrefEnv -setCurPg "Waveform"
verdiQtPrefEnv -cancel
srcDeselectAll -win $_nTrace1
srcSelect -signal "clock" -line 16 -pos 1 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvScrollDown -win $_nWave3 4
wvScrollDown -win $_nWave3 2
wvScrollDown -win $_nWave3 0
wvSelectGroup -win $_nWave3 {G2}
verdiSetActWin -win $_nWave3
wvRenameGroup -win $_nWave3 {G2} {FSM States}
wvSelectSignal -win $_nWave3 {( "FSM States" 3 )} 
wvSelectGroup -win $_nWave3 {FSM States}
wvSelectSignal -win $_nWave3 {( "FSM States" 8 )} 
wvSelectSignal -win $_nWave3 {( "FSM States" 8 )} 
wvSelectSignal -win $_nWave3 {( "FSM States" 9 )} 
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvSetPosition -win $_nWave3 {("FSM States" 10)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM States" 10)}
wvSelectSignal -win $_nWave3 {( "FSM States" 5 )} 
wvSetPosition -win $_nWave3 {("FSM States" 4)}
wvSetPosition -win $_nWave3 {("FSM States" 3)}
wvSetPosition -win $_nWave3 {("FSM States" 2)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM States" 2)}
wvSetPosition -win $_nWave3 {("FSM States" 3)}
wvSelectSignal -win $_nWave3 {( "FSM States" 5 )} 
wvSetPosition -win $_nWave3 {("FSM States" 4)}
wvSetPosition -win $_nWave3 {("FSM States" 3)}
wvSetPosition -win $_nWave3 {("FSM States" 2)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM States" 2)}
wvSetPosition -win $_nWave3 {("FSM States" 3)}
wvSelectSignal -win $_nWave3 {( "FSM States" 4 )} 
wvSetPosition -win $_nWave3 {("FSM States" 2)}
wvSetPosition -win $_nWave3 {("FSM States" 1)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM States" 1)}
wvSetPosition -win $_nWave3 {("FSM States" 2)}
wvSelectSignal -win $_nWave3 {( "FSM States" 6 )} 
wvSelectSignal -win $_nWave3 {( "FSM States" 5 )} 
wvSelectSignal -win $_nWave3 {( "FSM States" 6 )} 
wvSetPosition -win $_nWave3 {("FSM States" 6)}
wvSetPosition -win $_nWave3 {("FSM States" 7)}
wvSetPosition -win $_nWave3 {("FSM States" 8)}
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvSelectSignal -win $_nWave3 {( "FSM States" 6 )} 
wvSetPosition -win $_nWave3 {("FSM States" 6)}
wvSetPosition -win $_nWave3 {("FSM States" 7)}
wvSetPosition -win $_nWave3 {("FSM States" 8)}
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvMoveSelected -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM States" 9)}
schCreateWindow -win $_nSchema1 -hierFlatten
verdiSetActWin -win $_nSchema_4
schSelect -win $_nSchema4 -inst "robot_model_tb.u_robot_model"
schPushViewIn -win $_nSchema4
schCreateWindow -delim "." -win $_nSchema1 -scope "robot_model_tb"
verdiSetActWin -win $_nSchema_5
schSelect -win $_nSchema5 -inst "u_robot_model"
schPushViewIn -win $_nSchema5
verdiSetActWin -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
wvZoomOut -win $_nWave3
wvSelectGroup -win $_nWave3 {G3}
wvCut -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvSetPosition -win $_nWave3 {("FSM States" 10)}
wvSetPosition -win $_nWave3 {("FSM States" 10)}
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvSelectSignal -win $_nWave3 {( "FSM States" 10 )} 
wvSelectGroup -win $_nWave3 {G3}
wvCut -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvSetPosition -win $_nWave3 {("FSM States" 10)}
wvSetPosition -win $_nWave3 {("FSM States" 10)}
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvSelectSignal -win $_nWave3 {( "FSM States" 10 )} 
wvSelectGroup -win $_nWave3 {G3}
wvCut -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvSetPosition -win $_nWave3 {("FSM States" 10)}
wvSetPosition -win $_nWave3 {("FSM States" 10)}
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvScrollDown -win $_nWave3 0
wvScrollDown -win $_nWave3 0
wvSelectGroup -win $_nWave3 {G3}
wvCut -win $_nWave3
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvSetPosition -win $_nWave3 {("FSM States" 10)}
wvSetPosition -win $_nWave3 {("FSM States" 10)}
wvSetPosition -win $_nWave3 {("FSM States" 9)}
wvSelectGroup -win $_nWave3 {G3}
verdiSetActWin -win $_nSchema_5
verdiWindowResize -win $_Verdi_1 "1280" "0" "1279" "1411"
verdiSetActWin -win $_nWave3
wvSaveSignal -win $_nWave3 \
           "/home/xmen-aluno/CI-EXPERT-UVM/workspace/labs/s6/prj/robot/work/robot_signals_tb_simple.rc"
nsMsgSwitchTab -tab general


