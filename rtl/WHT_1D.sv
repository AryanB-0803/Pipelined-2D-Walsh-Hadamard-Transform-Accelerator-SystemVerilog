module WHT_oneD #(parameter int DataWidth = 8, int Points = 8)(
  input logic clk,rst,
  input logic signed [DataWidth-1:0]in[Points], //i could write [0:Points-1] also
  //but it throws a warning to use just [Points] thus only [Points]
  output logic signed [DataWidth+$clog2(Points):0]out[Points] //$clog2(N) because each stage
  //increase out by 1 bit so it shld be large enuf to hold all bits...for 8,
  //stages = 3, so 3 more bits will be added
);

//intermediate stage outs are being hardcoded because i hit too many problems
//with unpacked 2D array from iverilog and verilator which werent allowing me
//to use the parameterized design with 2D array thus just hardcoding it

logic signed [DataWidth:0]s0[Points];
logic signed [DataWidth+1:0]s1[Points];
logic signed [DataWidth+2:0]s2[Points];

//stage 0
stage #(.Stage(0),.DataWidth(DataWidth),.Points(Points)) inst0(.clk(clk), .rst(rst), .x1(in), .out(s0));

//stage 1
stage #(.Stage(1),.DataWidth(DataWidth+1),.Points(Points)) inst1(.clk(clk), .rst(rst), .x1(s0), .out(s1));

//stage 2
stage #(.Stage(2),.DataWidth(DataWidth+2),.Points(Points)) inst2(.clk(clk), .rst(rst), .x1(s1), .out(s2));

//even for assigning out i had to use generate loop and manual assign
genvar k;
generate
  for(k=0; k<Points; k++) begin : gen_out
    assign out[k] = s2[k];
end
endgenerate
endmodule
