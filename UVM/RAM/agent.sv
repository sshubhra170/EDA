class adder_agent extends uvm_agent;

  adder_driver    driver;
  adder_sequencer sequencer;
  adder_monitor   monitor;

  `uvm_component_utils(adder_agent)

  // constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build_phase
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      driver = adder_driver::type_id::create("driver", this);
      sequencer = adder_sequencer::type_id::create("sequencer", this);
	  monitor = adder_monitor::type_id::create("monitor", this);
   endfunction : build_phase

  // connect_phase
   function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
   endfunction : connect_phase

endclass : adder_agent