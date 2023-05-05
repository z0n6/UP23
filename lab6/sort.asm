sort:
    endbr64
    push   rbp
    mov    rbp,rsp
    mov    [rbp-0x18],rdi
    mov    DWORD PTR [rbp-0x1c],esi
    mov    eax,DWORD PTR [rbp-0x1c]
    mov    edx,eax
    shr    edx,0x1f
    add    eax,edx
    sar    eax,1
    mov    DWORD PTR [rbp-0x10],eax
    jmp    f7
f1:
    mov    eax,DWORD PTR [rbp-0x10]
    mov    DWORD PTR [rbp-0xc],eax
    jmp    f6
f2:
    mov    eax,DWORD PTR [rbp-0xc]
    cdqe   
    lea    rdx,[rax*8+0x0]
    
    mov    rax,[rbp-0x18]
    add    rax,rdx
    mov    rax,[rax]
    mov    DWORD PTR [rbp-0x4],eax
    mov    eax,DWORD PTR [rbp-0xc]
    mov    DWORD PTR [rbp-0x8],eax
    jmp    f4
f3:
    mov    eax,DWORD PTR [rbp-0x8]
    sub    eax,DWORD PTR [rbp-0x10]
    cdqe   
    lea    rdx,[rax*8+0x0]
    
    mov    rax,[rbp-0x18]
    add    rax,rdx
    mov    edx,DWORD PTR [rbp-0x8]
    movsxd rdx,edx
    lea    rcx,[rdx*8+0x0]
    
    mov    rdx,[rbp-0x18]
    add    rdx,rcx
    mov    rax,[rax]
    mov    [rdx],rax
    mov    eax,DWORD PTR [rbp-0x10]
    sub    DWORD PTR [rbp-0x8],eax
f4:
    mov    eax,DWORD PTR [rbp-0x8]
    cmp    eax,DWORD PTR [rbp-0x10]
    jl     f5
    mov    eax,DWORD PTR [rbp-0x8]
    sub    eax,DWORD PTR [rbp-0x10]
    cdqe   
    lea    rdx,[rax*8+0x0]
    
    mov    rax,[rbp-0x18]
    add    rax,rdx
    mov    rdx,[rax]
    mov    eax,DWORD PTR [rbp-0x4]
    cdqe   
    cmp    rdx,rax
    jg     f3
f5:
    mov    eax,DWORD PTR [rbp-0x8]
    cdqe   
    lea    rdx,[rax*8+0x0]
    
    mov    rax,[rbp-0x18]
    add    rdx,rax
    mov    eax,DWORD PTR [rbp-0x4]
    cdqe   
    mov    [rdx],rax
    add    DWORD PTR [rbp-0xc],0x1
f6:
    mov    eax,DWORD PTR [rbp-0xc]
    cmp    eax,DWORD PTR [rbp-0x1c]
    jl     f2
    mov    eax,DWORD PTR [rbp-0x10]
    mov    edx,eax
    shr    edx,0x1f
    add    eax,edx
    sar    eax,1
    mov    DWORD PTR [rbp-0x10],eax
f7:
    cmp    DWORD PTR [rbp-0x10],0x0
    jg     f1
    nop
    nop
    pop    rbp
    ret