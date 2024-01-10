`timescale 10ns/10ps

`include "and2.v"
module testbench();
    reg a;
    reg b;
    wire y;

    and2 iand2(a, b, y);

    initial begin
        $display("hello world!");
        $monitor("a=%b, b=%b, y=%b", a, b, y);
        $dumpfile("testbench.vcd");
        $dumpvars(0, testbench);
        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish;
    end
    
endmodule