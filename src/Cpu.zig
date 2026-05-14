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

// hardware
a: u8,
x: u8,
y: u8,
pc: u16,
s: u8,
p: Status,
// emulator
clock: u64,

const instruction = @import("instruction.zig");

fn read(self: *@This(), mode: instruction.AddressMode) u8 {
    @panic("TODO");
}

fn write(self: *@This(), mode: instruction.AddressMode, data: u8) void {
    @panic("TODO");
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
        _ => @panic("opcode not implemented yet!")
    }
}
