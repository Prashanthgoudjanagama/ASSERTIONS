`timescale 1ns/1ns

module same_cycle_implication_operator;
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
    A |-> B; 
  endproperty
  
  assert property(prop)
    $display("assertion passed : %0t", $time);
  
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #100;
    $finish;
  end
  
endmodule