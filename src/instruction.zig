pub const AddressMode = enum {
    ZeroPageX,
    ZeroPageY,
    AbsoluteX,
    AbsoluteY,
    IndirectX,
    IndirectY,
    Implied,
    Accumulator,
    Immediate,
    ZeroPage,
    Absolute,
    Relative,
    Indirect,
};

pub const Operation = enum {
    ADC,
    AND,
    ASL,
    BCC,
    BCS,
    BEQ,
    BIT,
    BMI,
    BNE,
    BPL,
    BRK,
    BVC,
    BVS,
    CLC,
    CLD,
    CLI,
    CLV,
    CMP,
    CPX,
    CPY,
    DEC,
    DEX,
    DEY,
    EOR,
    INC,
    INX,
    INY,
    JMP,
    JSR,
    LDA,
    LDX,
    LDY,
    LSR,
    NOP,
    ORA,
    PHA,
    PHP,
    PLA,
    PLP,
    ROL,
    ROR,
    RTI,
    RTS,
    SBC,
    SEC,
    SED,
    SEI,
    STA,
    STX,
    STY,
    TAX,
    TAY,
    TSX,
    TXA,
    TXS,
    TYA,
};

pub const Instruction = struct {
    operation: Operation,
    address_mode: AddressMode,
};

pub fn decode(opcode: u8) ?Instruction {
    return switch (opcode) {
        0x69 => .{ .operation = .ADC, .address_mode = .Immediate },
        0x65 => .{ .operation = .ADC, .address_mode = .ZeroPage },
        0x75 => .{ .operation = .ADC, .address_mode = .ZeroPageX },
        0x6D => .{ .operation = .ADC, .address_mode = .Absolute },
        0x7D => .{ .operation = .ADC, .address_mode = .AbsoluteX },
        0x79 => .{ .operation = .ADC, .address_mode = .AbsoluteY },
        0x61 => .{ .operation = .ADC, .address_mode = .IndirectX },
        0x71 => .{ .operation = .ADC, .address_mode = .IndirectY },

        0x29 => .{ .operation = .AND, .address_mode = .Immediate },
        0x25 => .{ .operation = .AND, .address_mode = .ZeroPage },
        0x35 => .{ .operation = .AND, .address_mode = .ZeroPageX },
        0x2D => .{ .operation = .AND, .address_mode = .Absolute },
        0x3D => .{ .operation = .AND, .address_mode = .AbsoluteX },
        0x39 => .{ .operation = .AND, .address_mode = .AbsoluteY },
        0x21 => .{ .operation = .AND, .address_mode = .IndirectX },
        0x31 => .{ .operation = .AND, .address_mode = .IndirectY },

        0x0A => .{ .operation = .ASL, .address_mode = .Accumulator },
        0x06 => .{ .operation = .ASL, .address_mode = .ZeroPage },
        0x16 => .{ .operation = .ASL, .address_mode = .ZeroPageX },
        0x0E => .{ .operation = .ASL, .address_mode = .Absolute },
        0x1E => .{ .operation = .ASL, .address_mode = .AbsoluteX },

        0x90 => .{ .operation = .BCC, .address_mode = .Relative },

        0xB0 => .{ .operation = .BCS, .address_mode = .Relative },

        0xF0 => .{ .operation = .BEQ, .address_mode = .Relative },

        0x24 => .{ .operation = .BIT, .address_mode = .ZeroPage },
        0x2C => .{ .operation = .BIT, .address_mode = .Absolute },

        0x30 => .{ .operation = .BMI, .address_mode = .Relative },

        0xD0 => .{ .operation = .BNE, .address_mode = .Relative },

        0x10 => .{ .operation = .BPL, .address_mode = .Relative },

        0x00 => .{ .operation = .BRK, .address_mode = .Implied },

        0x50 => .{ .operation = .BVC, .address_mode = .Relative },

        0x70 => .{ .operation = .BVS, .address_mode = .Relative },

        0x18 => .{ .operation = .CLC, .address_mode = .Implied },

        0xD8 => .{ .operation = .CLD, .address_mode = .Implied },

        0x58 => .{ .operation = .CLI, .address_mode = .Implied },

        0xB8 => .{ .operation = .CLV, .address_mode = .Implied },

        0xC9 => .{ .operation = .CMP, .address_mode = .Immediate },
        0xC5 => .{ .operation = .CMP, .address_mode = .ZeroPage },
        0xD5 => .{ .operation = .CMP, .address_mode = .ZeroPageX },
        0xCD => .{ .operation = .CMP, .address_mode = .Absolute },
        0xDD => .{ .operation = .CMP, .address_mode = .AbsoluteX },
        0xD9 => .{ .operation = .CMP, .address_mode = .AbsoluteY },
        0xC1 => .{ .operation = .CMP, .address_mode = .IndirectX },
        0xD1 => .{ .operation = .CMP, .address_mode = .IndirectY },

        0xE0 => .{ .operation = .CPX, .address_mode = .Immediate },
        0xE4 => .{ .operation = .CPX, .address_mode = .ZeroPage },
        0xEC => .{ .operation = .CPX, .address_mode = .Absolute },

        0xC0 => .{ .operation = .CPY, .address_mode = .Immediate },
        0xC4 => .{ .operation = .CPY, .address_mode = .ZeroPage },
        0xCC => .{ .operation = .CPY, .address_mode = .Absolute },

        0xC6 => .{ .operation = .DEC, .address_mode = .ZeroPage },
        0xD6 => .{ .operation = .DEC, .address_mode = .ZeroPageX },
        0xCE => .{ .operation = .DEC, .address_mode = .Absolute },
        0xDE => .{ .operation = .DEC, .address_mode = .AbsoluteX },

        0xCA => .{ .operation = .DEX, .address_mode = .Implied },

        0x88 => .{ .operation = .DEY, .address_mode = .Implied },

        0x49 => .{ .operation = .EOR, .address_mode = .Immediate },
        0x45 => .{ .operation = .EOR, .address_mode = .ZeroPage },
        0x55 => .{ .operation = .EOR, .address_mode = .ZeroPageX },
        0x4D => .{ .operation = .EOR, .address_mode = .Absolute },
        0x5D => .{ .operation = .EOR, .address_mode = .AbsoluteX },
        0x59 => .{ .operation = .EOR, .address_mode = .AbsoluteY },
        0x41 => .{ .operation = .EOR, .address_mode = .IndirectX },
        0x51 => .{ .operation = .EOR, .address_mode = .IndirectY },

        0xE6 => .{ .operation = .INC, .address_mode = .ZeroPage },
        0xF6 => .{ .operation = .INC, .address_mode = .ZeroPageX },
        0xEE => .{ .operation = .INC, .address_mode = .Absolute },
        0xFE => .{ .operation = .INC, .address_mode = .AbsoluteX },

        0xE8 => .{ .operation = .INX, .address_mode = .Implied },

        0xC8 => .{ .operation = .INY, .address_mode = .Implied },

        0x4C => .{ .operation = .JMP, .address_mode = .Absolute },
        0x6C => .{ .operation = .JMP, .address_mode = .Indirect },

        0x20 => .{ .operation = .JSR, .address_mode = .Absolute },

        0xA9 => .{ .operation = .LDA, .address_mode = .Immediate },
        0xA5 => .{ .operation = .LDA, .address_mode = .ZeroPage },
        0xB5 => .{ .operation = .LDA, .address_mode = .ZeroPageX },
        0xAD => .{ .operation = .LDA, .address_mode = .Absolute },
        0xBD => .{ .operation = .LDA, .address_mode = .AbsoluteX },
        0xB9 => .{ .operation = .LDA, .address_mode = .AbsoluteY },
        0xA1 => .{ .operation = .LDA, .address_mode = .IndirectX },
        0xB1 => .{ .operation = .LDA, .address_mode = .IndirectY },

        0xA2 => .{ .operation = .LDX, .address_mode = .Immediate },
        0xA6 => .{ .operation = .LDX, .address_mode = .ZeroPage },
        0xB6 => .{ .operation = .LDX, .address_mode = .ZeroPageY },
        0xAE => .{ .operation = .LDX, .address_mode = .Absolute },
        0xBE => .{ .operation = .LDX, .address_mode = .AbsoluteY },

        0xA0 => .{ .operation = .LDY, .address_mode = .Immediate },
        0xA4 => .{ .operation = .LDY, .address_mode = .ZeroPage },
        0xB4 => .{ .operation = .LDY, .address_mode = .ZeroPageX },
        0xAC => .{ .operation = .LDY, .address_mode = .Absolute },
        0xBC => .{ .operation = .LDY, .address_mode = .AbsoluteX },

        0x4A => .{ .operation = .LSR, .address_mode = .Accumulator },
        0x46 => .{ .operation = .LSR, .address_mode = .ZeroPage },
        0x56 => .{ .operation = .LSR, .address_mode = .ZeroPageX },
        0x4E => .{ .operation = .LSR, .address_mode = .Absolute },
        0x5E => .{ .operation = .LSR, .address_mode = .AbsoluteX },

        0xEA => .{ .operation = .NOP, .address_mode = .Implied },

        0x09 => .{ .operation = .ORA, .address_mode = .Immediate },
        0x05 => .{ .operation = .ORA, .address_mode = .ZeroPage },
        0x15 => .{ .operation = .ORA, .address_mode = .ZeroPageX },
        0x0D => .{ .operation = .ORA, .address_mode = .Absolute },
        0x1D => .{ .operation = .ORA, .address_mode = .AbsoluteX },
        0x19 => .{ .operation = .ORA, .address_mode = .AbsoluteY },
        0x01 => .{ .operation = .ORA, .address_mode = .IndirectX },
        0x11 => .{ .operation = .ORA, .address_mode = .IndirectY },

        0x48 => .{ .operation = .PHA, .address_mode = .Implied },

        0x08 => .{ .operation = .PHP, .address_mode = .Implied },

        0x68 => .{ .operation = .PLA, .address_mode = .Implied },

        0x28 => .{ .operation = .PLP, .address_mode = .Implied },

        0x2A => .{ .operation = .ROL, .address_mode = .Accumulator },
        0x26 => .{ .operation = .ROL, .address_mode = .ZeroPage },
        0x36 => .{ .operation = .ROL, .address_mode = .ZeroPageX },
        0x2E => .{ .operation = .ROL, .address_mode = .Absolute },
        0x3E => .{ .operation = .ROL, .address_mode = .AbsoluteX },

        0x6A => .{ .operation = .ROR, .address_mode = .Accumulator },
        0x66 => .{ .operation = .ROR, .address_mode = .ZeroPage },
        0x76 => .{ .operation = .ROR, .address_mode = .ZeroPageX },
        0x6E => .{ .operation = .ROR, .address_mode = .Absolute },
        0x7E => .{ .operation = .ROR, .address_mode = .AbsoluteX },

        0x40 => .{ .operation = .RTI, .address_mode = .Implied },

        0x60 => .{ .operation = .RTS, .address_mode = .Implied },

        0xE9 => .{ .operation = .SBC, .address_mode = .Immediate },
        0xE5 => .{ .operation = .SBC, .address_mode = .ZeroPage },
        0xF5 => .{ .operation = .SBC, .address_mode = .ZeroPageX },
        0xED => .{ .operation = .SBC, .address_mode = .Absolute },
        0xFD => .{ .operation = .SBC, .address_mode = .AbsoluteX },
        0xF9 => .{ .operation = .SBC, .address_mode = .AbsoluteY },
        0xE1 => .{ .operation = .SBC, .address_mode = .IndirectX },
        0xF1 => .{ .operation = .SBC, .address_mode = .IndirectY },

        0x38 => .{ .operation = .SEC, .address_mode = .Implied },

        0xF8 => .{ .operation = .SED, .address_mode = .Implied },

        0x78 => .{ .operation = .SEI, .address_mode = .Implied },

        0x85 => .{ .operation = .STA, .address_mode = .ZeroPage },
        0x95 => .{ .operation = .STA, .address_mode = .ZeroPageX },
        0x8D => .{ .operation = .STA, .address_mode = .Absolute },
        0x9D => .{ .operation = .STA, .address_mode = .AbsoluteX },
        0x99 => .{ .operation = .STA, .address_mode = .AbsoluteY },
        0x81 => .{ .operation = .STA, .address_mode = .IndirectX },
        0x91 => .{ .operation = .STA, .address_mode = .IndirectY },

        0x86 => .{ .operation = .STX, .address_mode = .ZeroPage },
        0x96 => .{ .operation = .STX, .address_mode = .ZeroPageY },
        0x8E => .{ .operation = .STX, .address_mode = .Absolute },

        0x84 => .{ .operation = .STY, .address_mode = .ZeroPage },
        0x94 => .{ .operation = .STY, .address_mode = .ZeroPageX },
        0x8C => .{ .operation = .STY, .address_mode = .Absolute },

        0xAA => .{ .operation = .TAX, .address_mode = .Implied },

        0xA8 => .{ .operation = .TAY, .address_mode = .Implied },

        0xBA => .{ .operation = .TSX, .address_mode = .Implied },

        0x8A => .{ .operation = .TXA, .address_mode = .Implied },

        0x9A => .{ .operation = .TXS, .address_mode = .Implied },

        0x98 => .{ .operation = .TYA, .address_mode = .Implied },

        _ => null,
    };
}
