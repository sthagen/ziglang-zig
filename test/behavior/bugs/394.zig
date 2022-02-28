const E = union(enum) {
    A: [9]u8,
    B: u64,
};
const S = struct {
    x: u8,
    y: E,
};

const expect = @import("std").testing.expect;
const builtin = @import("builtin");

test "bug 394 fixed" {
    if (builtin.zig_backend == .stage2_aarch64) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_arm) return error.SkipZigTest;
    if (builtin.zig_backend == .stage2_x86_64) return error.SkipZigTest;
    const x = S{
        .x = 3,
        .y = E{ .B = 1 },
    };
    try expect(x.x == 3);
}
