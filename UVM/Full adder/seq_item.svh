class adder_seq_item extends uvm_sequence_item;
   rand bit a;
   rand bit b;
   rand bit c;
   bit sum;
   bit carry;
	
   `uvm_object_utils_begin(adder_seq_item) 
  `uvm_field_int(a,UVM_ALL_ON);
  `uvm_field_int(b,UVM_ALL_ON);
  `uvm_field_int(c,UVM_ALL_ON);
   `uvm_object_utils_end

    //constructor	
   function new (string name="adder_seq_item");
      super.new(name);
   endfunction : new
	
//    constraint su{a inside{1'b0,1'b1};}
//    constraint so{b inside{1'b0,1'b1};}
//   constraint si{c inside{1'b0,1'b1};}
  
endclass : adder_seq_item
	