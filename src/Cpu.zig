a: u8,
x: u8,
y: u8,
pc: u16,
s: u8,
p: Status,

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

