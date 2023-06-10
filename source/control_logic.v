
// -------------------------------- //
//	By: Bryce Keen	
//	Created: 11/24/2022
// -------------------------------- //
//	Last Modified: 01/25/2023

//
//	control_logic.v
//		RV32I Control Logic
//


module control_logic(inst, jump, ALUControl, dmemMode, 
                     immSEL, regSEL, pcSEL, dmemWE, 
                     regWE, rs1SEL, rs2SEL, clk, reset);

    // Input & Outputs
    input wire [31:0]   inst;
    input wire          jump, clk, reset;

    output reg [3:0]    ALUControl;
    output reg [2:0]    dmemMode, immSEL;
    output reg [1:0]    regSEL, pcSEL; 
    output reg          dmemWE, regWE, rs1SEL, rs2SEL;

    // Internal
    wire [6:0]          opcode, funct7;
    wire [2:0]          funct3;

    assign opcode = inst[6:0];
    assign funct3 = inst[14:12];
    assign funct7 = inst[31:25];

    initial begin
        dmemMode    <= 3'b000;
        dmemWE      <= 1'b0;
        regWE       <= 1'b0;
        rs1SEL      <= 1'b0;
        rs2SEL      <= 1'b0;
        regSEL      <= 2'b00;
        pcSEL       <= 2'b00;
        immSEL      <= 3'b000;
        ALUControl  <= 4'b0000;
    end

    always @(*) begin
        case (opcode)
            7'b0110111:         // LUI
                
                /*  LUI places the U-immediate value in the 
                top 20 bits of the destination register rd, 
                filling in the lowest 12 bits with zeros. */
                begin
                    dmemMode    <= 3'b000;
                    dmemWE      <= 1'b0;
                    rs1SEL      <= 1'b0;
                    rs2SEL      <= 1'b0;
                    regSEL      <= 2'b10;
                    pcSEL       <= 2'b00;
                    immSEL      <= 3'b000;
                    ALUControl  <= 4'b0000;
                    regWE       <= 1'b1;
                end
            7'b0010111:         // AUIPC

                /* AUIPC forms a 32-bit offset from the 20-bit 
                U-immediate, filling in the lowest 12 bits with
                zeros, adds this offset to the pc, then places 
                the result in register rd. */
                begin
                    dmemMode    <= 3'b000;
                    dmemWE      <= 1'b0;
                    regWE       <= 1'b1;
                    rs1SEL      <= 1'b1;
                    rs2SEL      <= 1'b1;
                    regSEL      <= 2'b01;
                    pcSEL       <= 2'b00;
                    immSEL      <= 3'b000;
                    ALUControl  <= 4'b0000;
                end
            7'b1101111:         // JAL

                /* signed offset in multiples of 2 bytes. The 
                offset is sign-extended and added to the pc to form the
                jump target address. JAL stores the address of the
                instruction following the jump (pc+4) into register rd.*/
                begin
                    dmemMode    <= 3'b000;
                    dmemWE      <= 1'b0;
                    regWE       <= 1'b1;
                    rs1SEL      <= 1'b0;
                    rs2SEL      <= 1'b0;
                    regSEL      <= 2'b11;
                    pcSEL       <= 2'b10;
                    immSEL      <= 3'b100;
                    ALUControl  <= 4'b0000;
                end
            7'b1100111:         // JALR

                /* The target address is obtained by adding the 12-bit 
                signed I-immediate to the register rs1, then setting the
                least-significant bit of the result to zero The address 
                of the instruction following the jump (pc+4) is written 
                to register rd*/
                begin
                    dmemMode    <= 3'b000;
                    dmemWE      <= 1'b0;
                    regWE       <= 1'b1;
                    rs1SEL      <= 1'b0;
                    rs2SEL      <= 1'b1;
                    regSEL      <= 2'b11;
                    pcSEL       <= 2'b01;
                    immSEL      <= 3'b011;
                    ALUControl  <= 4'b1101;
                end
            7'b1100011:
                begin
                    case (funct3)
                        3'b000:     // BEQ
                            /*  BEQ take the branch if registers rs1 and rs2
                            are equal */
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b0;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b0;
                                regSEL      <= 2'b00;
                                pcSEL       <= (jump == 1'b1) ? 2'b10 : 2'b00;
                                immSEL      <= 3'b010;
                                ALUControl  <= 4'b1000;
                            end
                        3'b001:     // BNE
                            /*  BNE take the branch if registers rs1 and rs2
                            are not equal */
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b0;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b0;
                                regSEL      <= 2'b00;
                                pcSEL       <= (jump == 1'b0) ? 2'b10 : 2'b00;
                                immSEL      <= 3'b010;
                                ALUControl  <= 4'b1000;
                            end
                        3'b100:     // BLT
                            /*  BLT take the branch if rs1 is less than rs2, using
                            signed comparison */
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b0;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b0;
                                regSEL      <= 2'b00;
                                pcSEL       <= (jump == 1'b1) ? 2'b10 : 2'b00;
                                immSEL      <= 3'b010;
                                ALUControl  <= 4'b1010;
                            end
                        3'b101:     // BGE
                            /* BGE take the branch if rs1 is greater than or equal to rs2, 
                            using signed comparison */
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b0;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b0;
                                regSEL      <= 2'b00;
                                pcSEL       <= (jump == 1'b1) ? 2'b10 : 2'b00;
                                immSEL      <= 3'b010;
                                ALUControl  <= 4'b1100;
                            end
                        3'b110:     // BLTU
                            /*  BLTU take the branch if rs1 is less than rs2, using
                            unsigned comparison */
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b0;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b0;
                                regSEL      <= 2'b00;
                                pcSEL       <= (jump == 1'b1) ? 2'b10 : 2'b00;
                                immSEL      <= 3'b010;
                                ALUControl  <= 4'b1001;
                            end
                        3'b111:     // BGEU
                            /* BGEU take the branch if rs1 is greater than or equal to rs2, 
                            using unsigned comparison */
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b0;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b0;
                                regSEL      <= 2'b00;
                                pcSEL       <= (jump == 1'b1) ? 2'b10 : 2'b00;
                                immSEL      <= 3'b010;
                                ALUControl  <= 4'b1011;
                            end
                    endcase
                end
            7'b0000011:
                begin
                    case (funct3)
                        3'b000:     // LB
                            begin
                                dmemMode    <= 3'b110;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b00;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b0000;
                            end
                        3'b001:     // LH
                            begin
                                dmemMode    <= 3'b101;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b00;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b0000;
                            end
                        3'b010:     // LW
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b00;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b0000;
                            end
                        3'b100:     // LBU
                            begin
                                dmemMode    <= 3'b010;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b00;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b0000;
                            end
                        3'b101:     // LHU
                            begin
                                dmemMode    <= 3'b001;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b00;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b0000;
                            end
                    endcase
                end
            7'b0100011:
                begin
                    case (funct3)
                        3'b000:     // SB
                            begin
                                dmemMode    <= 3'b010;
                                dmemWE      <= 1'b1;
                                regWE       <= 1'b0;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b00;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b001;
                                ALUControl  <= 4'b0000;
                            end
                        3'b001:     // SH
                            begin
                                dmemMode    <= 3'b001;
                                dmemWE      <= 1'b1;
                                regWE       <= 1'b0;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b00;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b001;
                                ALUControl  <= 4'b0000;
                            end
                        3'b010:     // SW
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b1;
                                regWE       <= 1'b0;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b00;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b001;
                                ALUControl  <= 4'b0000;
                            end
                    endcase
                end
            7'b0010011:
                begin
                    case (funct3)
                        3'b000:     // ADDI
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b01;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b0000;
                            end
                        3'b010:     // SLTI
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b01;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b1010;
                            end
                        3'b011:     // SLTIU
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b01;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b1001;
                            end
                        3'b100:     // XORI
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b01;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b0100;
                            end
                        3'b110:     // ORI
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b01;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b0011;
                            end
                        3'b111:     // ANDI
                            begin
                                dmemMode    <= 3'b000;
                                dmemWE      <= 1'b0;
                                regWE       <= 1'b1;
                                rs1SEL      <= 1'b0;
                                rs2SEL      <= 1'b1;
                                regSEL      <= 2'b01;
                                pcSEL       <= 2'b00;
                                immSEL      <= 3'b011;
                                ALUControl  <= 4'b0010;
                            end
                        3'b001:
                            case (funct7)
                                7'b0000000:     // SLLI
                                    begin
                                        dmemMode    <= 3'b000;
                                        dmemWE      <= 1'b0;
                                        regWE       <= 1'b1;
                                        rs1SEL      <= 1'b0;
                                        rs2SEL      <= 1'b1;
                                        regSEL      <= 2'b01;
                                        pcSEL       <= 2'b00;
                                        immSEL      <= 3'b011;
                                        ALUControl  <= 4'b0101;
                                    end
                            endcase
                        3'b101:     
                            case (funct7)
                                7'b0000000:     // SRLI
                                    begin
                                        dmemMode    <= 3'b000;
                                        dmemWE      <= 1'b0;
                                        regWE       <= 1'b1;
                                        rs1SEL      <= 1'b0;
                                        rs2SEL      <= 1'b1;
                                        regSEL      <= 2'b01;
                                        pcSEL       <= 2'b00;
                                        immSEL      <= 3'b011;
                                        ALUControl  <= 4'b0110;
                                    end
                                7'b0100000:     // SRAI
                                    begin
                                        dmemMode    <= 3'b000;
                                        dmemWE      <= 1'b0;
                                        regWE       <= 1'b1;
                                        rs1SEL      <= 1'b0;
                                        rs2SEL      <= 1'b1;
                                        regSEL      <= 2'b01;
                                        pcSEL       <= 2'b00;
                                        immSEL      <= 3'b011;
                                        ALUControl  <= 4'b0111;
                                    end
                            endcase
                    endcase
                end
            7'b0110011:
                case (funct3)
                    3'b000:
                        case (funct7)
                            7'b0000000:     // ADD
                                begin
                                    dmemMode    <= 3'b000;
                                    dmemWE      <= 1'b0;
                                    regWE       <= 1'b1;
                                    rs1SEL      <= 1'b0;
                                    rs2SEL      <= 1'b0;
                                    regSEL      <= 2'b01;
                                    pcSEL       <= 2'b00;
                                    immSEL      <= 3'b000;
                                    ALUControl  <= 4'b0000;
                                end
                            7'b0100000:     // SUB
                                begin
                                    dmemMode    <= 3'b000;
                                    dmemWE      <= 1'b0;
                                    regWE       <= 1'b1;
                                    rs1SEL      <= 1'b0;
                                    rs2SEL      <= 1'b0;
                                    regSEL      <= 2'b01;
                                    pcSEL       <= 2'b00;
                                    immSEL      <= 3'b000;
                                    ALUControl  <= 4'b0001;
                                end
                        endcase
                    3'b001:
                        case (funct7)
                            7'b0000000:     // SLL
                                begin
                                    dmemMode    <= 3'b000;
                                    dmemWE      <= 1'b0;
                                    regWE       <= 1'b1;
                                    rs1SEL      <= 1'b0;
                                    rs2SEL      <= 1'b0;
                                    regSEL      <= 2'b01;
                                    pcSEL       <= 2'b00;
                                    immSEL      <= 3'b000;
                                    ALUControl  <= 4'b0101;
                                end
                        endcase
                    3'b010:
                        case (funct7)
                            7'b0000000:     // SLT
                                begin
                                    dmemMode    <= 3'b000;
                                    dmemWE      <= 1'b0;
                                    regWE       <= 1'b1;
                                    rs1SEL      <= 1'b0;
                                    rs2SEL      <= 1'b0;
                                    regSEL      <= 2'b01;
                                    pcSEL       <= 2'b00;
                                    immSEL      <= 3'b000;
                                    ALUControl  <= 4'b1010;
                                end
                        endcase
                    3'b011:
                        case (funct7)
                            7'b0000000:     // SLTU
                                begin
                                    dmemMode    <= 3'b000;
                                    dmemWE      <= 1'b0;
                                    regWE       <= 1'b1;
                                    rs1SEL      <= 1'b0;
                                    rs2SEL      <= 1'b0;
                                    regSEL      <= 2'b01;
                                    pcSEL       <= 2'b00;
                                    immSEL      <= 3'b000;
                                    ALUControl  <= 4'b1001;
                                end
                        endcase
                    3'b100:
                        case (funct7)
                            7'b0000000:     // XOR
                                begin
                                    dmemMode    <= 3'b000;
                                    dmemWE      <= 1'b0;
                                    regWE       <= 1'b1;
                                    rs1SEL      <= 1'b0;
                                    rs2SEL      <= 1'b0;
                                    regSEL      <= 2'b01;
                                    pcSEL       <= 2'b00;
                                    immSEL      <= 3'b000;
                                    ALUControl  <= 4'b0100;
                                end
                        endcase
                    3'b101:
                        case (funct7)
                            7'b0000000:     // SRL
                                begin
                                    dmemMode    <= 3'b000;
                                    dmemWE      <= 1'b0;
                                    regWE       <= 1'b1;
                                    rs1SEL      <= 1'b0;
                                    rs2SEL      <= 1'b0;
                                    regSEL      <= 2'b01;
                                    pcSEL       <= 2'b00;
                                    immSEL      <= 3'b000;
                                    ALUControl  <= 4'b0110;
                                end
                            7'b0100000:     // SRA
                                begin
                                    dmemMode    <= 3'b000;
                                    dmemWE      <= 1'b0;
                                    regWE       <= 1'b1;
                                    rs1SEL      <= 1'b0;
                                    rs2SEL      <= 1'b0;
                                    regSEL      <= 2'b01;
                                    pcSEL       <= 2'b00;
                                    immSEL      <= 3'b000;
                                    ALUControl  <= 4'b0111;
                                end
                        endcase
                    3'b110:
                        case (funct7)
                            7'b0000000:     // OR
                                begin
                                    dmemMode    <= 3'b000;
                                    dmemWE      <= 1'b0;
                                    regWE       <= 1'b1;
                                    rs1SEL      <= 1'b0;
                                    rs2SEL      <= 1'b0;
                                    regSEL      <= 2'b01;
                                    pcSEL       <= 2'b00;
                                    immSEL      <= 3'b000;
                                    ALUControl  <= 4'b0011;
                                end
                        endcase
                    3'b111:
                        case (funct7)
                            7'b0000000:     // AND
                                begin
                                    dmemMode    <= 3'b000;
                                    dmemWE      <= 1'b0;
                                    regWE       <= 1'b1;
                                    rs1SEL      <= 1'b0;
                                    rs2SEL      <= 1'b0;
                                    regSEL      <= 2'b01;
                                    pcSEL       <= 2'b00;
                                    immSEL      <= 3'b000;
                                    ALUControl  <= 4'b0010;
                                end
                        endcase
                endcase
            /*
                Instructions are not necessary for Single Cycle Implementations

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
            */    
            default:
                begin
                    dmemMode    <= 3'b000;
                    dmemWE      <= 1'b0;
                    regWE       <= 1'b0;
                    rs1SEL      <= 1'b0;
                    rs2SEL      <= 1'b0;
                    regSEL      <= 2'b00;
                    pcSEL       <= 2'b00;
                    immSEL      <= 3'b000;
                    ALUControl  <= 4'b0000;
                end
        endcase
    end
endmodule
