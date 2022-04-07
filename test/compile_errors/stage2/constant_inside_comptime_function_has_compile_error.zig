const ContextAllocator = MemoryPool(usize);

pub fn MemoryPool(comptime T: type) type {
    const free_list_t = @compileError("aoeu",);
    _ = T;

    return struct {
        free_list: free_list_t,
    };
}

export fn entry() void {
    var allocator: ContextAllocator = undefined;
    _ = allocator;
}

// constant inside comptime function has compile error
//
// :4:5: error: unreachable code
// :4:25: note: control flow is diverted here
