`timescale 1ns/1ns

module Basic_assertion_for_AB;
  bit clk;
  bit rst;
  bit A, B;
  
  initial begin
    clk = 1'b0;
    rst = 1'b0;
    #10;
    rst = 1'b1;
  end
  
  always #5 clk = ~clk;
  
  initial begin
    repeat(10) begin
      @(posedge clk);
      A = $random;
      B = $random;
    end
  end
  
  sequence seq;
    A&B;
  endsequence
  
  property prop();
    @(posedge clk) disable iff(!rst)
    seq;
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
