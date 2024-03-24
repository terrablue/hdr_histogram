const std = @import("std");

pub fn build(b: *std.Build) void {
    // Create static library
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "hdr_histogram",
        .target = target,
        .optimize = optimize,
    });
    lib.linkLibC();
    lib.addCSourceFiles(&.{"hdr_histogram.c"}, &.{
        "-std=c99",
        "-Wall",
        "-Os",
        "-g",
        "-DHDR_MALLOC_INCLUDE=\"hdr_redis_malloc.h\"",
    });

    lib.installHeader("hdr_histogram.h", "hdr_histogram.h");
    b.installArtifact(lib);
}
