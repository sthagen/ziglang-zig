pub fn main() void {
    var i: u32 = 16;
    assert(i << 1, 32);
}
fn assert(a: u32, b: u32) void {
    if (a != b) unreachable;
}

// run
//
