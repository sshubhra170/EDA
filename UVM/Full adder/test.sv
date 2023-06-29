class adder_test extends uvm_test;

  `uvm_component_utils(adder_test)
  
  //Instantiate
  adder_env env;
  adder_sequence seq;
  
  function new (string name = "adder_test",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
 
  function void build_phase(uvm_phase phase);
    env = adder_env::type_id::create("env",this);
    seq = adder_sequence::type_id::create("seq",this);
  endfunction
  
  //start_of_simulation
  function void start_of_simulation_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
  
  //run_phase
  task run_phase(uvm_phase phase);
    $display("This is test build_phase");
     phase.raise_objection(this);
    repeat(10)
      begin
        #3;             
        seq.start(env.agent.sequencer);
      end
     #50;
     phase.drop_objection(this);
        
  endtask
  
endclass
