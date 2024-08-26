//Write an assertion to detect de-assertion of a signal A.
`timescale 1ns/1ns

module de_assert_A_signal;
  bit clk;
  bit rst;
  bit A;
  
  initial begin
    clk = 1'b0;
    rst = 1'b0;
    #5;
    rst = 1'b1;
  end
  
  always #5 clk = ~clk;
  
  initial begin
    repeat(10) begin
      @(posedge clk);
      A = $random;
    end
  end
  
  property prop();
    @(posedge clk) disable iff(!rst)
    $fell(A);
  endproperty
  
  assert property(prop)
    $display("assertion passed :: %0t", $time);
  else
    $display("assertion passed :: %0t", $time);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #100 $finish;
  end
  
endmodule
