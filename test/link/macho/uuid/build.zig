const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjectStep = std.build.LibExeObjStep;

pub fn build(b: *Builder) void {
    const test_step = b.step("test", "Test");
    test_step.dependOn(b.getInstallStep());

    // We force cross-compilation to ensure we always pick a generic CPU with constant set of CPU features.
    const aarch64_macos = std.zig.CrossTarget{
        .cpu_arch = .aarch64,
        .os_tag = .macos,
    };

    testUuid(b, test_step, .ReleaseSafe, aarch64_macos, "af0f4c21a07c30daba59213d80262e45");
    testUuid(b, test_step, .ReleaseFast, aarch64_macos, "af0f4c21a07c30daba59213d80262e45");
    testUuid(b, test_step, .ReleaseSmall, aarch64_macos, "af0f4c21a07c30daba59213d80262e45");

    const x86_64_macos = std.zig.CrossTarget{
        .cpu_arch = .x86_64,
        .os_tag = .macos,
    };

    testUuid(b, test_step, .ReleaseSafe, x86_64_macos, "63f47191c7153f5fba48bd63cb2f5f57");
    testUuid(b, test_step, .ReleaseFast, x86_64_macos, "63f47191c7153f5fba48bd63cb2f5f57");
    testUuid(b, test_step, .ReleaseSmall, x86_64_macos, "e7bba66220e33eda9e73ab293ccf93d2");
}

fn testUuid(
    b: *Builder,
    test_step: *std.build.Step,
    mode: std.builtin.Mode,
    target: std.zig.CrossTarget,
    comptime exp: []const u8,
) void {
    // The calculated UUID value is independent of debug info and so it should
    // stay the same across builds.
    {
        const dylib = simpleDylib(b, mode, target);
        const check_dylib = dylib.checkObject(.macho);
        check_dylib.checkStart("cmd UUID");
        check_dylib.checkNext("uuid " ++ exp);
        test_step.dependOn(&check_dylib.step);
    }
    {
        const dylib = simpleDylib(b, mode, target);
        dylib.strip = true;
        const check_dylib = dylib.checkObject(.macho);
        check_dylib.checkStart("cmd UUID");
        check_dylib.checkNext("uuid " ++ exp);
        test_step.dependOn(&check_dylib.step);
    }
}

fn simpleDylib(b: *Builder, mode: std.builtin.Mode, target: std.zig.CrossTarget) *LibExeObjectStep {
    const dylib = b.addSharedLibrary("test", null, b.version(1, 0, 0));
    dylib.setTarget(target);
    dylib.setBuildMode(mode);
    dylib.addCSourceFile("test.c", &.{});
    dylib.linkLibC();
    return dylib;
}
