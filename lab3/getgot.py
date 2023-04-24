from pwn import *
elf = ELF('./chals')
print("main =", hex(elf.symbols['main']))
# print("{:<12s} {:<8s} {:<8s}".format("Func", "GOT", "Address"))
got = dict()
for g in elf.got:
   if "code_" in g:
    #   print("{:<12s} {:<8x} {:<8x}".format(g, elf.got[g], elf.symbols[g]))
      got.update({g: elf.got[g]})

print("static int off[] = {", end = '')
for i in range(1477):
    if "code_"+str(i) in elf.got:
        print(hex(elf.got["code_"+str(i)]), end=', ')
    else:
        print(0, end=', ')
print("};")
