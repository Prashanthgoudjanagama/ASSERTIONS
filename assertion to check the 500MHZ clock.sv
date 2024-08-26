`timescale 1ns/1ps

module assertion_to_check_500MHZ_clock;
  bit clk;
  bit rst;

  initial begin
      clk = 1'b0;
      rst = 1'b0;
      #10;
      rst = 1'b1;
  end

  always #1 clk = ~clk;

  time clk_period = 1000.0/500.0ns;
  
  property prop(int clk_period);
    realtime current_time;
    @(posedge clk) disable iff(!rst)
    ('1,current_time = $realtime) |=> (clk_period == $realtime-current_time);
  endproperty

  assert property(prop(clk_period))
    $display("ASSERTION PASSED : %0t", $realtime);
  else
    $display("ASSERTION FAILED : %0t", $realtime);

  initial begin
      #100 $finish;
  end
endmodule
