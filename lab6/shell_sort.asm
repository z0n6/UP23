shell_sort:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov rax, rsi
    mov rcx, rax
    shr rcx, 1
    shell_sort_loop:
        cmp rcx, 0
        jle shell_sort_end
        mov r9, rcx
        shell_sort_loop3:
            mov rbx, r9
            mov rdx, [rdi + rbx*8]
            shell_sort_loop4:
                cmp rbx, rcx
                jl shell_sort_end4
                mov r8, rbx
                sub r8, rcx
                mov rax, [rdi + r8*8]
                cmp rax, rdx
                jle shell_sort_end4
                mov [rdi + rbx*8], rax
                sub rbx, rcx
                jmp shell_sort_loop4
            shell_sort_end4:
                mov [rdi + rbx*8], rdx
                inc r9
                cmp r9, rsi
                jl shell_sort_loop3
        shr rcx, 1
        jmp shell_sort_loop
    shell_sort_end:
    mov rsp, rbp
    pop rbp
    ret