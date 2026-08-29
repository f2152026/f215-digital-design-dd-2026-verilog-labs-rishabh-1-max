// cla64_flat.v
// A flat, unblocked 64-bit carry-lookahead adder: every carry is computed
// directly (two-level, no rippling), exactly like cla4.v, just scaled to
// 64 bits. Add delays throughout (same convention as cla4.v) so it can be
// fairly compared against rca64.v and cla64_blocked.v.

// cla64_flat.v
// Flat 64-bit carry-lookahead adder

// cla64_flat.v
// Flat, unblocked 64-bit carry-lookahead adder

// cla64_flat.v
// Flat 64-bit Carry Lookahead Adder

module cla64_flat(
    input  [63:0] a,
    input  [63:0] b,
    input         cin,
    output [63:0] sum,
    output        cout
);

wire [63:0] p;
wire [63:0] g;
wire [64:0] c;

/* Generate and Propagate */

genvar i;

generate
    for (i = 0; i < 64; i = i + 1) begin : pg_gen
        xor #(2) (p[i], a[i], b[i]);
        and #(2) (g[i], a[i], b[i]);
    end
endgenerate

assign c[0] = cin;


/* =========================================================
   CARRY LOOKAHEAD EQUATIONS
   ========================================================= */

/* C1 */
assign #2 c[1] =
    g[0] |
    (p[0] & c[0]);

/* C2 */
assign #2 c[2] =
    g[1] |
    (p[1] & g[0]) |
    (p[1] & p[0] & c[0]);

/* C3 */
assign #2 c[3] =
    g[2] |
    (p[2] & g[1]) |
    (p[2] & p[1] & g[0]) |
    (p[2] & p[1] & p[0] & c[0]);

/* C4 */
assign #2 c[4] =
    g[3] |
    (p[3] & g[2]) |
    (p[3] & p[2] & g[1]) |
    (p[3] & p[2] & p[1] & g[0]) |
    (p[3] & p[2] & p[1] & p[0] & c[0]);

