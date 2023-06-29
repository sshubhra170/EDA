class adder_sequencer extends uvm_sequencer#(adder_seq_item);
  `uvm_component_utils(adder_sequencer)
  
  function new(string name = "",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
endclass