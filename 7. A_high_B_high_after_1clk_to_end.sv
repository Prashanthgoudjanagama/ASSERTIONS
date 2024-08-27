//Write an assertion to detect if signal “A” is high on a given positive clock edge,then signal “B” will be high eventually starting from the next clock cycle.

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
    A |-> ##[1:$] B; 
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