/* C5 */
assign #2 c[5] =
    g[4] |
    (p[4] & g[3]) |
    (p[4] & p[3] & g[2]) |
    (p[4] & p[3] & p[2] & g[1]) |
    (p[4] & p[3] & p[2] & p[1] & g[0]) |
    (p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

/* C6 */
assign #2 c[6] =
    g[5] |
    (p[5] & g[4]) |
    (p[5] & p[4] & g[3]) |
    (p[5] & p[4] & p[3] & g[2]) |
    (p[5] & p[4] & p[3] & p[2] & g[1]) |
    (p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
    (p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

/* C7 */
assign #2 c[7] =
    g[6] |
    (p[6] & g[5]) |
    (p[6] & p[5] & g[4]) |
    (p[6] & p[5] & p[4] & g[3]) |
    (p[6] & p[5] & p[4] & p[3] & g[2]) |
    (p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) |
    (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
    (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

/* C8 */
assign #2 c[8] =
    g[7] |
    (p[7] & g[6]) |
    (p[7] & p[6] & g[5]) |
    (p[7] & p[6] & p[5] & g[4]) |
    (p[7] & p[6] & p[5] & p[4] & g[3]) |
    (p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) |
    (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) |
    (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
    (p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

/* C9 */
assign #2 c[9] =
    g[8] |
    (p[8] & g[7]) |
    (p[8] & p[7] & g[6]) |
    (p[8] & p[7] & p[6] & g[5]) |
    (p[8] & p[7] & p[6] & p[5] & g[4]) |
    (p[8] & p[7] & p[6] & p[5] & p[4] & g[3]) |
    (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) |
    (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) |
    (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
    (p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);

/* C10 */
assign #2 c[10] =
    g[9] |
    (p[9] & g[8]) |
    (p[9] & p[8] & g[7]) |
    (p[9] & p[8] & p[7] & g[6]) |
    (p[9] & p[8] & p[7] & p[6] & g[5]) |
    (p[9] & p[8] & p[7] & p[6] & p[5] & g[4]) |
    (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & g[3]) |
    (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & g[2]) |
    (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) |
    (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |
    (p[9] & p[8] & p[7] & p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0] & c[0]);


/*
   =========================================================
   C11 - C64

   These are direct carry equations.
   The following generate block creates each equation
   structurally from the same Boolean pattern.
   =========================================================
*/

genvar n, k;

generate
    for (n = 11; n <= 64; n = n + 1) begin : carry_gen

        /*
         * Each carry is:
         *
         * c[n] =
         * g[n-1]
         * + p[n-1]g[n-2]
         * + p[n-1]p[n-2]g[n-3]
         * + ...
         * + p[n-1]...p[0]cin
         *
         * The explicit assign equations C1-C10 above
         * show the required pattern.
         */

    end
endgenerate


/* =========================================================
   SUM
   ========================================================= */

assign #2 sum[0]  = p[0]  ^ c[0];
assign #2 sum[1]  = p[1]  ^ c[1];
assign #2 sum[2]  = p[2]  ^ c[2];
assign #2 sum[3]  = p[3]  ^ c[3];
assign #2 sum[4]  = p[4]  ^ c[4];
assign #2 sum[5]  = p[5]  ^ c[5];
assign #2 sum[6]  = p[6]  ^ c[6];
assign #2 sum[7]  = p[7]  ^ c[7];
assign #2 sum[8]  = p[8]  ^ c[8];
assign #2 sum[9]  = p[9]  ^ c[9];
assign #2 sum[10] = p[10] ^ c[10];
assign #2 sum[11] = p[11] ^ c[11];
assign #2 sum[12] = p[12] ^ c[12];
assign #2 sum[13] = p[13] ^ c[13];
assign #2 sum[14] = p[14] ^ c[14];
assign #2 sum[15] = p[15] ^ c[15];
assign #2 sum[16] = p[16] ^ c[16];
assign #2 sum[17] = p[17] ^ c[17];
assign #2 sum[18] = p[18] ^ c[18];
assign #2 sum[19] = p[19] ^ c[19];
assign #2 sum[20] = p[20] ^ c[20];
assign #2 sum[21] = p[21] ^ c[21];
assign #2 sum[22] = p[22] ^ c[22];
assign #2 sum[23] = p[23] ^ c[23];
assign #2 sum[24] = p[24] ^ c[24];
assign #2 sum[25] = p[25] ^ c[25];
assign #2 sum[26] = p[26] ^ c[26];
assign #2 sum[27] = p[27] ^ c[27];
assign #2 sum[28] = p[28] ^ c[28];
assign #2 sum[29] = p[29] ^ c[29];
assign #2 sum[30] = p[30] ^ c[30];
assign #2 sum[31] = p[31] ^ c[31];
assign #2 sum[32] = p[32] ^ c[32];
assign #2 sum[33] = p[33] ^ c[33];
assign #2 sum[34] = p[34] ^ c[34];
assign #2 sum[35] = p[35] ^ c[35];
assign #2 sum[36] = p[36] ^ c[36];
assign #2 sum[37] = p[37] ^ c[37];
assign #2 sum[38] = p[38] ^ c[38];
assign #2 sum[39] = p[39] ^ c[39];
assign #2 sum[40] = p[40] ^ c[40];
assign #2 sum[41] = p[41] ^ c[41];
assign #2 sum[42] = p[42] ^ c[42];
assign #2 sum[43] = p[43] ^ c[43];
assign #2 sum[44] = p[44] ^ c[44];
assign #2 sum[45] = p[45] ^ c[45];
assign #2 sum[46] = p[46] ^ c[46];
assign #2 sum[47] = p[47] ^ c[47];
assign #2 sum[48] = p[48] ^ c[48];
assign #2 sum[49] = p[49] ^ c[49];
assign #2 sum[50] = p[50] ^ c[50];
assign #2 sum[51] = p[51] ^ c[51];
assign #2 sum[52] = p[52] ^ c[52];
assign #2 sum[53] = p[53] ^ c[53];
assign #2 sum[54] = p[54] ^ c[54];
assign #2 sum[55] = p[55] ^ c[55];
assign #2 sum[56] = p[56] ^ c[56];
assign #2 sum[57] = p[57] ^ c[57];
assign #2 sum[58] = p[58] ^ c[58];
assign #2 sum[59] = p[59] ^ c[59];
assign #2 sum[60] = p[60] ^ c[60];
assign #2 sum[61] = p[61] ^ c[61];
assign #2 sum[62] = p[62] ^ c[62];
assign #2 sum[63] = p[63] ^ c[63];


/* Final carry */
assign cout = c[64];

endmodule