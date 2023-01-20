
//
//	control_logic.v
//		RV32I Control Logic
//

// -------------------------------- //
//	By: Bryce Keen	
//	Created: 11/24/2022
// -------------------------------- //
//	Last Modified: 01/14/2023

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
                
                /*  LUI places the U-immediate value in the 
                top 20 bits of the destination register rd, 
                filling in the lowest 12 bits with zeros. */

            7'b0010111:         // AUIPC

                /* AUIPC forms a 32-bit offset from the 20-bit 
                U-immediate, filling in the lowest 12 bits with
                zeros, adds this offset to the pc, then places 
                the result in register rd. */

            7'b1101111:         // JAL

                /* signed offset in multiples of 2 bytes. The 
                offset is sign-extended and added to the pc to form the
                jump target address. JAL stores the address of the
                instruction following the jump (pc+4) into register rd.*/


            7'b1100111:         // JALR

                /* The target address is obtained by adding the 12-bit 
                signed I-immediate to the register rs1, then setting the
                least-significant bit of the result to zero The address 
                of the instruction following the jump (pc+4) is written 
                to register rd*/

            7'b1100011:
                case (funct3)
                    3'b000:     // BEQ
                        /*  BEQ take the branch if registers rs1 and rs2
                        are equal */

                    3'b001:     // BNE
                        /*  BNE take the branch if registers rs1 and rs2
                        are equal */

                    3'b100:     // BLT
                        /*  BLT take the branch if rs1 is less than rs2, using
                        signed comparison */

                    3'b101:     // BGE
                        /* BGE take the branch if rs1 is greater than or equal to rs2, 
                        using signed comparison */

                    3'b110:     // BLTU
                        /*  BLTU take the branch if rs1 is less than rs2, using
                        unsigned comparison */

                    3'b111:     // BGEU
                        /* BGEU take the branch if rs1 is greater than or equal to rs2, 
                        using unsigned comparison */

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

