export fn entry() void {
    foo();
}
fn foo() callconv(.Naked) void { }

// error
// backend=stage1
// target=native
//
// tmp.zig:2:5: error: unable to call function with naked calling convention
// tmp.zig:4:1: note: declared here
