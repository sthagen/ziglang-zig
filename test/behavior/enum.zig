const std = @import("std");
const expect = std.testing.expect;
const mem = std.mem;
const Tag = std.meta.Tag;

const Point = struct {
    x: u64,
    y: u64,
};
const Foo = union(enum) {
    One: i32,
    Two: Point,
    Three: void,
};
const FooNoVoid = union(enum) {
    One: i32,
    Two: Point,
};
const Bar = enum {
    A,
    B,
    C,
    D,
};

fn returnAnInt(x: i32) Foo {
    return Foo{ .One = x };
}

fn shouldBeEmpty(x: AnEnumWithPayload) void {
    switch (x) {
        AnEnumWithPayload.Empty => {},
        else => unreachable,
    }
}

fn shouldBeNotEmpty(x: AnEnumWithPayload) void {
    switch (x) {
        AnEnumWithPayload.Empty => unreachable,
        else => {},
    }
}

const AnEnumWithPayload = union(enum) {
    Empty: void,
    Full: i32,
};

const Number = enum { Zero, One, Two, Three, Four };

fn shouldEqual(n: Number, expected: u3) !void {
    try expect(@enumToInt(n) == expected);
}

fn testEnumTagNameBare(n: anytype) []const u8 {
    return @tagName(n);
}

const BareNumber = enum { One, Two, Three };

const NonExhaustive = enum(u8) { A, B, _ };

const AlignTestEnum = union(enum) {
    A: [9]u8,
    B: u64,
};

const ValueCount1 = enum {
    I0,
};
const ValueCount2 = enum {
    I0,
    I1,
};
const ValueCount256 = enum {
    I0,
    I1,
    I2,
    I3,
    I4,
    I5,
    I6,
    I7,
    I8,
    I9,
    I10,
    I11,
    I12,
    I13,
    I14,
    I15,
    I16,
    I17,
    I18,
    I19,
    I20,
    I21,
    I22,
    I23,
    I24,
    I25,
    I26,
    I27,
    I28,
    I29,
    I30,
    I31,
    I32,
    I33,
    I34,
    I35,
    I36,
    I37,
    I38,
    I39,
    I40,
    I41,
    I42,
    I43,
    I44,
    I45,
    I46,
    I47,
    I48,
    I49,
    I50,
    I51,
    I52,
    I53,
    I54,
    I55,
    I56,
    I57,
    I58,
    I59,
    I60,
    I61,
    I62,
    I63,
    I64,
    I65,
    I66,
    I67,
    I68,
    I69,
    I70,
    I71,
    I72,
    I73,
    I74,
    I75,
    I76,
    I77,
    I78,
    I79,
    I80,
    I81,
    I82,
    I83,
    I84,
    I85,
    I86,
    I87,
    I88,
    I89,
    I90,
    I91,
    I92,
    I93,
    I94,
    I95,
    I96,
    I97,
    I98,
    I99,
    I100,
    I101,
    I102,
    I103,
    I104,
    I105,
    I106,
    I107,
    I108,
    I109,
    I110,
    I111,
    I112,
    I113,
    I114,
    I115,
    I116,
    I117,
    I118,
    I119,
    I120,
    I121,
    I122,
    I123,
    I124,
    I125,
    I126,
    I127,
    I128,
    I129,
    I130,
    I131,
    I132,
    I133,
    I134,
    I135,
    I136,
    I137,
    I138,
    I139,
    I140,
    I141,
    I142,
    I143,
    I144,
    I145,
    I146,
    I147,
    I148,
    I149,
    I150,
    I151,
    I152,
    I153,
    I154,
    I155,
    I156,
    I157,
    I158,
    I159,
    I160,
    I161,
    I162,
    I163,
    I164,
    I165,
    I166,
    I167,
    I168,
    I169,
    I170,
    I171,
    I172,
    I173,
    I174,
    I175,
    I176,
    I177,
    I178,
    I179,
    I180,
    I181,
    I182,
    I183,
    I184,
    I185,
    I186,
    I187,
    I188,
    I189,
    I190,
    I191,
    I192,
    I193,
    I194,
    I195,
    I196,
    I197,
    I198,
    I199,
    I200,
    I201,
    I202,
    I203,
    I204,
    I205,
    I206,
    I207,
    I208,
    I209,
    I210,
    I211,
    I212,
    I213,
    I214,
    I215,
    I216,
    I217,
    I218,
    I219,
    I220,
    I221,
    I222,
    I223,
    I224,
    I225,
    I226,
    I227,
    I228,
    I229,
    I230,
    I231,
    I232,
    I233,
    I234,
    I235,
    I236,
    I237,
    I238,
    I239,
    I240,
    I241,
    I242,
    I243,
    I244,
    I245,
    I246,
    I247,
    I248,
    I249,
    I250,
    I251,
    I252,
    I253,
    I254,
    I255,
};
const ValueCount257 = enum {
    I0,
    I1,
    I2,
    I3,
    I4,
    I5,
    I6,
    I7,
    I8,
    I9,
    I10,
    I11,
    I12,
    I13,
    I14,
    I15,
    I16,
    I17,
    I18,
    I19,
    I20,
    I21,
    I22,
    I23,
    I24,
    I25,
    I26,
    I27,
    I28,
    I29,
    I30,
    I31,
    I32,
    I33,
    I34,
    I35,
    I36,
    I37,
    I38,
    I39,
    I40,
    I41,
    I42,
    I43,
    I44,
    I45,
    I46,
    I47,
    I48,
    I49,
    I50,
    I51,
    I52,
    I53,
    I54,
    I55,
    I56,
    I57,
    I58,
    I59,
    I60,
    I61,
    I62,
    I63,
    I64,
    I65,
    I66,
    I67,
    I68,
    I69,
    I70,
    I71,
    I72,
    I73,
    I74,
    I75,
    I76,
    I77,
    I78,
    I79,
    I80,
    I81,
    I82,
    I83,
    I84,
    I85,
    I86,
    I87,
    I88,
    I89,
    I90,
    I91,
    I92,
    I93,
    I94,
    I95,
    I96,
    I97,
    I98,
    I99,
    I100,
    I101,
    I102,
    I103,
    I104,
    I105,
    I106,
    I107,
    I108,
    I109,
    I110,
    I111,
    I112,
    I113,
    I114,
    I115,
    I116,
    I117,
    I118,
    I119,
    I120,
    I121,
    I122,
    I123,
    I124,
    I125,
    I126,
    I127,
    I128,
    I129,
    I130,
    I131,
    I132,
    I133,
    I134,
    I135,
    I136,
    I137,
    I138,
    I139,
    I140,
    I141,
    I142,
    I143,
    I144,
    I145,
    I146,
    I147,
    I148,
    I149,
    I150,
    I151,
    I152,
    I153,
    I154,
    I155,
    I156,
    I157,
    I158,
    I159,
    I160,
    I161,
    I162,
    I163,
    I164,
    I165,
    I166,
    I167,
    I168,
    I169,
    I170,
    I171,
    I172,
    I173,
    I174,
    I175,
    I176,
    I177,
    I178,
    I179,
    I180,
    I181,
    I182,
    I183,
    I184,
    I185,
    I186,
    I187,
    I188,
    I189,
    I190,
    I191,
    I192,
    I193,
    I194,
    I195,
    I196,
    I197,
    I198,
    I199,
    I200,
    I201,
    I202,
    I203,
    I204,
    I205,
    I206,
    I207,
    I208,
    I209,
    I210,
    I211,
    I212,
    I213,
    I214,
    I215,
    I216,
    I217,
    I218,
    I219,
    I220,
    I221,
    I222,
    I223,
    I224,
    I225,
    I226,
    I227,
    I228,
    I229,
    I230,
    I231,
    I232,
    I233,
    I234,
    I235,
    I236,
    I237,
    I238,
    I239,
    I240,
    I241,
    I242,
    I243,
    I244,
    I245,
    I246,
    I247,
    I248,
    I249,
    I250,
    I251,
    I252,
    I253,
    I254,
    I255,
    I256,
};

