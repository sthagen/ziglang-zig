var foos = [_]fn(anytype) void { foo1, foo2 };

fn foo1(arg: anytype) void {_ = arg;}
fn foo2(arg: anytype) void {_ = arg;}

pub fn main() !void {
    foos[0](true);
}

// error
// backend=stage1
// target=native
//
// tmp.zig:7:9: error: calling a generic function requires compile-time known function value
