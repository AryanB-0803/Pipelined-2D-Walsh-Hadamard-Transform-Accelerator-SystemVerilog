module tb_wht2d;

  parameter Rows = 8;
  parameter Cols = 8;
  parameter DataWidth = 8;
  parameter Points = 8;

  logic clk, rst;

  logic signed [DataWidth-1:0] x_in  [Rows][Cols];
  logic signed [DataWidth+2*$clog2(Points)+1:0] out [Rows][Cols];

  WHT_twoD #(
    .Rows(Rows),
    .Cols(Cols),
    .DataWidth(DataWidth),
    .Points(Points)
  ) dut (
    .clk(clk),
    .rst(rst),
    .x_in(x_in),
    .out(out)
  );

  // clock
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst = 1;

    //got all these inputs from my python script
    x_in[0][0] = -8'sd4; x_in[0][1] = 8'sd31; x_in[0][2] = 8'sd12; x_in[0][3] = 8'sd12; x_in[0][4] = 8'sd25; x_in[0][5] = 8'sd1; x_in[0][6] = 8'sd0; x_in[0][7] = 8'sd6; 
x_in[1][0] = 8'sd27; x_in[1][1] = 8'sd22; x_in[1][2] = 8'sd22; x_in[1][3] = 8'sd44; x_in[1][4] = 8'sd40; x_in[1][5] = 8'sd59; x_in[1][6] = 8'sd24; x_in[1][7] = -8'sd38; 
x_in[2][0] = -8'sd3; x_in[2][1] = 8'sd48; x_in[2][2] = 8'sd39; x_in[2][3] = 8'sd30; x_in[2][4] = 8'sd42; x_in[2][5] = 8'sd39; x_in[2][6] = 8'sd53; x_in[2][7] = 8'sd57; 
x_in[3][0] = 8'sd55; x_in[3][1] = 8'sd43; x_in[3][2] = -8'sd12; x_in[3][3] = -8'sd37; x_in[3][4] = 8'sd22; x_in[3][5] = 8'sd62; x_in[3][6] = 8'sd34; x_in[3][7] = 8'sd13; 
x_in[4][0] = -8'sd44; x_in[4][1] = -8'sd54; x_in[4][2] = -8'sd18; x_in[4][3] = 8'sd40; x_in[4][4] = 8'sd40; x_in[4][5] = 8'sd10; x_in[4][6] = -8'sd25; x_in[4][7] = 8'sd51; 
x_in[5][0] = -8'sd6; x_in[5][1] = 8'sd48; x_in[5][2] = 8'sd46; x_in[5][3] = 8'sd3; x_in[5][4] = -8'sd10; x_in[5][5] = -8'sd52; x_in[5][6] = 8'sd24; x_in[5][7] = -8'sd4; 
x_in[6][0] = -8'sd2; x_in[6][1] = -8'sd2; x_in[6][2] = -8'sd74; x_in[6][3] = -8'sd57; x_in[6][4] = -8'sd52; x_in[6][5] = 8'sd6; x_in[6][6] = 8'sd39; x_in[6][7] = 8'sd5; 
x_in[7][0] = -8'sd69; x_in[7][1] = -8'sd18; x_in[7][2] = 8'sd16; x_in[7][3] = -8'sd7; x_in[7][4] = 8'sd23; x_in[7][5] = 8'sd31; x_in[7][6] = -8'sd43; x_in[7][7] = -8'sd61; 

    #10 rst = 0;

    //i have to wait long enuf for the outputs to be visible more in the
    //waveform
    repeat(40) @(posedge clk);

    $display("\n2D WHT Output:\n");

    for (int i = 0; i < Rows; i++) begin
      for (int j = 0; j < Cols; j++) begin
        $write("%0d\t", out[i][j]);
      end
      $write("\n");
    end

    repeat(40) @(posedge clk);
    $finish;
  end

endmodule
