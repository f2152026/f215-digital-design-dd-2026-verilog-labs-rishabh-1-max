module and_beh_intra (
    input  wire a,
    input  wire b,
    output reg  y
);
    parameter D = 1;
    always @(*) begin
        y = #D (a & b);
    end
endmodule