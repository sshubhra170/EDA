class adder_env extends uvm_env;

  adder_agent agent;
  adder_sequence seq;
  `uvm_component_utils(adder_env)
    
  //constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build_phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = adder_agent::type_id::create("agent", this);
  endfunction : build_phase

endclass : adder_env