const Small2 = enum(u2) { One, Two };
const Small = enum(u2) { One, Two, Three, Four };

const A = enum(u3) { One, Two, Three, Four, One2, Two2, Three2, Four2 };
const B = enum(u3) { One3, Two3, Three3, Four3, One23, Two23, Three23, Four23 };
const C = enum(u2) { One4, Two4, Three4, Four4 };

const BitFieldOfEnums = packed struct {
    a: A,
    b: B,
    c: C,
};

const bit_field_1 = BitFieldOfEnums{
    .a = A.Two,
    .b = B.Three3,
    .c = C.Four4,
};

fn getA(data: *const BitFieldOfEnums) A {
    return data.a;
}

fn getB(data: *const BitFieldOfEnums) B {
    return data.b;
}

fn getC(data: *const BitFieldOfEnums) C {
    return data.c;
}

const MultipleChoice = enum(u32) {
    A = 20,
    B = 40,
    C = 60,
    D = 1000,
};

const MultipleChoice2 = enum(u32) {
    Unspecified1,
    A = 20,
    Unspecified2,
    B = 40,
    Unspecified3,
    C = 60,
    Unspecified4,
    D = 1000,
    Unspecified5,
};

const EnumWithOneMember = enum { Eof };

fn doALoopThing(id: EnumWithOneMember) void {
    while (true) {
        if (id == EnumWithOneMember.Eof) {
            break;
        }
        @compileError("above if condition should be comptime");
    }
}

const State = enum { Start };

const EnumWithTagValues = enum(u4) {
    A = 1 << 0,
    B = 1 << 1,
    C = 1 << 2,
    D = 1 << 3,
};

test "enum to int" {
    try shouldEqual(Number.Zero, 0);
    try shouldEqual(Number.One, 1);
    try shouldEqual(Number.Two, 2);
    try shouldEqual(Number.Three, 3);
    try shouldEqual(Number.Four, 4);
}

test "enum sizes" {
    comptime {
        try expect(@sizeOf(ValueCount1) == 0);
        try expect(@sizeOf(ValueCount2) == 1);
        try expect(@sizeOf(ValueCount256) == 1);
        try expect(@sizeOf(ValueCount257) == 2);
    }
}

test "enum literal equality" {
    const x = .hi;
    const y = .ok;
    const z = .hi;

    try expect(x != y);
    try expect(x == z);
}

test "enum literal cast to enum" {
    const Color = enum { Auto, Off, On };

    var color1: Color = .Auto;
    var color2 = Color.Auto;
    try expect(color1 == color2);
}

test "peer type resolution with enum literal" {
    const Items = enum { one, two };

    try expect(Items.two == .two);
    try expect(.two == Items.two);
}
