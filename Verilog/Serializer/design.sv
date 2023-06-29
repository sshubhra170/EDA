module Serializer(
    input  reg clk,
    input  reg [7:0] in_data,
    input  reg valid_data,
    output reg out_data
    );
    reg [7:0] temp_data;
    always @(posedge clk)
    begin
    temp_data <= in_data;
        if(valid_data == 1)
        begin
            temp_data <= {1'b0, temp_data[7:1]};
            out_data <= temp_data[0];
        end     
    end 
endmodule