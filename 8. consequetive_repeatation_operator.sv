//Write an assertion to detect if signal “A” is high on given posedge of the clock, the signal “B” should be high for 3 consecutive clock cycles.

`timescale 1ns/1ns

module tb;
  bit clk = 1'b0;
  bit rst = 1'b0;
  
  bit A, B;
  
  initial #2 rst = 1'b1;
  always #5 clk = ~clk;
  
  initial begin
    repeat(100) begin
      @(posedge clk);
      A = $random;
      B = $random;
    end
  end
  
  property prop();
    @(posedge clk) disable iff(!rst)
    A |-> B[*3]; 
  endproperty
  
  assert property(prop)
    $display("assertion passed : %0t", $time);
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #200;
    $finish;
  end
  
endmodule
