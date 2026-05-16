const Status = packed struct (u8) {
    carry: u1,
    zero: u1,
    interupt_disable: u1,
    decimal: u1,
    b_flag: u1,
    one: u1,
    overflow: u1,
    negative: u1,
};

const Bus = @import("Bus.zig");

a: u8,
x: u8,
y: u8,
pc: u16,
s: u8,
p: Status,
bus: *Bus,

const instruction = @import("instruction.zig");

const Operand = union(enum) {
    addr: u16,
    accumulator,
};

fn decode(self: *@This()) void {
    const raw_opcode = self.bus.read(self.pc);

    self.pc += 1;

    const inst = instruction.decode(raw_opcode)
        orelse @panic("unknown opcode");

    // TODO
    const operand = switch (inst.address_mode) {
        .Absolute => null,
        .AbsoluteX => null,
        .AbsoluteY => null,
        .Accumulator => Operand{ .accumulator },
        .Immediate => null,
        .Implied => null,
        .Indirect => null,
        .IndirectX => null,
        .IndirectY => null,
        .Relative => null,
        .ZeroPage => null,
        .ZeroPageX => null,
        .ZeroPageY => null,
    };
}

fn read(self: *@This(), mode: instruction.AddressMode) u8 {
    _ = self;
    _ = mode;
    @panic("TODO");
}

fn write(self: *@This(), mode: instruction.AddressMode, data: u8) void {
    _ = self;
    _ = mode;
    _ = data;
    @panic("TODO");
}

fn branch(self: *@This()) void {
    _ = self;
    @panic("TODO");
}

fn bit(byte: u8, bit_number: u8) u1 {
    return @as(u1, (byte >> bit_number) & 0b1);
}

pub fn execOne(self: *@This()) void {

    const raw_op = self.read(instruction.AddressMode.Immediate);

    const op = instruction.decode(raw_op) 
        orelse @panic("unknown instruction");

    switch (op.operation) {
        .ADC => {
            const operand = self.read(op.address_mode);

            const result1, const carry1 = @addWithOverflow(self.a, operand);
            const result, const carry2 = @addWithOverflow(result1, self.p.carry);

            self.p.carry = carry1 | carry2;
            self.p.zero = result == 0;
            self.p.overflow = (result ^ self.a) & (result ^ operand) & 0x80 != 0;
            self.p.negative = result & 0x80 != 0;

            self.a = result;
        },
        .AND => {
            const operand = self.read(op.address_mode);
            const result = self.a & operand;

            self.p.zero = result == 0;
            self.p.negative = result & 0x80 != 0;

            self.a = result;
        },
        .ASL => {
            const value = self.read(op.address_mode);
            const result = value << 1;

            self.p.carry = value & 0x80 != 0;
            self.p.zero = result == 0;
            self.p.negative = result & 0x80 != 0;

            self.write(op.address_mode, result);
        },
        .BCC => if (self.p.carry == 0) self.branch(),
        .BCS => if (self.p.carry == 1) self.branch(),
        .BEQ => if (self.p.zero == 1) self.branch(),
        .BIT => {
            const operand = self.read(op.address_mode);
            const result = self.a & operand;

            self.p.zero = result == 0;
            self.p.overflow = bit(result, 6);
            self.p.negative = bit(result, 7);
        },
        .BMI => if (self.p.negative == 1) self.branch(),
        .BNE => if (self.p.zero == 0) self.branch(),
        .BPL => if (self.p.negative == 0) self.branch(),
        .BRK => @panic("TODO"),
        .BVC => if (self.p.overflow == 0) self.branch(),
        .BVS => if (self.p.overflow == 1) self.branch(),
        .CLC => self.p.carry = 0,
        .CLD => self.p.decimal = 0,
        .CLI => self.p.interupt_disable = 0,
        .CLV => self.p.overflow = 0,
        .CMP => {
            const operand = self.read(op.address_mode);

            self.p.carry = self.a >= operand;
            self.p.zero = self.a == operand;
            self.p.negative = bit(self.a - operand, 7);
        },
        .CPX => {
            const operand = self.read(op.address_mode);

            self.p.carry = self.x >= operand;
            self.p.zero = self.x == operand;
            self.p.negative = bit(self.x - operand, 7);
        },
        .CPY => {
            const operand = self.read(op.address_mode);

            self.p.carry = self.y >= operand;
            self.p.zero = self.y == operand;
            self.p.negative = bit(self.y - operand, 7);
        },
        .DEC => {
            const operand = self.read(op.address_mode);
            const result = operand - 1;

            self.p.zero = result == 0;
            self.p.negative = bit(result, 7);

            self.write(op.address_mode, result);
        },
        .DEX => {
            const result = self.x - 1;

            self.p.zero = result == 0;
            self.p.negative = bit(result, 7);

            self.x = result;
        },
        .DEY => {
            const result = self.y - 1;

            self.p.zero = result == 0;
            self.p.negative = bit(result, 7);

            self.y = result;
        },
        .EOR => {
            const operand = self.read(op.address_mode);
            const result = self.a ^ operand;

            self.p.zero = result == 0;
            self.p.negative = bit(result, 7);

            self.a = result;
        },
        .INC => {
            const operand = self.read(op.address_mode);
            const result = operand + 1;

            self.p.zero = result == 0;
            self.p.negative = bit(result, 7);

            self.write(op.address_mode, result);
        },
        .INX => {
            const result = self.x + 1;

            self.p.zero = result == 0;
            self.p.negative = bit(result, 7);

            self.x = result;
        },
        .INY => {
            const result = self.y + 1;

            self.p.zero = result == 0;
            self.p.negative = bit(result, 7);

            self.y = result;
        },
        .JMP => @panic("TODO"),
        .JSR => @panic("TODO"),
        .LDA => {
            const result = self.read(op.address_mode);

            self.p.zero = result == 0;
            self.p.negative = bit(result, 7);

            self.a = result;
        },
        .LDX => {
            const result = self.read(op.address_mode);

            self.p.zero = result == 0;
            self.p.negative = bit(result, 7);

            self.x = result;
        },
        .LDY => {
            const result = self.read(op.address_mode);

            self.p.zero = result == 0;
            self.p.negative = bit(result, 7);

            self.y = result;
        },
        .LSR => {
            const operand = self.read(op.address_mode);
            const result = operand >> 1;

            self.p.carry = bit(operand, 0);
            self.p.zero = result == 0;
            self.p.negative = 0;

            self.write(op.address_mode, result);
        },
        _ => @panic("opcode not implemented!")
    }
}
