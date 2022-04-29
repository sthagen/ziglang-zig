export fn foo_array() void {
    comptime {
        var target = [_]u8{ 'a', 'b', 'c', 'd' } ++ [_]u8{undefined} ** 10;
        const slice = target[0..14 :0];
        _ = slice;
    }
}
export fn foo_ptr_array() void {
    comptime {
        var buf = [_]u8{ 'a', 'b', 'c', 'd' } ++ [_]u8{undefined} ** 10;
        var target = &buf;
        const slice = target[0..14 :0];
        _ = slice;
    }
}
export fn foo_vector_ConstPtrSpecialBaseArray() void {
    comptime {
        var buf = [_]u8{ 'a', 'b', 'c', 'd' } ++ [_]u8{undefined} ** 10;
        var target: [*]u8 = &buf;
        const slice = target[0..14 :0];
        _ = slice;
    }
}
export fn foo_vector_ConstPtrSpecialRef() void {
    comptime {
        var buf = [_]u8{ 'a', 'b', 'c', 'd' } ++ [_]u8{undefined} ** 10;
        var target: [*]u8 = @ptrCast([*]u8, &buf);
        const slice = target[0..14 :0];
        _ = slice;
    }
}
export fn foo_cvector_ConstPtrSpecialBaseArray() void {
    comptime {
        var buf = [_]u8{ 'a', 'b', 'c', 'd' } ++ [_]u8{undefined} ** 10;
        var target: [*c]u8 = &buf;
        const slice = target[0..14 :0];
        _ = slice;
    }
}
export fn foo_cvector_ConstPtrSpecialRef() void {
    comptime {
        var buf = [_]u8{ 'a', 'b', 'c', 'd' } ++ [_]u8{undefined} ** 10;
        var target: [*c]u8 = @ptrCast([*c]u8, &buf);
        const slice = target[0..14 :0];
        _ = slice;
    }
}
export fn foo_slice() void {
    comptime {
        var buf = [_]u8{ 'a', 'b', 'c', 'd' } ++ [_]u8{undefined} ** 10;
        var target: []u8 = &buf;
        const slice = target[0..14 :0];
        _ = slice;
    }
}

// error
// backend=stage1
// target=native
//
// :4:29: error: slice-sentinel is out of bounds
// :12:29: error: slice-sentinel is out of bounds
// :20:29: error: slice-sentinel is out of bounds
// :28:29: error: slice-sentinel is out of bounds
// :36:29: error: slice-sentinel is out of bounds
// :44:29: error: slice-sentinel is out of bounds
// :52:29: error: slice-sentinel is out of bounds
