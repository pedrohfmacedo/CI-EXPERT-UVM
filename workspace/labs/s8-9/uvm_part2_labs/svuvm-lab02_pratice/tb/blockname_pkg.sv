package blockname_pkg;
  
  // uvm
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // own
  // `include "tests/blockname_test_baseline.svh"
  // `include "env/blockname_env_cfg.svh"
  // `include "env/blockname_enviroment.svh"
  // `include "env/blockname_scoreboard.svh"
  // `include "env/blockname_subscriber.svh"
  // `include "IFa_agent/Driver_A.svh"
  // `include "IFa_agent/IFa_agent.svh"
  // `include "IFa_agent/Monitor_A.svh"
  // `include "IFa_agent/Sequencer_A.svh"
  // `include "IFb_agent/Driver_B.svh"
  // `include "IFb_agent/IFb_agent.svh"
  // `include "IFb_agent/Monitor_B.svh"
  // `include "IFb_agent/Sequencer_B.svh"

  `include "IFb_agent/blockname_IFb_agent_cfg.svh"
  `include "IFb_agent/Sequencer_B.svh"
  `include "IFb_agent/Monitor_B.svh"
  `include "IFb_agent/Driver_B.svh"
  `include "IFb_agent/IFb_agent.svh"

  `include "IFa_agent/blockname_IFa_agent_cfg.svh"
  `include "IFa_agent/Sequencer_A.svh"
  `include "IFa_agent/Monitor_A.svh"
  `include "IFa_agent/Driver_A.svh"
  `include "IFa_agent/IFa_agent.svh"

  `include "env/blockname_env_cfg.svh"
  `include "env/blockname_scoreboard.svh"
  `include "env/blockname_subscriber.svh"
  `include "env/blockname_enviroment.svh"

  `include "tests/blockname_test_baseline.svh"

endpackage