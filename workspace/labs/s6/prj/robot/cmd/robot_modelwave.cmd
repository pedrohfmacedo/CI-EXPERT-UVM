simSetSimulator "-vcssv" -exec "work/./simv" -args " " -uvmDebug on
debImport "-i" "-simflow" "-dbdir" "work/./simv.daidir"
srcTBInvokeSim
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
wvCreateWindow
verdiSetActWin -win $_nWave3
srcHBDrag -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
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
wvZoomIn -win $_nWave3
wvZoomIn -win $_nWave3
verdiSetActWin -win $_nWave3
