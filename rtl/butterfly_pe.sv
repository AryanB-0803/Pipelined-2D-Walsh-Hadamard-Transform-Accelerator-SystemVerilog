module butterfly_pe #(parameter int DataWidth = 8)(
  input logic clk,rst,
  input logic signed [DataWidth-1:0]x1,x2,
  output logic signed [DataWidth:0]sum,diff //DataWidth and not DataWidth-1 because
  //every pe increases the output by one bit sum and diff can overflow
);

always_ff @(posedge clk or posedge rst) begin
  if(rst) begin
    sum <= '0;
    diff <= '0;
  end
  else begin
    sum <= x1 + x2;
    diff <= x1 - x2;
  end
end
endmodule 
