module and_beh_before (
    input  wire a,
    input  wire b,
    output reg  y
);
    parameter D = 1;
    always @(*) begin
        #D y = a & b;
    end
endmodule