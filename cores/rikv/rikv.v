// Generator : SpinalHDL v1.4.0    git head : ecb5a80b713566f417ea3ea061f9969e73770a7f
// Date      : 28/03/2021, 13:09:46
// Component : rikv



module InstructionFetch (
  input               io_instr_valid,
  input      [31:0]   io_instr,
  output              io_IfToId_instr_valid,
  output     [31:0]   io_IfToId_instr,
  input               io_IfToId_stall 
);

  assign io_IfToId_instr_valid = io_instr_valid;
  assign io_IfToId_instr = io_instr;

endmodule

module InstructionDecoder (
  input               io_IfToId_instr_valid,
  input      [31:0]   io_IfToId_instr,
  output              io_IfToId_stall,
  output     [31:0]   io_imm,
  output     [4:0]    io_rs1,
  output     [4:0]    io_rs2,
  output     [4:0]    io_rd,
  output              rvfi_valid,
  output     [63:0]   rvfi_order,
  output     [31:0]   rvfi_insn,
  output              rvfi_trap,
  output              rvfi_halt,
  output              rvfi_intr,
  output     [1:0]    rvfi_mode,
  output     [1:0]    rvfi_ixl,
  output     [4:0]    rvfi_rs1_addr,
  output     [4:0]    rvfi_rs2_addr,
  output     [31:0]   rvfi_rs1_rdata,
  output     [31:0]   rvfi_rs2_rdata,
  output     [4:0]    rvfi_rd_addr,
  output     [31:0]   rvfi_rd_wdata,
  output     [31:0]   rvfi_pc_rdata,
  output     [31:0]   rvfi_pc_wdata,
  output     [31:0]   rvfi_mem_addr,
  output     [3:0]    rvfi_mem_rmask,
  output     [3:0]    rvfi_mem_wmask,
  output     [31:0]   rvfi_mem_rdata,
  output     [31:0]   rvfi_mem_wdata,
  input               clk,
  input               reset 
);
  wire       [1:0]    _zz_9_;
  wire       [2:0]    _zz_10_;
  wire       [6:0]    opcode;
  wire       [4:0]    rd;
  wire       [2:0]    func3;
  wire       [4:0]    rs1;
  wire       [4:0]    rs2;
  wire       [6:0]    func7;
  wire       [9:0]    funccombined;
  wire                _zz_1_;
  reg        [19:0]   _zz_2_;
  wire       [31:0]   immI;
  wire                _zz_3_;
  reg        [19:0]   _zz_4_;
  wire       [31:0]   immS;
  wire                _zz_5_;
  reg        [17:0]   _zz_6_;
  wire       [29:0]   immB;
  wire       [31:0]   immU;
  wire                _zz_7_;
  reg        [10:0]   _zz_8_;
  wire       [30:0]   immJ;
  reg                 trap;
  wire                formal_rvfi_valid;
  wire       [63:0]   formal_rvfi_order;
  wire       [31:0]   formal_rvfi_insn;
  wire                formal_rvfi_trap;
  wire                formal_rvfi_halt;
  wire                formal_rvfi_intr;
  wire       [1:0]    formal_rvfi_mode;
  wire       [1:0]    formal_rvfi_ixl;
  wire       [4:0]    formal_rvfi_rs1_addr;
  wire       [4:0]    formal_rvfi_rs2_addr;
  wire       [31:0]   formal_rvfi_rs1_rdata;
  wire       [31:0]   formal_rvfi_rs2_rdata;
  wire       [4:0]    formal_rvfi_rd_addr;
  wire       [31:0]   formal_rvfi_rd_wdata;
  wire       [31:0]   formal_rvfi_pc_rdata;
  wire       [31:0]   formal_rvfi_pc_wdata;
  wire       [31:0]   formal_rvfi_mem_addr;
  wire       [3:0]    formal_rvfi_mem_rmask;
  wire       [3:0]    formal_rvfi_mem_wmask;
  wire       [31:0]   formal_rvfi_mem_rdata;
  wire       [31:0]   formal_rvfi_mem_wdata;
  reg        [63:0]   formal_order;
  reg                 formal_rvfi_regNext_valid;
  reg        [63:0]   formal_rvfi_regNext_order;
  reg        [31:0]   formal_rvfi_regNext_insn;
  reg                 formal_rvfi_regNext_trap;
  reg                 formal_rvfi_regNext_halt;
  reg                 formal_rvfi_regNext_intr;
  reg        [1:0]    formal_rvfi_regNext_mode;
  reg        [1:0]    formal_rvfi_regNext_ixl;
  reg        [4:0]    formal_rvfi_regNext_rs1_addr;
  reg        [4:0]    formal_rvfi_regNext_rs2_addr;
  reg        [31:0]   formal_rvfi_regNext_rs1_rdata;
  reg        [31:0]   formal_rvfi_regNext_rs2_rdata;
  reg        [4:0]    formal_rvfi_regNext_rd_addr;
  reg        [31:0]   formal_rvfi_regNext_rd_wdata;
  reg        [31:0]   formal_rvfi_regNext_pc_rdata;
  reg        [31:0]   formal_rvfi_regNext_pc_wdata;
  reg        [31:0]   formal_rvfi_regNext_mem_addr;
  reg        [3:0]    formal_rvfi_regNext_mem_rmask;
  reg        [3:0]    formal_rvfi_regNext_mem_wmask;
  reg        [31:0]   formal_rvfi_regNext_mem_rdata;
  reg        [31:0]   formal_rvfi_regNext_mem_wdata;

  assign _zz_9_ = immI[1 : 0];
  assign _zz_10_ = immI[2 : 0];
  assign io_IfToId_stall = 1'b0;
  assign opcode = io_IfToId_instr[6 : 0];
  assign rd = io_IfToId_instr[11 : 7];
  assign func3 = io_IfToId_instr[14 : 12];
  assign rs1 = io_IfToId_instr[19 : 15];
  assign rs2 = io_IfToId_instr[24 : 20];
  assign func7 = io_IfToId_instr[31 : 25];
  assign funccombined = {func7,func3};
  assign _zz_1_ = io_IfToId_instr[31];
  always @ (*) begin
    _zz_2_[19] = _zz_1_;
    _zz_2_[18] = _zz_1_;
    _zz_2_[17] = _zz_1_;
    _zz_2_[16] = _zz_1_;
    _zz_2_[15] = _zz_1_;
    _zz_2_[14] = _zz_1_;
    _zz_2_[13] = _zz_1_;
    _zz_2_[12] = _zz_1_;
    _zz_2_[11] = _zz_1_;
    _zz_2_[10] = _zz_1_;
    _zz_2_[9] = _zz_1_;
    _zz_2_[8] = _zz_1_;
    _zz_2_[7] = _zz_1_;
    _zz_2_[6] = _zz_1_;
    _zz_2_[5] = _zz_1_;
    _zz_2_[4] = _zz_1_;
    _zz_2_[3] = _zz_1_;
    _zz_2_[2] = _zz_1_;
    _zz_2_[1] = _zz_1_;
    _zz_2_[0] = _zz_1_;
  end

  assign immI = {_zz_2_,io_IfToId_instr[31 : 20]};
  assign _zz_3_ = io_IfToId_instr[31];
  always @ (*) begin
    _zz_4_[19] = _zz_3_;
    _zz_4_[18] = _zz_3_;
    _zz_4_[17] = _zz_3_;
    _zz_4_[16] = _zz_3_;
    _zz_4_[15] = _zz_3_;
    _zz_4_[14] = _zz_3_;
    _zz_4_[13] = _zz_3_;
    _zz_4_[12] = _zz_3_;
    _zz_4_[11] = _zz_3_;
    _zz_4_[10] = _zz_3_;
    _zz_4_[9] = _zz_3_;
    _zz_4_[8] = _zz_3_;
    _zz_4_[7] = _zz_3_;
    _zz_4_[6] = _zz_3_;
    _zz_4_[5] = _zz_3_;
    _zz_4_[4] = _zz_3_;
    _zz_4_[3] = _zz_3_;
    _zz_4_[2] = _zz_3_;
    _zz_4_[1] = _zz_3_;
    _zz_4_[0] = _zz_3_;
  end

  assign immS = {{_zz_4_,io_IfToId_instr[31 : 25]},io_IfToId_instr[11 : 7]};
  assign _zz_5_ = io_IfToId_instr[31];
  always @ (*) begin
    _zz_6_[17] = _zz_5_;
    _zz_6_[16] = _zz_5_;
    _zz_6_[15] = _zz_5_;
    _zz_6_[14] = _zz_5_;
    _zz_6_[13] = _zz_5_;
    _zz_6_[12] = _zz_5_;
    _zz_6_[11] = _zz_5_;
    _zz_6_[10] = _zz_5_;
    _zz_6_[9] = _zz_5_;
    _zz_6_[8] = _zz_5_;
    _zz_6_[7] = _zz_5_;
    _zz_6_[6] = _zz_5_;
    _zz_6_[5] = _zz_5_;
    _zz_6_[4] = _zz_5_;
    _zz_6_[3] = _zz_5_;
    _zz_6_[2] = _zz_5_;
    _zz_6_[1] = _zz_5_;
    _zz_6_[0] = _zz_5_;
  end

  assign immB = {{{{_zz_6_,io_IfToId_instr[7]},io_IfToId_instr[30 : 25]},io_IfToId_instr[11 : 8]},(1'b0)};
  assign immU = {io_IfToId_instr[31 : 12],12'h0};
  assign _zz_7_ = io_IfToId_instr[31];
  always @ (*) begin
    _zz_8_[10] = _zz_7_;
    _zz_8_[9] = _zz_7_;
    _zz_8_[8] = _zz_7_;
    _zz_8_[7] = _zz_7_;
    _zz_8_[6] = _zz_7_;
    _zz_8_[5] = _zz_7_;
    _zz_8_[4] = _zz_7_;
    _zz_8_[3] = _zz_7_;
    _zz_8_[2] = _zz_7_;
    _zz_8_[1] = _zz_7_;
    _zz_8_[0] = _zz_7_;
  end

  assign immJ = {{{{_zz_8_,io_IfToId_instr[19 : 12]},io_IfToId_instr[20]},io_IfToId_instr[30 : 21]},(1'b0)};
  always @ (*) begin
    trap = 1'b0;
    case(opcode)
      7'b0110011 : begin
        if(! ((funccombined == 10'h100) || ((func7 == 7'h0) && (func3 != (3'b101))))) begin
          if(! (((funccombined == 10'h001) || (funccombined == 10'h005)) || (funccombined == 10'h105))) begin
            trap = 1'b1;
          end
        end
      end
      7'b0010011 : begin
        if(! ((func3 != (3'b001)) && (func3 != (3'b101)))) begin
          if(! (((funccombined == 10'h001) || (funccombined == 10'h005)) || (funccombined == 10'h105))) begin
            trap = 1'b1;
          end
        end
      end
      7'b0110111 : begin
      end
      7'b0010111 : begin
      end
      7'b1101111 : begin
      end
      7'b1100111 : begin
        if((func3 != (3'b000)))begin
          trap = 1'b1;
        end
      end
      7'b1100011 : begin
        if(((func3 == (3'b010)) || (func3 == (3'b011))))begin
          trap = 1'b1;
        end
      end
      7'b0000011 : begin
        if((((func3 == (3'b011)) || (func3 == (3'b110))) || (func3 == (3'b111))))begin
          trap = 1'b1;
        end
        if(((func3 == (3'b001)) || (func3 == (3'b101))))begin
          if((_zz_9_ != (2'b00)))begin
            trap = 1'b1;
          end
        end else begin
          if((func3 == (3'b010)))begin
            if((_zz_10_ != (3'b000)))begin
              trap = 1'b1;
            end
          end
        end
      end
      7'b0100011 : begin
        if((((func3 != (3'b000)) || (func3 != (3'b001))) || (func3 != (3'b010))))begin
          trap = 1'b1;
        end
      end
      7'b0001111 : begin
        if(((func3 != (3'b000)) || (func3 != (3'b001))))begin
          trap = 1'b1;
        end
      end
      7'b1110011 : begin
        if((func3 != (3'b000)))begin
          trap = 1'b1;
        end
      end
      default : begin
        trap = 1'b1;
      end
    endcase
  end

  assign io_rs1 = rs1;
  assign io_rs2 = rs2;
  assign io_rd = rd;
  assign io_imm = immI;
  assign formal_rvfi_valid = io_IfToId_instr_valid;
  assign formal_rvfi_order = formal_order;
  assign formal_rvfi_insn = io_IfToId_instr;
  assign formal_rvfi_trap = trap;
  assign formal_rvfi_halt = 1'b0;
  assign formal_rvfi_intr = 1'b0;
  assign formal_rvfi_mode = (2'b00);
  assign formal_rvfi_ixl = (2'b00);
  assign formal_rvfi_rs1_addr = rs1;
  assign formal_rvfi_rs2_addr = rs2;
  assign formal_rvfi_rs1_rdata = 32'h0;
  assign formal_rvfi_rs2_rdata = 32'h0;
  assign formal_rvfi_rd_addr = rd;
  assign formal_rvfi_rd_wdata = 32'h0;
  assign formal_rvfi_pc_rdata = 32'h0;
  assign formal_rvfi_pc_wdata = 32'h0;
  assign formal_rvfi_mem_addr = 32'h0;
  assign formal_rvfi_mem_rmask = (4'b0000);
  assign formal_rvfi_mem_wmask = (4'b0000);
  assign formal_rvfi_mem_rdata = 32'h0;
  assign formal_rvfi_mem_wdata = 32'h0;
  assign rvfi_valid = formal_rvfi_regNext_valid;
  assign rvfi_order = formal_rvfi_regNext_order;
  assign rvfi_insn = formal_rvfi_regNext_insn;
  assign rvfi_trap = formal_rvfi_regNext_trap;
  assign rvfi_halt = formal_rvfi_regNext_halt;
  assign rvfi_intr = formal_rvfi_regNext_intr;
  assign rvfi_mode = formal_rvfi_regNext_mode;
  assign rvfi_ixl = formal_rvfi_regNext_ixl;
  assign rvfi_rs1_addr = formal_rvfi_regNext_rs1_addr;
  assign rvfi_rs2_addr = formal_rvfi_regNext_rs2_addr;
  assign rvfi_rs1_rdata = formal_rvfi_regNext_rs1_rdata;
  assign rvfi_rs2_rdata = formal_rvfi_regNext_rs2_rdata;
  assign rvfi_rd_addr = formal_rvfi_regNext_rd_addr;
  assign rvfi_rd_wdata = formal_rvfi_regNext_rd_wdata;
  assign rvfi_pc_rdata = formal_rvfi_regNext_pc_rdata;
  assign rvfi_pc_wdata = formal_rvfi_regNext_pc_wdata;
  assign rvfi_mem_addr = formal_rvfi_regNext_mem_addr;
  assign rvfi_mem_rmask = formal_rvfi_regNext_mem_rmask;
  assign rvfi_mem_wmask = formal_rvfi_regNext_mem_wmask;
  assign rvfi_mem_rdata = formal_rvfi_regNext_mem_rdata;
  assign rvfi_mem_wdata = formal_rvfi_regNext_mem_wdata;
  always @ (posedge clk or posedge reset) begin
    if (reset) begin
      formal_order <= 64'h0;
    end else begin
      if(io_IfToId_instr_valid)begin
        formal_order <= (formal_order + 64'h0000000000000001);
      end
    end
  end

  always @ (posedge clk) begin
    formal_rvfi_regNext_valid <= formal_rvfi_valid;
    formal_rvfi_regNext_order <= formal_rvfi_order;
    formal_rvfi_regNext_insn <= formal_rvfi_insn;
    formal_rvfi_regNext_trap <= formal_rvfi_trap;
    formal_rvfi_regNext_halt <= formal_rvfi_halt;
    formal_rvfi_regNext_intr <= formal_rvfi_intr;
    formal_rvfi_regNext_mode <= formal_rvfi_mode;
    formal_rvfi_regNext_ixl <= formal_rvfi_ixl;
    formal_rvfi_regNext_rs1_addr <= formal_rvfi_rs1_addr;
    formal_rvfi_regNext_rs2_addr <= formal_rvfi_rs2_addr;
    formal_rvfi_regNext_rs1_rdata <= formal_rvfi_rs1_rdata;
    formal_rvfi_regNext_rs2_rdata <= formal_rvfi_rs2_rdata;
    formal_rvfi_regNext_rd_addr <= formal_rvfi_rd_addr;
    formal_rvfi_regNext_rd_wdata <= formal_rvfi_rd_wdata;
    formal_rvfi_regNext_pc_rdata <= formal_rvfi_pc_rdata;
    formal_rvfi_regNext_pc_wdata <= formal_rvfi_pc_wdata;
    formal_rvfi_regNext_mem_addr <= formal_rvfi_mem_addr;
    formal_rvfi_regNext_mem_rmask <= formal_rvfi_mem_rmask;
    formal_rvfi_regNext_mem_wmask <= formal_rvfi_mem_wmask;
    formal_rvfi_regNext_mem_rdata <= formal_rvfi_mem_rdata;
    formal_rvfi_regNext_mem_wdata <= formal_rvfi_mem_wdata;
  end


endmodule

module rikv (
  input               instr_valid,
  input      [31:0]   instr,
  output              rvfi_valid,
  output     [63:0]   rvfi_order,
  output     [31:0]   rvfi_insn,
  output              rvfi_trap,
  output              rvfi_halt,
  output              rvfi_intr,
  output     [1:0]    rvfi_mode,
  output     [1:0]    rvfi_ixl,
  output     [4:0]    rvfi_rs1_addr,
  output     [4:0]    rvfi_rs2_addr,
  output     [31:0]   rvfi_rs1_rdata,
  output     [31:0]   rvfi_rs2_rdata,
  output     [4:0]    rvfi_rd_addr,
  output     [31:0]   rvfi_rd_wdata,
  output     [31:0]   rvfi_pc_rdata,
  output     [31:0]   rvfi_pc_wdata,
  output     [31:0]   rvfi_mem_addr,
  output     [3:0]    rvfi_mem_rmask,
  output     [3:0]    rvfi_mem_wmask,
  output     [31:0]   rvfi_mem_rdata,
  output     [31:0]   rvfi_mem_wdata,
  input               clk,
  input               reset 
);
  wire                instructionFetch_1__io_IfToId_instr_valid;
  wire       [31:0]   instructionFetch_1__io_IfToId_instr;
  wire                instructionDecoder_1__io_IfToId_stall;
  wire       [31:0]   instructionDecoder_1__io_imm;
  wire       [4:0]    instructionDecoder_1__io_rs1;
  wire       [4:0]    instructionDecoder_1__io_rs2;
  wire       [4:0]    instructionDecoder_1__io_rd;
  wire                instructionDecoder_1__rvfi_valid;
  wire       [63:0]   instructionDecoder_1__rvfi_order;
  wire       [31:0]   instructionDecoder_1__rvfi_insn;
  wire                instructionDecoder_1__rvfi_trap;
  wire                instructionDecoder_1__rvfi_halt;
  wire                instructionDecoder_1__rvfi_intr;
  wire       [1:0]    instructionDecoder_1__rvfi_mode;
  wire       [1:0]    instructionDecoder_1__rvfi_ixl;
  wire       [4:0]    instructionDecoder_1__rvfi_rs1_addr;
  wire       [4:0]    instructionDecoder_1__rvfi_rs2_addr;
  wire       [31:0]   instructionDecoder_1__rvfi_rs1_rdata;
  wire       [31:0]   instructionDecoder_1__rvfi_rs2_rdata;
  wire       [4:0]    instructionDecoder_1__rvfi_rd_addr;
  wire       [31:0]   instructionDecoder_1__rvfi_rd_wdata;
  wire       [31:0]   instructionDecoder_1__rvfi_pc_rdata;
  wire       [31:0]   instructionDecoder_1__rvfi_pc_wdata;
  wire       [31:0]   instructionDecoder_1__rvfi_mem_addr;
  wire       [3:0]    instructionDecoder_1__rvfi_mem_rmask;
  wire       [3:0]    instructionDecoder_1__rvfi_mem_wmask;
  wire       [31:0]   instructionDecoder_1__rvfi_mem_rdata;
  wire       [31:0]   instructionDecoder_1__rvfi_mem_wdata;

  InstructionFetch instructionFetch_1_ ( 
    .io_instr_valid           (instr_valid                                ), //i
    .io_instr                 (instr[31:0]                                ), //i
    .io_IfToId_instr_valid    (instructionFetch_1__io_IfToId_instr_valid  ), //o
    .io_IfToId_instr          (instructionFetch_1__io_IfToId_instr[31:0]  ), //o
    .io_IfToId_stall          (instructionDecoder_1__io_IfToId_stall      )  //i
  );
  InstructionDecoder instructionDecoder_1_ ( 
    .io_IfToId_instr_valid    (instructionFetch_1__io_IfToId_instr_valid   ), //i
    .io_IfToId_instr          (instructionFetch_1__io_IfToId_instr[31:0]   ), //i
    .io_IfToId_stall          (instructionDecoder_1__io_IfToId_stall       ), //o
    .io_imm                   (instructionDecoder_1__io_imm[31:0]          ), //o
    .io_rs1                   (instructionDecoder_1__io_rs1[4:0]           ), //o
    .io_rs2                   (instructionDecoder_1__io_rs2[4:0]           ), //o
    .io_rd                    (instructionDecoder_1__io_rd[4:0]            ), //o
    .rvfi_valid               (instructionDecoder_1__rvfi_valid            ), //o
    .rvfi_order               (instructionDecoder_1__rvfi_order[63:0]      ), //o
    .rvfi_insn                (instructionDecoder_1__rvfi_insn[31:0]       ), //o
    .rvfi_trap                (instructionDecoder_1__rvfi_trap             ), //o
    .rvfi_halt                (instructionDecoder_1__rvfi_halt             ), //o
    .rvfi_intr                (instructionDecoder_1__rvfi_intr             ), //o
    .rvfi_mode                (instructionDecoder_1__rvfi_mode[1:0]        ), //o
    .rvfi_ixl                 (instructionDecoder_1__rvfi_ixl[1:0]         ), //o
    .rvfi_rs1_addr            (instructionDecoder_1__rvfi_rs1_addr[4:0]    ), //o
    .rvfi_rs2_addr            (instructionDecoder_1__rvfi_rs2_addr[4:0]    ), //o
    .rvfi_rs1_rdata           (instructionDecoder_1__rvfi_rs1_rdata[31:0]  ), //o
    .rvfi_rs2_rdata           (instructionDecoder_1__rvfi_rs2_rdata[31:0]  ), //o
    .rvfi_rd_addr             (instructionDecoder_1__rvfi_rd_addr[4:0]     ), //o
    .rvfi_rd_wdata            (instructionDecoder_1__rvfi_rd_wdata[31:0]   ), //o
    .rvfi_pc_rdata            (instructionDecoder_1__rvfi_pc_rdata[31:0]   ), //o
    .rvfi_pc_wdata            (instructionDecoder_1__rvfi_pc_wdata[31:0]   ), //o
    .rvfi_mem_addr            (instructionDecoder_1__rvfi_mem_addr[31:0]   ), //o
    .rvfi_mem_rmask           (instructionDecoder_1__rvfi_mem_rmask[3:0]   ), //o
    .rvfi_mem_wmask           (instructionDecoder_1__rvfi_mem_wmask[3:0]   ), //o
    .rvfi_mem_rdata           (instructionDecoder_1__rvfi_mem_rdata[31:0]  ), //o
    .rvfi_mem_wdata           (instructionDecoder_1__rvfi_mem_wdata[31:0]  ), //o
    .clk                      (clk                                         ), //i
    .reset                    (reset                                       )  //i
  );
  assign rvfi_valid = instructionDecoder_1__rvfi_valid;
  assign rvfi_order = instructionDecoder_1__rvfi_order;
  assign rvfi_insn = instructionDecoder_1__rvfi_insn;
  assign rvfi_trap = instructionDecoder_1__rvfi_trap;
  assign rvfi_halt = instructionDecoder_1__rvfi_halt;
  assign rvfi_intr = instructionDecoder_1__rvfi_intr;
  assign rvfi_mode = instructionDecoder_1__rvfi_mode;
  assign rvfi_ixl = instructionDecoder_1__rvfi_ixl;
  assign rvfi_rs1_addr = instructionDecoder_1__rvfi_rs1_addr;
  assign rvfi_rs2_addr = instructionDecoder_1__rvfi_rs2_addr;
  assign rvfi_rs1_rdata = instructionDecoder_1__rvfi_rs1_rdata;
  assign rvfi_rs2_rdata = instructionDecoder_1__rvfi_rs2_rdata;
  assign rvfi_rd_addr = instructionDecoder_1__rvfi_rd_addr;
  assign rvfi_rd_wdata = instructionDecoder_1__rvfi_rd_wdata;
  assign rvfi_pc_rdata = instructionDecoder_1__rvfi_pc_rdata;
  assign rvfi_pc_wdata = instructionDecoder_1__rvfi_pc_wdata;
  assign rvfi_mem_addr = instructionDecoder_1__rvfi_mem_addr;
  assign rvfi_mem_rmask = instructionDecoder_1__rvfi_mem_rmask;
  assign rvfi_mem_wmask = instructionDecoder_1__rvfi_mem_wmask;
  assign rvfi_mem_rdata = instructionDecoder_1__rvfi_mem_rdata;
  assign rvfi_mem_wdata = instructionDecoder_1__rvfi_mem_wdata;

endmodule
