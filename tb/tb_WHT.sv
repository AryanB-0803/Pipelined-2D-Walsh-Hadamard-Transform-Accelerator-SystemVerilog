module tb_wht2d;

  parameter Rows = 4;
  parameter Cols = 4;
  parameter DataWidth = 8;
  parameter Points = 4;

  logic clk, rst;

 
  logic signed [DataWidth-1:0] x_in  [Rows][Cols];
  logic signed [DataWidth+2*$clog2(Points)+1:0] out [Rows][Cols];

  // DUT
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

    // Input matrix
    // [1 2 3 4
    //  5 6 7 8
    //  9 10 11 12
    //  13 14 15 16]

    x_in[0][0]=1;  x_in[0][1]=2;  x_in[0][2]=3;  x_in[0][3]=4;
    x_in[1][0]=5;  x_in[1][1]=6;  x_in[1][2]=7;  x_in[1][3]=8;
    x_in[2][0]=9;  x_in[2][1]=10; x_in[2][2]=11; x_in[2][3]=12;
    x_in[3][0]=13; x_in[3][1]=14; x_in[3][2]=15; x_in[3][3]=16;

    #10 rst = 0;

    repeat(10) @(posedge clk);

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
