export fn foo() void {
    while (bar()) |x| {_ = x;}
}
fn bar() anyerror!i32 { return 1; }

// error
// backend=stage1
// target=native
//
// tmp.zig:2:15: error: expected optional type, found 'anyerror!i32'
