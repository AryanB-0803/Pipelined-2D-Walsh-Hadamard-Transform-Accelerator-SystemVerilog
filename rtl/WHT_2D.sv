module WHT_twoD #(
  parameter int Rows = 8,
  parameter int Cols = 8,
  parameter int DataWidth = 8,
  parameter int Points = 8
)(
  input  logic clk, rst,
  input  logic signed [DataWidth-1:0] x_in [Rows][Cols],
  //its 2*$clog(Points) because its 2D so its actually like
  //$clog2(Points^2) which will become 2*$clog2(Points) by applying log
  //properties
  output logic signed [DataWidth+2*$clog2(Points)+1:0] out [Rows][Cols]
);

logic signed [DataWidth+$clog2(Points):0] out_inter [Rows][Cols];
logic signed [DataWidth+$clog2(Points):0] transpose [Cols][Rows];

genvar i;
generate
  for(i = 0; i < Rows; i++) begin : gen_row_wht
    WHT_oneD #(
      .DataWidth(DataWidth),
      .Points(Points)
    ) inst_row (
      .clk(clk),
      .rst(rst),
      .in(x_in[i]),
      .out(out_inter[i])
    );
  end
endgenerate


//transpose matrix so that i can apply wht of the wht done rows to columns
genvar k,l;
generate
  for(k=0; k<Rows; k++) begin : gen_cols
    for(l=0; l<Cols; l++) begin : gen_rows
      assign transpose[l][k] = out_inter[k][l];
    end
  end
endgenerate


genvar j, m;
generate
  //i will need another matrix because in reality i have to apply
  //the row WHT to the columns of the transpose matrix...ill then assign
  //these to proper rows and columns of out matrix
  logic signed [DataWidth+2*$clog2(Points)+1:0] col_out [Cols][Rows];
  for(j=0; j<Cols; j++) begin : gen_col_wht
    WHT_oneD #(
      .DataWidth(DataWidth+$clog2(Points)+1),
      .Points(Points)
    ) inst_col (
      .clk(clk),
      .rst(rst),
      .in(transpose[j]),
      .out(col_out[j])
    );
  end
  for(j=0; j<Cols; j++) begin : gen_out_cols
    for(m=0; m<Rows; m++) begin : gen_out_rows
      assign out[m][j] = col_out[j][m];
    end
  end
endgenerate

endmodule
