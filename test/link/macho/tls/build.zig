const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const target: std.zig.CrossTarget = .{ .os_tag = .macos };

    const lib = b.addSharedLibrary("a", null, b.version(1, 0, 0));
    lib.setBuildMode(mode);
    lib.setTarget(target);
    lib.addCSourceFile("a.c", &.{});
    lib.linkLibC();

    const test_exe = b.addTest("main.zig");
    test_exe.setBuildMode(mode);
    test_exe.setTarget(target);
    test_exe.linkLibrary(lib);
    test_exe.linkLibC();

    const test_step = b.step("test", "Test it");
    test_step.dependOn(&test_exe.step);
}
