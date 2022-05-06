const builtin = @import("builtin");

extern "c" fn write(usize, usize, usize) usize;

pub fn main() void {
    for ("hello") |_| print();
}

fn print() void {
    switch (builtin.os.tag) {
        .linux => {
            asm volatile ("syscall"
                :
                : [number] "{rax}" (1),
                  [arg1] "{rdi}" (1),
                  [arg2] "{rsi}" (@ptrToInt("hello\n")),
                  [arg3] "{rdx}" (6),
                : "rcx", "r11", "memory"
            );
        },
        .macos => {
            _ = write(1, @ptrToInt("hello\n"), 6);
        },
        else => unreachable,
    }
}

// run
//
// hello
// hello
// hello
// hello
// hello
//
