
//
//	control_logic.v
//		RV32I Control Logic
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 11/24/2022
// -------------------------------- //
//	Last Modified: 12/04/2022

// Change Log:	NA

module control_logic(inst);
    // Input & Outputs
    input wire [31:0]   inst;

    // Internal
    wire [6:0]          opcode, funct7;
    wire [2:0]          funct3;

    assign opcode = inst[6:0];
    assign funct3 = inst[14:12];
    assign funct7 = inst[31:25];

    always @(inst) begin
        case (opcode)
            7'b0110111:         // LUI
            7'b0010111:         // AUIPC
            7'b1101111:         // JAL
            7'b1100111:         // JALR
            7'b1100011:
                case (funct3)
                    3'b000:     // BEQ
                    3'b001:     // BNE
                    3'b100:     // BLT
                    3'b101:     // BGE
                    3'b110:     // BLTU
                    3'b111:     // BGEU
                endcase
            7'b0000011:
                case (funct3)
                    3'b000:     // LB
                    3'b001:     // LH
                    3'b010:     // LW
                    3'b100:     // LBU
                    3'b101:     // LHU
                endcase
            7'b0100011:
                case (funct3)
                    3'b000:     // SB
                    3'b001:     // SH
                    3'b010:     // SW
                endcase
            7'b0010011:
                case (funct3)
                    3'b000:     // ADDI
                    3'b010:     // SLTI
                    3'b011:     // SLTIU
                    3'b100:     // XORI
                    3'b110:     // ORI
                    3'b111:     // ANDI
                    3'b001:
                        case (funct7)
                            7'b0000000:     // SLLI
                        endcase
                    3'b101:     
                        case (funct7)
                            7'b0000000:     // SRLI
                            7'b0100000:     // SRAI
                        endcase
                endcase
            7'b0110011:
                case (funct3)
                    3'b000:
                        case (funct7)
                            7'b0000000:     // ADD
                            7'b0100000:     // SUB
                        endcase
                    3'b001:
                        case (funct7)
                            7'b0000000:     // SLL
                        endcase
                    3'b010:
                        case (funct7)
                            7'b0000000:     // SLT
                        endcase
                    3'b011:
                        case (funct7)
                            7'b0000000:     // SLTU
                        endcase
                    3'b100:
                        case (funct7)
                            7'b0000000:     // XOR
                        endcase
                    3'b101:
                        case (funct7)
                            7'b0000000:     // SRL
                            7'b0100000:     // SRA
                        endcase
                    3'b110:
                        case (funct7)
                            7'b0000000:     // OR
                        endcase
                    3'b111:
                        case (funct7)
                            7'b0000000:     // AND
                        endcase
                endcase
            7'b0001111:
                if (inst[31:28] == 0 and inst[19:7] == 0) begin
                    // FENCELL
                end 
                else if (inst[31:7] == 25'h0000020) begin
                    // FENCE.I
                end
            7'b1110011:
				case (funct3)
					3'b000:
						if (inst[11:7] == 0 and inst[19:15] == 0 and inst[31:20] == 0) begin
											// ECALL
						end
						else if (inst[11:7] == 0 and inst[19:15] == 0 and inst[31:20] == 1) begin
						                    // EBREAK
						end
					3'b001:					// CSRRW
					3'b010:					// CSRRS
					3'b011:					// CSRRC
					3'b101:					// CSRRWI
					3'b110:					// CSRRSI
					3'b111:					// CSRRCI
				endcase
        endcase
    end
endmodule















