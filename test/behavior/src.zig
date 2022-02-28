fn doTheTest() !void {
    const src = @src(); // do not move

    try expect(src.line == 2);
    try expect(src.column == 17);
    try expect(std.mem.endsWith(u8, src.fn_name, "doTheTest"));
    try expect(std.mem.endsWith(u8, src.file, "src.zig"));
    try expect(src.fn_name[src.fn_name.len] == 0);
    try expect(src.file[src.file.len] == 0);
}

const std = @import("std");
const builtin = @import("builtin");
const expect = std.testing.expect;

test "@src" {
    if (builtin.zig_backend != .stage1) return error.SkipZigTest;

    try doTheTest();
}
