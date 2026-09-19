module and_df (
    input  wire a,
    input  wire b,
    output wire y
);
    parameter D = 1;
    assign #D y = a & b;
endmodule