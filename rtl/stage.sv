module stage #(parameter int Stage, int Points = 8, int DataWidth = 8)(
  input logic clk,rst,
  input logic signed [DataWidth-1:0]x1[Points],
  output logic signed [DataWidth:0]out[Points]
);

genvar i;
generate
  for(i=0; i<Points; i++) begin : gen_inst_pe
    //this particular logic is applied because i only
    //want to group the terms in a particular stage and i also
    //wanna make sure that the grouped ones dont get grouped again
    //so if must stay in the same group but also be less that 2^Stage
    //because only then will the stride i.e the step btw 2 indices
    //will work properly
    if((i%(1 << (Stage+1))) < (1 << Stage)) begin : gen_inst_pe
      butterfly_pe #(.DataWidth(DataWidth)) inst(
        .clk(clk),.rst(rst),
        .x1(x1[i]),.x2(x1[i+(1<<(Stage))]),
        .sum(out[i]), .diff(out[i+(1<<(Stage))]));
    end
  end
endgenerate
endmodule
