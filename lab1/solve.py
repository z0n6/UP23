#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import base64
import hashlib
import time
from pwn import *

def encode_integer_as_base64(num):
    # Convert integer to little-endian byte string
    byte_str = num.to_bytes((num.bit_length() + 7) // 8, byteorder='little')

    return base64.b64encode(byte_str).decode('ascii')

def solve_pow(r):
    prefix = r.recvline().decode().split("'")[1]
    print(time.time(), "solving pow ...")
    solved = b''
    for i in range(1000000000):
        h = hashlib.sha1((prefix + str(i)).encode()).hexdigest()
        if h[:6] == '000000':
            solved = str(i).encode()
            print("solved =", solved)
            break;
    print(time.time(), "done.")

    r.sendlineafter(b'string S: ', base64.b64encode(solved))

if __name__ == '__main__':
    #r = remote('localhost', 10330);
    r = remote('up23.zoolab.org', 10363)
    solve_pow(r)

    r.recvuntil(b'Please complete the ')
    times = r.recvuntil(b' challenges in a limited time.\n', drop=True)
    print("#challenges: ", int(times))

    for i in range(int(times)):
        try:
            r.recvuntil(b': ')
            eq = r.recvuntil(b' = ?', drop=True).decode("utf-8")
            x = eval(eq)
            print(eq, " = ", x, "(", encode_integer_as_base64(x), ")")

            r.sendline(encode_integer_as_base64(x).encode())
        except: 
            break
            
    r.interactive()
    r.close()

# vim: set tabstop=4 expandtab shiftwidth=4 softtabstop=4 number cindent fileencoding=utf-8 :
