package blockname_pkg;
  
  // uvm
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // transactions
  `include "blockname_seq_item.svh"
  `include "sequences/seq.svh"

  // agent interface a
  `include "ifa_agent/ifa_sequencer.svh"
  `include "ifa_agent/ifa_driver.svh"
  `include "ifa_agent/ifa_monitor.svh"
  `include "ifa_agent/ifa_agent.svh"

  // agent interface b
  `include "ifb_agent/ifb_sequencer.svh"
  `include "ifb_agent/ifb_driver.svh"
  `include "ifb_agent/ifb_monitor.svh"
  `include "ifb_agent/ifb_agent.svh"

  // env level
  `include "env/blockname_env_config.svh"
  `include "env/blockname_scb.svh"
  `include "env/blockname_sub.svh"
  `include "env/blockname_env.svh"

  // tests
  `include "tests/blockname_test_baseline.svh"
endpackage