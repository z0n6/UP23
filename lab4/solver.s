
solver:     file format elf64-x86-64


Disassembly of section .interp:

0000000000000318 <.interp>:
 318:	2f                   	(bad)  
 319:	6c                   	ins    BYTE PTR es:[rdi],dx
 31a:	69 62 36 34 2f 6c 64 	imul   esp,DWORD PTR [rdx+0x36],0x646c2f34
 321:	2d 6c 69 6e 75       	sub    eax,0x756e696c
 326:	78 2d                	js     355 <__abi_tag-0x37>
 328:	78 38                	js     362 <__abi_tag-0x2a>
 32a:	36 2d 36 34 2e 73    	ss sub eax,0x732e3436
 330:	6f                   	outs   dx,DWORD PTR ds:[rsi]
 331:	2e 32 00             	cs xor al,BYTE PTR [rax]

Disassembly of section .note.gnu.property:

0000000000000338 <.note.gnu.property>:
 338:	04 00                	add    al,0x0
 33a:	00 00                	add    BYTE PTR [rax],al
 33c:	20 00                	and    BYTE PTR [rax],al
 33e:	00 00                	add    BYTE PTR [rax],al
 340:	05 00 00 00 47       	add    eax,0x47000000
 345:	4e 55                	rex.WRX push rbp
 347:	00 02                	add    BYTE PTR [rdx],al
 349:	00 00                	add    BYTE PTR [rax],al
 34b:	c0 04 00 00          	rol    BYTE PTR [rax+rax*1],0x0
 34f:	00 03                	add    BYTE PTR [rbx],al
 351:	00 00                	add    BYTE PTR [rax],al
 353:	00 00                	add    BYTE PTR [rax],al
 355:	00 00                	add    BYTE PTR [rax],al
 357:	00 02                	add    BYTE PTR [rdx],al
 359:	80 00 c0             	add    BYTE PTR [rax],0xc0
 35c:	04 00                	add    al,0x0
 35e:	00 00                	add    BYTE PTR [rax],al
 360:	01 00                	add    DWORD PTR [rax],eax
 362:	00 00                	add    BYTE PTR [rax],al
 364:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .note.gnu.build-id:

0000000000000368 <.note.gnu.build-id>:
 368:	04 00                	add    al,0x0
 36a:	00 00                	add    BYTE PTR [rax],al
 36c:	14 00                	adc    al,0x0
 36e:	00 00                	add    BYTE PTR [rax],al
 370:	03 00                	add    eax,DWORD PTR [rax]
 372:	00 00                	add    BYTE PTR [rax],al
 374:	47                   	rex.RXB
 375:	4e 55                	rex.WRX push rbp
 377:	00 84 6f 8e eb 1f 63 	add    BYTE PTR [rdi+rbp*2+0x631feb8e],al
 37e:	3a e2                	cmp    ah,dl
 380:	fe                   	(bad)  
 381:	db 3a                	fstp   TBYTE PTR [rdx]
 383:	d2 60 2b             	shl    BYTE PTR [rax+0x2b],cl
 386:	12 52 61             	adc    dl,BYTE PTR [rdx+0x61]
 389:	ab                   	stos   DWORD PTR es:[rdi],eax
 38a:	f9                   	stc    
 38b:	0a                   	.byte 0xa

Disassembly of section .note.ABI-tag:

000000000000038c <__abi_tag>:
 38c:	04 00                	add    al,0x0
 38e:	00 00                	add    BYTE PTR [rax],al
 390:	10 00                	adc    BYTE PTR [rax],al
 392:	00 00                	add    BYTE PTR [rax],al
 394:	01 00                	add    DWORD PTR [rax],eax
 396:	00 00                	add    BYTE PTR [rax],al
 398:	47                   	rex.RXB
 399:	4e 55                	rex.WRX push rbp
 39b:	00 00                	add    BYTE PTR [rax],al
 39d:	00 00                	add    BYTE PTR [rax],al
 39f:	00 03                	add    BYTE PTR [rbx],al
 3a1:	00 00                	add    BYTE PTR [rax],al
 3a3:	00 02                	add    BYTE PTR [rdx],al
 3a5:	00 00                	add    BYTE PTR [rax],al
 3a7:	00 00                	add    BYTE PTR [rax],al
 3a9:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .gnu.hash:

00000000000003b0 <.gnu.hash>:
 3b0:	02 00                	add    al,BYTE PTR [rax]
 3b2:	00 00                	add    BYTE PTR [rax],al
 3b4:	06                   	(bad)  
 3b5:	00 00                	add    BYTE PTR [rax],al
 3b7:	00 01                	add    BYTE PTR [rcx],al
 3b9:	00 00                	add    BYTE PTR [rax],al
 3bb:	00 06                	add    BYTE PTR [rsi],al
 3bd:	00 00                	add    BYTE PTR [rax],al
 3bf:	00 00                	add    BYTE PTR [rax],al
 3c1:	00 81 00 00 40 00    	add    BYTE PTR [rcx+0x400000],al
 3c7:	01 06                	add    DWORD PTR [rsi],eax
 3c9:	00 00                	add    BYTE PTR [rax],al
 3cb:	00 00                	add    BYTE PTR [rax],al
 3cd:	00 00                	add    BYTE PTR [rax],al
 3cf:	00 b8 2b 6b 15 d1    	add    BYTE PTR [rax-0x2eea94d5],bh
 3d5:	65 ce                	gs (bad) 
 3d7:	6d                   	ins    DWORD PTR es:[rdi],dx

Disassembly of section .dynsym:

00000000000003d8 <.dynsym>:
	...
 3f0:	10 00                	adc    BYTE PTR [rax],al
 3f2:	00 00                	add    BYTE PTR [rax],al
 3f4:	12 00                	adc    al,BYTE PTR [rax]
	...
 406:	00 00                	add    BYTE PTR [rax],al
 408:	65 00 00             	add    BYTE PTR gs:[rax],al
 40b:	00 20                	add    BYTE PTR [rax],ah
	...
 41d:	00 00                	add    BYTE PTR [rax],al
 41f:	00 22                	add    BYTE PTR [rdx],ah
 421:	00 00                	add    BYTE PTR [rax],al
 423:	00 12                	add    BYTE PTR [rdx],dl
	...
 435:	00 00                	add    BYTE PTR [rax],al
 437:	00 81 00 00 00 20    	add    BYTE PTR [rcx+0x20000000],al
	...
 44d:	00 00                	add    BYTE PTR [rax],al
 44f:	00 90 00 00 00 20    	add    BYTE PTR [rax+0x20000000],dl
	...
 465:	00 00                	add    BYTE PTR [rax],al
 467:	00 33                	add    BYTE PTR [rbx],dh
 469:	00 00                	add    BYTE PTR [rax],al
 46b:	00 12                	add    BYTE PTR [rdx],dl
	...
 47d:	00 00                	add    BYTE PTR [rax],al
 47f:	00 01                	add    BYTE PTR [rcx],al
 481:	00 00                	add    BYTE PTR [rax],al
 483:	00 22                	add    BYTE PTR [rdx],ah
	...

Disassembly of section .dynstr:

0000000000000498 <.dynstr>:
 498:	00 5f 5f             	add    BYTE PTR [rdi+0x5f],bl
 49b:	63 78 61             	movsxd edi,DWORD PTR [rax+0x61]
 49e:	5f                   	pop    rdi
 49f:	66 69 6e 61 6c 69    	imul   bp,WORD PTR [rsi+0x61],0x696c
 4a5:	7a 65                	jp     50c <__abi_tag+0x180>
 4a7:	00 5f 5f             	add    BYTE PTR [rdi+0x5f],bl
 4aa:	6c                   	ins    BYTE PTR es:[rdi],dx
 4ab:	69 62 63 5f 73 74 61 	imul   esp,DWORD PTR [rdx+0x63],0x6174735f
 4b2:	72 74                	jb     528 <__abi_tag+0x19c>
 4b4:	5f                   	pop    rdi
 4b5:	6d                   	ins    DWORD PTR es:[rdi],dx
 4b6:	61                   	(bad)  
 4b7:	69 6e 00 5f 5f 73 74 	imul   ebp,DWORD PTR [rsi+0x0],0x74735f5f
 4be:	61                   	(bad)  
 4bf:	63 6b 5f             	movsxd ebp,DWORD PTR [rbx+0x5f]
 4c2:	63 68 6b             	movsxd ebp,DWORD PTR [rax+0x6b]
 4c5:	5f                   	pop    rdi
 4c6:	66 61                	data16 (bad) 
 4c8:	69 6c 00 70 72 69 6e 	imul   ebp,DWORD PTR [rax+rax*1+0x70],0x746e6972
 4cf:	74 
 4d0:	66 00 6c 69 62       	data16 add BYTE PTR [rcx+rbp*2+0x62],ch
 4d5:	63 2e                	movsxd ebp,DWORD PTR [rsi]
 4d7:	73 6f                	jae    548 <__abi_tag+0x1bc>
 4d9:	2e 36 00 47 4c       	cs ss add BYTE PTR [rdi+0x4c],al
 4de:	49                   	rex.WB
 4df:	42                   	rex.X
 4e0:	43 5f                	rex.XB pop r15
 4e2:	32 2e                	xor    ch,BYTE PTR [rsi]
 4e4:	32 2e                	xor    ch,BYTE PTR [rsi]
 4e6:	35 00 47 4c 49       	xor    eax,0x494c4700
 4eb:	42                   	rex.X
 4ec:	43 5f                	rex.XB pop r15
 4ee:	32 2e                	xor    ch,BYTE PTR [rsi]
 4f0:	34 00                	xor    al,0x0
 4f2:	47                   	rex.RXB
 4f3:	4c                   	rex.WR
 4f4:	49                   	rex.WB
 4f5:	42                   	rex.X
 4f6:	43 5f                	rex.XB pop r15
 4f8:	32 2e                	xor    ch,BYTE PTR [rsi]
 4fa:	33 34 00             	xor    esi,DWORD PTR [rax+rax*1]
 4fd:	5f                   	pop    rdi
 4fe:	49 54                	rex.WB push r12
 500:	4d 5f                	rex.WRB pop r15
 502:	64 65 72 65          	fs gs jb 56b <__abi_tag+0x1df>
 506:	67 69 73 74 65 72 54 	imul   esi,DWORD PTR [ebx+0x74],0x4d547265
 50d:	4d 
 50e:	43 6c                	rex.XB ins BYTE PTR es:[rdi],dx
 510:	6f                   	outs   dx,DWORD PTR ds:[rsi]
 511:	6e                   	outs   dx,BYTE PTR ds:[rsi]
 512:	65 54                	gs push rsp
 514:	61                   	(bad)  
 515:	62                   	(bad)  
 516:	6c                   	ins    BYTE PTR es:[rdi],dx
 517:	65 00 5f 5f          	add    BYTE PTR gs:[rdi+0x5f],bl
 51b:	67 6d                	ins    DWORD PTR es:[edi],dx
 51d:	6f                   	outs   dx,DWORD PTR ds:[rsi]
 51e:	6e                   	outs   dx,BYTE PTR ds:[rsi]
 51f:	5f                   	pop    rdi
 520:	73 74                	jae    596 <__abi_tag+0x20a>
 522:	61                   	(bad)  
 523:	72 74                	jb     599 <__abi_tag+0x20d>
 525:	5f                   	pop    rdi
 526:	5f                   	pop    rdi
 527:	00 5f 49             	add    BYTE PTR [rdi+0x49],bl
 52a:	54                   	push   rsp
 52b:	4d 5f                	rex.WRB pop r15
 52d:	72 65                	jb     594 <__abi_tag+0x208>
 52f:	67 69 73 74 65 72 54 	imul   esi,DWORD PTR [ebx+0x74],0x4d547265
 536:	4d 
 537:	43 6c                	rex.XB ins BYTE PTR es:[rdi],dx
 539:	6f                   	outs   dx,DWORD PTR ds:[rsi]
 53a:	6e                   	outs   dx,BYTE PTR ds:[rsi]
 53b:	65 54                	gs push rsp
 53d:	61                   	(bad)  
 53e:	62                   	.byte 0x62
 53f:	6c                   	ins    BYTE PTR es:[rdi],dx
 540:	65                   	gs
	...

Disassembly of section .gnu.version:

0000000000000542 <.gnu.version>:
 542:	00 00                	add    BYTE PTR [rax],al
 544:	02 00                	add    al,BYTE PTR [rax]
 546:	01 00                	add    DWORD PTR [rax],eax
 548:	03 00                	add    eax,DWORD PTR [rax]
 54a:	01 00                	add    DWORD PTR [rax],eax
 54c:	01 00                	add    DWORD PTR [rax],eax
 54e:	04 00                	add    al,0x0
 550:	04 00                	add    al,0x0

Disassembly of section .gnu.version_r:

0000000000000558 <.gnu.version_r>:
 558:	01 00                	add    DWORD PTR [rax],eax
 55a:	03 00                	add    eax,DWORD PTR [rax]
 55c:	3a 00                	cmp    al,BYTE PTR [rax]
 55e:	00 00                	add    BYTE PTR [rax],al
 560:	10 00                	adc    BYTE PTR [rax],al
 562:	00 00                	add    BYTE PTR [rax],al
 564:	00 00                	add    BYTE PTR [rax],al
 566:	00 00                	add    BYTE PTR [rax],al
 568:	75 1a                	jne    584 <__abi_tag+0x1f8>
 56a:	69 09 00 00 04 00    	imul   ecx,DWORD PTR [rcx],0x40000
 570:	44 00 00             	add    BYTE PTR [rax],r8b
 573:	00 10                	add    BYTE PTR [rax],dl
 575:	00 00                	add    BYTE PTR [rax],al
 577:	00 14 69             	add    BYTE PTR [rcx+rbp*2],dl
 57a:	69 0d 00 00 03 00 50 	imul   ecx,DWORD PTR [rip+0x30000],0x50        # 30584 <_end+0x2c56c>
 581:	00 00 00 
 584:	10 00                	adc    BYTE PTR [rax],al
 586:	00 00                	add    BYTE PTR [rax],al
 588:	b4 91                	mov    ah,0x91
 58a:	96                   	xchg   esi,eax
 58b:	06                   	(bad)  
 58c:	00 00                	add    BYTE PTR [rax],al
 58e:	02 00                	add    al,BYTE PTR [rax]
 590:	5a                   	pop    rdx
 591:	00 00                	add    BYTE PTR [rax],al
 593:	00 00                	add    BYTE PTR [rax],al
 595:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .rela.dyn:

0000000000000598 <.rela.dyn>:
 598:	b0 3d                	mov    al,0x3d
 59a:	00 00                	add    BYTE PTR [rax],al
 59c:	00 00                	add    BYTE PTR [rax],al
 59e:	00 00                	add    BYTE PTR [rax],al
 5a0:	08 00                	or     BYTE PTR [rax],al
 5a2:	00 00                	add    BYTE PTR [rax],al
 5a4:	00 00                	add    BYTE PTR [rax],al
 5a6:	00 00                	add    BYTE PTR [rax],al
 5a8:	50                   	push   rax
 5a9:	11 00                	adc    DWORD PTR [rax],eax
 5ab:	00 00                	add    BYTE PTR [rax],al
 5ad:	00 00                	add    BYTE PTR [rax],al
 5af:	00 b8 3d 00 00 00    	add    BYTE PTR [rax+0x3d],bh
 5b5:	00 00                	add    BYTE PTR [rax],al
 5b7:	00 08                	add    BYTE PTR [rax],cl
 5b9:	00 00                	add    BYTE PTR [rax],al
 5bb:	00 00                	add    BYTE PTR [rax],al
 5bd:	00 00                	add    BYTE PTR [rax],al
 5bf:	00 10                	add    BYTE PTR [rax],dl
 5c1:	11 00                	adc    DWORD PTR [rax],eax
 5c3:	00 00                	add    BYTE PTR [rax],al
 5c5:	00 00                	add    BYTE PTR [rax],al
 5c7:	00 08                	add    BYTE PTR [rax],cl
 5c9:	40 00 00             	rex add BYTE PTR [rax],al
 5cc:	00 00                	add    BYTE PTR [rax],al
 5ce:	00 00                	add    BYTE PTR [rax],al
 5d0:	08 00                	or     BYTE PTR [rax],al
 5d2:	00 00                	add    BYTE PTR [rax],al
 5d4:	00 00                	add    BYTE PTR [rax],al
 5d6:	00 00                	add    BYTE PTR [rax],al
 5d8:	08 40 00             	or     BYTE PTR [rax+0x0],al
 5db:	00 00                	add    BYTE PTR [rax],al
 5dd:	00 00                	add    BYTE PTR [rax],al
 5df:	00 d0                	add    al,dl
 5e1:	3f                   	(bad)  
 5e2:	00 00                	add    BYTE PTR [rax],al
 5e4:	00 00                	add    BYTE PTR [rax],al
 5e6:	00 00                	add    BYTE PTR [rax],al
 5e8:	06                   	(bad)  
 5e9:	00 00                	add    BYTE PTR [rax],al
 5eb:	00 01                	add    BYTE PTR [rcx],al
	...
 5f5:	00 00                	add    BYTE PTR [rax],al
 5f7:	00 d8                	add    al,bl
 5f9:	3f                   	(bad)  
 5fa:	00 00                	add    BYTE PTR [rax],al
 5fc:	00 00                	add    BYTE PTR [rax],al
 5fe:	00 00                	add    BYTE PTR [rax],al
 600:	06                   	(bad)  
 601:	00 00                	add    BYTE PTR [rax],al
 603:	00 02                	add    BYTE PTR [rdx],al
	...
 60d:	00 00                	add    BYTE PTR [rax],al
 60f:	00 e0                	add    al,ah
 611:	3f                   	(bad)  
 612:	00 00                	add    BYTE PTR [rax],al
 614:	00 00                	add    BYTE PTR [rax],al
 616:	00 00                	add    BYTE PTR [rax],al
 618:	06                   	(bad)  
 619:	00 00                	add    BYTE PTR [rax],al
 61b:	00 06                	add    BYTE PTR [rsi],al
	...
 625:	00 00                	add    BYTE PTR [rax],al
 627:	00 e8                	add    al,ch
 629:	3f                   	(bad)  
 62a:	00 00                	add    BYTE PTR [rax],al
 62c:	00 00                	add    BYTE PTR [rax],al
 62e:	00 00                	add    BYTE PTR [rax],al
 630:	06                   	(bad)  
 631:	00 00                	add    BYTE PTR [rax],al
 633:	00 04 00             	add    BYTE PTR [rax+rax*1],al
	...
 63e:	00 00                	add    BYTE PTR [rax],al
 640:	f0 3f                	lock (bad) 
 642:	00 00                	add    BYTE PTR [rax],al
 644:	00 00                	add    BYTE PTR [rax],al
 646:	00 00                	add    BYTE PTR [rax],al
 648:	06                   	(bad)  
 649:	00 00                	add    BYTE PTR [rax],al
 64b:	00 05 00 00 00 00    	add    BYTE PTR [rip+0x0],al        # 651 <__abi_tag+0x2c5>
 651:	00 00                	add    BYTE PTR [rax],al
 653:	00 00                	add    BYTE PTR [rax],al
 655:	00 00                	add    BYTE PTR [rax],al
 657:	00 f8                	add    al,bh
 659:	3f                   	(bad)  
 65a:	00 00                	add    BYTE PTR [rax],al
 65c:	00 00                	add    BYTE PTR [rax],al
 65e:	00 00                	add    BYTE PTR [rax],al
 660:	06                   	(bad)  
 661:	00 00                	add    BYTE PTR [rax],al
 663:	00 07                	add    BYTE PTR [rdi],al
	...

Disassembly of section .rela.plt:

0000000000000670 <.rela.plt>:
 670:	c8 3f 00 00          	enter  0x3f,0x0
 674:	00 00                	add    BYTE PTR [rax],al
 676:	00 00                	add    BYTE PTR [rax],al
 678:	07                   	(bad)  
 679:	00 00                	add    BYTE PTR [rax],al
 67b:	00 03                	add    BYTE PTR [rbx],al
	...

Disassembly of section .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64 
    1004:	48 83 ec 08          	sub    rsp,0x8
    1008:	48 8b 05 d9 2f 00 00 	mov    rax,QWORD PTR [rip+0x2fd9]        # 3fe8 <__gmon_start__@Base>
    100f:	48 85 c0             	test   rax,rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	call   rax
    1016:	48 83 c4 08          	add    rsp,0x8
    101a:	c3                   	ret    

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	ff 35 92 2f 00 00    	push   QWORD PTR [rip+0x2f92]        # 3fb8 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	f2 ff 25 93 2f 00 00 	bnd jmp QWORD PTR [rip+0x2f93]        # 3fc0 <_GLOBAL_OFFSET_TABLE_+0x10>
    102d:	0f 1f 00             	nop    DWORD PTR [rax]
    1030:	f3 0f 1e fa          	endbr64 
    1034:	68 00 00 00 00       	push   0x0
    1039:	f2 e9 e1 ff ff ff    	bnd jmp 1020 <_init+0x20>
    103f:	90                   	nop

Disassembly of section .plt.got:

0000000000001040 <printf@plt>:
    1040:	f3 0f 1e fa          	endbr64 
    1044:	f2 ff 25 95 2f 00 00 	bnd jmp QWORD PTR [rip+0x2f95]        # 3fe0 <printf@GLIBC_2.2.5>
    104b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]

0000000000001050 <__cxa_finalize@plt>:
    1050:	f3 0f 1e fa          	endbr64 
    1054:	f2 ff 25 9d 2f 00 00 	bnd jmp QWORD PTR [rip+0x2f9d]        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    105b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]

Disassembly of section .plt.sec:

0000000000001060 <__stack_chk_fail@plt>:
    1060:	f3 0f 1e fa          	endbr64 
    1064:	f2 ff 25 5d 2f 00 00 	bnd jmp QWORD PTR [rip+0x2f5d]        # 3fc8 <__stack_chk_fail@GLIBC_2.4>
    106b:	0f 1f 44 00 00       	nop    DWORD PTR [rax+rax*1+0x0]

Disassembly of section .text:

0000000000001070 <_start>:
    1070:	f3 0f 1e fa          	endbr64 
    1074:	31 ed                	xor    ebp,ebp
    1076:	49 89 d1             	mov    r9,rdx
    1079:	5e                   	pop    rsi
    107a:	48 89 e2             	mov    rdx,rsp
    107d:	48 83 e4 f0          	and    rsp,0xfffffffffffffff0
    1081:	50                   	push   rax
    1082:	54                   	push   rsp
    1083:	45 31 c0             	xor    r8d,r8d
    1086:	31 c9                	xor    ecx,ecx
    1088:	48 8d 3d 42 01 00 00 	lea    rdi,[rip+0x142]        # 11d1 <main>
    108f:	ff 15 3b 2f 00 00    	call   QWORD PTR [rip+0x2f3b]        # 3fd0 <__libc_start_main@GLIBC_2.34>
    1095:	f4                   	hlt    
    1096:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    109d:	00 00 00 

00000000000010a0 <deregister_tm_clones>:
    10a0:	48 8d 3d 69 2f 00 00 	lea    rdi,[rip+0x2f69]        # 4010 <__TMC_END__>
    10a7:	48 8d 05 62 2f 00 00 	lea    rax,[rip+0x2f62]        # 4010 <__TMC_END__>
    10ae:	48 39 f8             	cmp    rax,rdi
    10b1:	74 15                	je     10c8 <deregister_tm_clones+0x28>
    10b3:	48 8b 05 1e 2f 00 00 	mov    rax,QWORD PTR [rip+0x2f1e]        # 3fd8 <_ITM_deregisterTMCloneTable@Base>
    10ba:	48 85 c0             	test   rax,rax
    10bd:	74 09                	je     10c8 <deregister_tm_clones+0x28>
    10bf:	ff e0                	jmp    rax
    10c1:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    10c8:	c3                   	ret    
    10c9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

00000000000010d0 <register_tm_clones>:
    10d0:	48 8d 3d 39 2f 00 00 	lea    rdi,[rip+0x2f39]        # 4010 <__TMC_END__>
    10d7:	48 8d 35 32 2f 00 00 	lea    rsi,[rip+0x2f32]        # 4010 <__TMC_END__>
    10de:	48 29 fe             	sub    rsi,rdi
    10e1:	48 89 f0             	mov    rax,rsi
    10e4:	48 c1 ee 3f          	shr    rsi,0x3f
    10e8:	48 c1 f8 03          	sar    rax,0x3
    10ec:	48 01 c6             	add    rsi,rax
    10ef:	48 d1 fe             	sar    rsi,1
    10f2:	74 14                	je     1108 <register_tm_clones+0x38>
    10f4:	48 8b 05 f5 2e 00 00 	mov    rax,QWORD PTR [rip+0x2ef5]        # 3ff0 <_ITM_registerTMCloneTable@Base>
    10fb:	48 85 c0             	test   rax,rax
    10fe:	74 08                	je     1108 <register_tm_clones+0x38>
    1100:	ff e0                	jmp    rax
    1102:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1108:	c3                   	ret    
    1109:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

0000000000001110 <__do_global_dtors_aux>:
    1110:	f3 0f 1e fa          	endbr64 
    1114:	80 3d f5 2e 00 00 00 	cmp    BYTE PTR [rip+0x2ef5],0x0        # 4010 <__TMC_END__>
    111b:	75 2b                	jne    1148 <__do_global_dtors_aux+0x38>
    111d:	55                   	push   rbp
    111e:	48 83 3d d2 2e 00 00 	cmp    QWORD PTR [rip+0x2ed2],0x0        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    1125:	00 
    1126:	48 89 e5             	mov    rbp,rsp
    1129:	74 0c                	je     1137 <__do_global_dtors_aux+0x27>
    112b:	48 8b 3d d6 2e 00 00 	mov    rdi,QWORD PTR [rip+0x2ed6]        # 4008 <__dso_handle>
    1132:	e8 19 ff ff ff       	call   1050 <__cxa_finalize@plt>
    1137:	e8 64 ff ff ff       	call   10a0 <deregister_tm_clones>
    113c:	c6 05 cd 2e 00 00 01 	mov    BYTE PTR [rip+0x2ecd],0x1        # 4010 <__TMC_END__>
    1143:	5d                   	pop    rbp
    1144:	c3                   	ret    
    1145:	0f 1f 00             	nop    DWORD PTR [rax]
    1148:	c3                   	ret    
    1149:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

0000000000001150 <frame_dummy>:
    1150:	f3 0f 1e fa          	endbr64 
    1154:	e9 77 ff ff ff       	jmp    10d0 <register_tm_clones>

0000000000001159 <solver>:
    1159:	f3 0f 1e fa          	endbr64 
    115d:	55                   	push   rbp
    115e:	48 89 e5             	mov    rbp,rsp
    1161:	48 83 ec 20          	sub    rsp,0x20
    1165:	48 89 7d e8          	mov    QWORD PTR [rbp-0x18],rdi
    1169:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
    1170:	00 00 
    1172:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    1176:	31 c0                	xor    eax,eax
    1178:	48 c7 45 f0 00 00 00 	mov    QWORD PTR [rbp-0x10],0x0
    117f:	00 
    1180:	48 8d 45 f0          	lea    rax,[rbp-0x10]
    1184:	48 83 c0 18          	add    rax,0x18
    1188:	48 8b 08             	mov    rcx,QWORD PTR [rax]
    118b:	48 8d 45 f0          	lea    rax,[rbp-0x10]
    118f:	48 83 c0 10          	add    rax,0x10
    1193:	48 8b 10             	mov    rdx,QWORD PTR [rax]
    1196:	48 8d 45 f0          	lea    rax,[rbp-0x10]
    119a:	48 83 c0 08          	add    rax,0x8
    119e:	48 8b 00             	mov    rax,QWORD PTR [rax]
    11a1:	4c 8b 45 e8          	mov    r8,QWORD PTR [rbp-0x18]
    11a5:	48 89 c6             	mov    rsi,rax
    11a8:	48 8d 05 59 0e 00 00 	lea    rax,[rip+0xe59]        # 2008 <_IO_stdin_used+0x8>
    11af:	48 89 c7             	mov    rdi,rax
    11b2:	b8 00 00 00 00       	mov    eax,0x0
    11b7:	41 ff d0             	call   r8
    11ba:	90                   	nop
    11bb:	48 8b 45 f8          	mov    rax,QWORD PTR [rbp-0x8]
    11bf:	64 48 2b 04 25 28 00 	sub    rax,QWORD PTR fs:0x28
    11c6:	00 00 
    11c8:	74 05                	je     11cf <solver+0x76>
    11ca:	e8 91 fe ff ff       	call   1060 <__stack_chk_fail@plt>
    11cf:	c9                   	leave  
    11d0:	c3                   	ret    

00000000000011d1 <main>:
    11d1:	f3 0f 1e fa          	endbr64 
    11d5:	55                   	push   rbp
    11d6:	48 89 e5             	mov    rbp,rsp
    11d9:	48 83 ec 20          	sub    rsp,0x20
    11dd:	64 48 8b 04 25 28 00 	mov    rax,QWORD PTR fs:0x28
    11e4:	00 00 
    11e6:	48 89 45 f8          	mov    QWORD PTR [rbp-0x8],rax
    11ea:	31 c0                	xor    eax,eax
    11ec:	48 b8 2a 2a 20 6d 61 	movabs rax,0x206e69616d202a2a
    11f3:	69 6e 20 
    11f6:	48 ba 3d 20 25 70 0a 	movabs rdx,0xa7025203d
    11fd:	00 00 00 
    1200:	48 89 45 e0          	mov    QWORD PTR [rbp-0x20],rax
    1204:	48 89 55 e8          	mov    QWORD PTR [rbp-0x18],rdx
    1208:	48 8d 45 e0          	lea    rax,[rbp-0x20]
    120c:	48 8d 15 be ff ff ff 	lea    rdx,[rip+0xffffffffffffffbe]        # 11d1 <main>
    1213:	48 89 d6             	mov    rsi,rdx
    1216:	48 89 c7             	mov    rdi,rax
    1219:	b8 00 00 00 00       	mov    eax,0x0
    121e:	e8 1d fe ff ff       	call   1040 <printf@plt>
    1223:	48 8b 05 b6 2d 00 00 	mov    rax,QWORD PTR [rip+0x2db6]        # 3fe0 <printf@GLIBC_2.2.5>
    122a:	48 89 c7             	mov    rdi,rax
    122d:	e8 27 ff ff ff       	call   1159 <solver>
    1232:	b8 00 00 00 00       	mov    eax,0x0
    1237:	48 8b 55 f8          	mov    rdx,QWORD PTR [rbp-0x8]
    123b:	64 48 2b 14 25 28 00 	sub    rdx,QWORD PTR fs:0x28
    1242:	00 00 
    1244:	74 05                	je     124b <main+0x7a>
    1246:	e8 15 fe ff ff       	call   1060 <__stack_chk_fail@plt>
    124b:	c9                   	leave  
    124c:	c3                   	ret    

Disassembly of section .fini:

0000000000001250 <_fini>:
    1250:	f3 0f 1e fa          	endbr64 
    1254:	48 83 ec 08          	sub    rsp,0x8
    1258:	48 83 c4 08          	add    rsp,0x8
    125c:	c3                   	ret    

Disassembly of section .rodata:

0000000000002000 <_IO_stdin_used>:
    2000:	01 00                	add    DWORD PTR [rax],eax
    2002:	02 00                	add    al,BYTE PTR [rax]
    2004:	00 00                	add    BYTE PTR [rax],al
    2006:	00 00                	add    BYTE PTR [rax],al
    2008:	63 61 6e             	movsxd esp,DWORD PTR [rcx+0x6e]
    200b:	61                   	(bad)  
    200c:	72 79                	jb     2087 <__GNU_EH_FRAME_HDR+0x53>
    200e:	20 3d 20 25 30 31    	and    BYTE PTR [rip+0x31302520],bh        # 31304534 <_end+0x3130051c>
    2014:	36 6c                	ss ins BYTE PTR es:[rdi],dx
    2016:	78 0a                	js     2022 <_IO_stdin_used+0x22>
    2018:	72 62                	jb     207c <__GNU_EH_FRAME_HDR+0x48>
    201a:	70 20                	jo     203c <__GNU_EH_FRAME_HDR+0x8>
    201c:	3d 20 25 30 31       	cmp    eax,0x31302520
    2021:	36 6c                	ss ins BYTE PTR es:[rdi],dx
    2023:	78 0a                	js     202f <_IO_stdin_used+0x2f>
    2025:	72 61                	jb     2088 <__GNU_EH_FRAME_HDR+0x54>
    2027:	20 3d 20 25 30 31    	and    BYTE PTR [rip+0x31302520],bh        # 3130454d <_end+0x31300535>
    202d:	36 6c                	ss ins BYTE PTR es:[rdi],dx
    202f:	78 0a                	js     203b <__GNU_EH_FRAME_HDR+0x7>
	...

Disassembly of section .eh_frame_hdr:

0000000000002034 <__GNU_EH_FRAME_HDR>:
    2034:	01 1b                	add    DWORD PTR [rbx],ebx
    2036:	03 3b                	add    edi,DWORD PTR [rbx]
    2038:	38 00                	cmp    BYTE PTR [rax],al
    203a:	00 00                	add    BYTE PTR [rax],al
    203c:	06                   	(bad)  
    203d:	00 00                	add    BYTE PTR [rax],al
    203f:	00 ec                	add    ah,ch
    2041:	ef                   	out    dx,eax
    2042:	ff                   	(bad)  
    2043:	ff 6c 00 00          	jmp    FWORD PTR [rax+rax*1+0x0]
    2047:	00 0c f0             	add    BYTE PTR [rax+rsi*8],cl
    204a:	ff                   	(bad)  
    204b:	ff 94 00 00 00 2c f0 	call   QWORD PTR [rax+rax*1-0xfd40000]
    2052:	ff                   	(bad)  
    2053:	ff ac 00 00 00 3c f0 	jmp    FWORD PTR [rax+rax*1-0xfc40000]
    205a:	ff                   	(bad)  
    205b:	ff 54 00 00          	call   QWORD PTR [rax+rax*1+0x0]
    205f:	00 25 f1 ff ff c4    	add    BYTE PTR [rip+0xffffffffc4fffff1],ah        # ffffffffc5002056 <_end+0xffffffffc4ffe03e>
    2065:	00 00                	add    BYTE PTR [rax],al
    2067:	00 9d f1 ff ff e4    	add    BYTE PTR [rbp-0x1b00000f],bl
    206d:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .eh_frame:

0000000000002070 <__FRAME_END__-0xc8>:
    2070:	14 00                	adc    al,0x0
    2072:	00 00                	add    BYTE PTR [rax],al
    2074:	00 00                	add    BYTE PTR [rax],al
    2076:	00 00                	add    BYTE PTR [rax],al
    2078:	01 7a 52             	add    DWORD PTR [rdx+0x52],edi
    207b:	00 01                	add    BYTE PTR [rcx],al
    207d:	78 10                	js     208f <__GNU_EH_FRAME_HDR+0x5b>
    207f:	01 1b                	add    DWORD PTR [rbx],ebx
    2081:	0c 07                	or     al,0x7
    2083:	08 90 01 00 00 14    	or     BYTE PTR [rax+0x14000001],dl
    2089:	00 00                	add    BYTE PTR [rax],al
    208b:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
    208e:	00 00                	add    BYTE PTR [rax],al
    2090:	e0 ef                	loopne 2081 <__GNU_EH_FRAME_HDR+0x4d>
    2092:	ff                   	(bad)  
    2093:	ff 26                	jmp    QWORD PTR [rsi]
    2095:	00 00                	add    BYTE PTR [rax],al
    2097:	00 00                	add    BYTE PTR [rax],al
    2099:	44 07                	rex.R (bad) 
    209b:	10 00                	adc    BYTE PTR [rax],al
    209d:	00 00                	add    BYTE PTR [rax],al
    209f:	00 24 00             	add    BYTE PTR [rax+rax*1],ah
    20a2:	00 00                	add    BYTE PTR [rax],al
    20a4:	34 00                	xor    al,0x0
    20a6:	00 00                	add    BYTE PTR [rax],al
    20a8:	78 ef                	js     2099 <__GNU_EH_FRAME_HDR+0x65>
    20aa:	ff                   	(bad)  
    20ab:	ff 20                	jmp    QWORD PTR [rax]
    20ad:	00 00                	add    BYTE PTR [rax],al
    20af:	00 00                	add    BYTE PTR [rax],al
    20b1:	0e                   	(bad)  
    20b2:	10 46 0e             	adc    BYTE PTR [rsi+0xe],al
    20b5:	18 4a 0f             	sbb    BYTE PTR [rdx+0xf],cl
    20b8:	0b 77 08             	or     esi,DWORD PTR [rdi+0x8]
    20bb:	80 00 3f             	add    BYTE PTR [rax],0x3f
    20be:	1a 3a                	sbb    bh,BYTE PTR [rdx]
    20c0:	2a 33                	sub    dh,BYTE PTR [rbx]
    20c2:	24 22                	and    al,0x22
    20c4:	00 00                	add    BYTE PTR [rax],al
    20c6:	00 00                	add    BYTE PTR [rax],al
    20c8:	14 00                	adc    al,0x0
    20ca:	00 00                	add    BYTE PTR [rax],al
    20cc:	5c                   	pop    rsp
    20cd:	00 00                	add    BYTE PTR [rax],al
    20cf:	00 70 ef             	add    BYTE PTR [rax-0x11],dh
    20d2:	ff                   	(bad)  
    20d3:	ff 20                	jmp    QWORD PTR [rax]
	...
    20dd:	00 00                	add    BYTE PTR [rax],al
    20df:	00 14 00             	add    BYTE PTR [rax+rax*1],dl
    20e2:	00 00                	add    BYTE PTR [rax],al
    20e4:	74 00                	je     20e6 <__GNU_EH_FRAME_HDR+0xb2>
    20e6:	00 00                	add    BYTE PTR [rax],al
    20e8:	78 ef                	js     20d9 <__GNU_EH_FRAME_HDR+0xa5>
    20ea:	ff                   	(bad)  
    20eb:	ff 10                	call   QWORD PTR [rax]
	...
    20f5:	00 00                	add    BYTE PTR [rax],al
    20f7:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
    20fa:	00 00                	add    BYTE PTR [rax],al
    20fc:	8c 00                	mov    WORD PTR [rax],es
    20fe:	00 00                	add    BYTE PTR [rax],al
    2100:	59                   	pop    rcx
    2101:	f0 ff                	lock (bad) 
    2103:	ff                   	(bad)  
    2104:	78 00                	js     2106 <__GNU_EH_FRAME_HDR+0xd2>
    2106:	00 00                	add    BYTE PTR [rax],al
    2108:	00 45 0e             	add    BYTE PTR [rbp+0xe],al
    210b:	10 86 02 43 0d 06    	adc    BYTE PTR [rsi+0x60d4302],al
    2111:	02 6f 0c             	add    ch,BYTE PTR [rdi+0xc]
    2114:	07                   	(bad)  
    2115:	08 00                	or     BYTE PTR [rax],al
    2117:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
    211a:	00 00                	add    BYTE PTR [rax],al
    211c:	ac                   	lods   al,BYTE PTR ds:[rsi]
    211d:	00 00                	add    BYTE PTR [rax],al
    211f:	00 b1 f0 ff ff 7c    	add    BYTE PTR [rcx+0x7cfffff0],dh
    2125:	00 00                	add    BYTE PTR [rax],al
    2127:	00 00                	add    BYTE PTR [rax],al
    2129:	45 0e                	rex.RB (bad) 
    212b:	10 86 02 43 0d 06    	adc    BYTE PTR [rsi+0x60d4302],al
    2131:	02 73 0c             	add    dh,BYTE PTR [rbx+0xc]
    2134:	07                   	(bad)  
    2135:	08 00                	or     BYTE PTR [rax],al
	...

0000000000002138 <__FRAME_END__>:
    2138:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .init_array:

0000000000003db0 <__frame_dummy_init_array_entry>:
    3db0:	50                   	push   rax
    3db1:	11 00                	adc    DWORD PTR [rax],eax
    3db3:	00 00                	add    BYTE PTR [rax],al
    3db5:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .fini_array:

0000000000003db8 <__do_global_dtors_aux_fini_array_entry>:
    3db8:	10 11                	adc    BYTE PTR [rcx],dl
    3dba:	00 00                	add    BYTE PTR [rax],al
    3dbc:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .dynamic:

0000000000003dc0 <_DYNAMIC>:
    3dc0:	01 00                	add    DWORD PTR [rax],eax
    3dc2:	00 00                	add    BYTE PTR [rax],al
    3dc4:	00 00                	add    BYTE PTR [rax],al
    3dc6:	00 00                	add    BYTE PTR [rax],al
    3dc8:	3a 00                	cmp    al,BYTE PTR [rax]
    3dca:	00 00                	add    BYTE PTR [rax],al
    3dcc:	00 00                	add    BYTE PTR [rax],al
    3dce:	00 00                	add    BYTE PTR [rax],al
    3dd0:	0c 00                	or     al,0x0
    3dd2:	00 00                	add    BYTE PTR [rax],al
    3dd4:	00 00                	add    BYTE PTR [rax],al
    3dd6:	00 00                	add    BYTE PTR [rax],al
    3dd8:	00 10                	add    BYTE PTR [rax],dl
    3dda:	00 00                	add    BYTE PTR [rax],al
    3ddc:	00 00                	add    BYTE PTR [rax],al
    3dde:	00 00                	add    BYTE PTR [rax],al
    3de0:	0d 00 00 00 00       	or     eax,0x0
    3de5:	00 00                	add    BYTE PTR [rax],al
    3de7:	00 50 12             	add    BYTE PTR [rax+0x12],dl
    3dea:	00 00                	add    BYTE PTR [rax],al
    3dec:	00 00                	add    BYTE PTR [rax],al
    3dee:	00 00                	add    BYTE PTR [rax],al
    3df0:	19 00                	sbb    DWORD PTR [rax],eax
    3df2:	00 00                	add    BYTE PTR [rax],al
    3df4:	00 00                	add    BYTE PTR [rax],al
    3df6:	00 00                	add    BYTE PTR [rax],al
    3df8:	b0 3d                	mov    al,0x3d
    3dfa:	00 00                	add    BYTE PTR [rax],al
    3dfc:	00 00                	add    BYTE PTR [rax],al
    3dfe:	00 00                	add    BYTE PTR [rax],al
    3e00:	1b 00                	sbb    eax,DWORD PTR [rax]
    3e02:	00 00                	add    BYTE PTR [rax],al
    3e04:	00 00                	add    BYTE PTR [rax],al
    3e06:	00 00                	add    BYTE PTR [rax],al
    3e08:	08 00                	or     BYTE PTR [rax],al
    3e0a:	00 00                	add    BYTE PTR [rax],al
    3e0c:	00 00                	add    BYTE PTR [rax],al
    3e0e:	00 00                	add    BYTE PTR [rax],al
    3e10:	1a 00                	sbb    al,BYTE PTR [rax]
    3e12:	00 00                	add    BYTE PTR [rax],al
    3e14:	00 00                	add    BYTE PTR [rax],al
    3e16:	00 00                	add    BYTE PTR [rax],al
    3e18:	b8 3d 00 00 00       	mov    eax,0x3d
    3e1d:	00 00                	add    BYTE PTR [rax],al
    3e1f:	00 1c 00             	add    BYTE PTR [rax+rax*1],bl
    3e22:	00 00                	add    BYTE PTR [rax],al
    3e24:	00 00                	add    BYTE PTR [rax],al
    3e26:	00 00                	add    BYTE PTR [rax],al
    3e28:	08 00                	or     BYTE PTR [rax],al
    3e2a:	00 00                	add    BYTE PTR [rax],al
    3e2c:	00 00                	add    BYTE PTR [rax],al
    3e2e:	00 00                	add    BYTE PTR [rax],al
    3e30:	f5                   	cmc    
    3e31:	fe                   	(bad)  
    3e32:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3e35:	00 00                	add    BYTE PTR [rax],al
    3e37:	00 b0 03 00 00 00    	add    BYTE PTR [rax+0x3],dh
    3e3d:	00 00                	add    BYTE PTR [rax],al
    3e3f:	00 05 00 00 00 00    	add    BYTE PTR [rip+0x0],al        # 3e45 <_DYNAMIC+0x85>
    3e45:	00 00                	add    BYTE PTR [rax],al
    3e47:	00 98 04 00 00 00    	add    BYTE PTR [rax+0x4],bl
    3e4d:	00 00                	add    BYTE PTR [rax],al
    3e4f:	00 06                	add    BYTE PTR [rsi],al
    3e51:	00 00                	add    BYTE PTR [rax],al
    3e53:	00 00                	add    BYTE PTR [rax],al
    3e55:	00 00                	add    BYTE PTR [rax],al
    3e57:	00 d8                	add    al,bl
    3e59:	03 00                	add    eax,DWORD PTR [rax]
    3e5b:	00 00                	add    BYTE PTR [rax],al
    3e5d:	00 00                	add    BYTE PTR [rax],al
    3e5f:	00 0a                	add    BYTE PTR [rdx],cl
    3e61:	00 00                	add    BYTE PTR [rax],al
    3e63:	00 00                	add    BYTE PTR [rax],al
    3e65:	00 00                	add    BYTE PTR [rax],al
    3e67:	00 aa 00 00 00 00    	add    BYTE PTR [rdx+0x0],ch
    3e6d:	00 00                	add    BYTE PTR [rax],al
    3e6f:	00 0b                	add    BYTE PTR [rbx],cl
    3e71:	00 00                	add    BYTE PTR [rax],al
    3e73:	00 00                	add    BYTE PTR [rax],al
    3e75:	00 00                	add    BYTE PTR [rax],al
    3e77:	00 18                	add    BYTE PTR [rax],bl
    3e79:	00 00                	add    BYTE PTR [rax],al
    3e7b:	00 00                	add    BYTE PTR [rax],al
    3e7d:	00 00                	add    BYTE PTR [rax],al
    3e7f:	00 15 00 00 00 00    	add    BYTE PTR [rip+0x0],dl        # 3e85 <_DYNAMIC+0xc5>
	...
    3e8d:	00 00                	add    BYTE PTR [rax],al
    3e8f:	00 03                	add    BYTE PTR [rbx],al
    3e91:	00 00                	add    BYTE PTR [rax],al
    3e93:	00 00                	add    BYTE PTR [rax],al
    3e95:	00 00                	add    BYTE PTR [rax],al
    3e97:	00 b0 3f 00 00 00    	add    BYTE PTR [rax+0x3f],dh
    3e9d:	00 00                	add    BYTE PTR [rax],al
    3e9f:	00 02                	add    BYTE PTR [rdx],al
    3ea1:	00 00                	add    BYTE PTR [rax],al
    3ea3:	00 00                	add    BYTE PTR [rax],al
    3ea5:	00 00                	add    BYTE PTR [rax],al
    3ea7:	00 18                	add    BYTE PTR [rax],bl
    3ea9:	00 00                	add    BYTE PTR [rax],al
    3eab:	00 00                	add    BYTE PTR [rax],al
    3ead:	00 00                	add    BYTE PTR [rax],al
    3eaf:	00 14 00             	add    BYTE PTR [rax+rax*1],dl
    3eb2:	00 00                	add    BYTE PTR [rax],al
    3eb4:	00 00                	add    BYTE PTR [rax],al
    3eb6:	00 00                	add    BYTE PTR [rax],al
    3eb8:	07                   	(bad)  
    3eb9:	00 00                	add    BYTE PTR [rax],al
    3ebb:	00 00                	add    BYTE PTR [rax],al
    3ebd:	00 00                	add    BYTE PTR [rax],al
    3ebf:	00 17                	add    BYTE PTR [rdi],dl
    3ec1:	00 00                	add    BYTE PTR [rax],al
    3ec3:	00 00                	add    BYTE PTR [rax],al
    3ec5:	00 00                	add    BYTE PTR [rax],al
    3ec7:	00 70 06             	add    BYTE PTR [rax+0x6],dh
    3eca:	00 00                	add    BYTE PTR [rax],al
    3ecc:	00 00                	add    BYTE PTR [rax],al
    3ece:	00 00                	add    BYTE PTR [rax],al
    3ed0:	07                   	(bad)  
    3ed1:	00 00                	add    BYTE PTR [rax],al
    3ed3:	00 00                	add    BYTE PTR [rax],al
    3ed5:	00 00                	add    BYTE PTR [rax],al
    3ed7:	00 98 05 00 00 00    	add    BYTE PTR [rax+0x5],bl
    3edd:	00 00                	add    BYTE PTR [rax],al
    3edf:	00 08                	add    BYTE PTR [rax],cl
    3ee1:	00 00                	add    BYTE PTR [rax],al
    3ee3:	00 00                	add    BYTE PTR [rax],al
    3ee5:	00 00                	add    BYTE PTR [rax],al
    3ee7:	00 d8                	add    al,bl
    3ee9:	00 00                	add    BYTE PTR [rax],al
    3eeb:	00 00                	add    BYTE PTR [rax],al
    3eed:	00 00                	add    BYTE PTR [rax],al
    3eef:	00 09                	add    BYTE PTR [rcx],cl
    3ef1:	00 00                	add    BYTE PTR [rax],al
    3ef3:	00 00                	add    BYTE PTR [rax],al
    3ef5:	00 00                	add    BYTE PTR [rax],al
    3ef7:	00 18                	add    BYTE PTR [rax],bl
    3ef9:	00 00                	add    BYTE PTR [rax],al
    3efb:	00 00                	add    BYTE PTR [rax],al
    3efd:	00 00                	add    BYTE PTR [rax],al
    3eff:	00 1e                	add    BYTE PTR [rsi],bl
    3f01:	00 00                	add    BYTE PTR [rax],al
    3f03:	00 00                	add    BYTE PTR [rax],al
    3f05:	00 00                	add    BYTE PTR [rax],al
    3f07:	00 08                	add    BYTE PTR [rax],cl
    3f09:	00 00                	add    BYTE PTR [rax],al
    3f0b:	00 00                	add    BYTE PTR [rax],al
    3f0d:	00 00                	add    BYTE PTR [rax],al
    3f0f:	00 fb                	add    bl,bh
    3f11:	ff                   	(bad)  
    3f12:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3f15:	00 00                	add    BYTE PTR [rax],al
    3f17:	00 01                	add    BYTE PTR [rcx],al
    3f19:	00 00                	add    BYTE PTR [rax],al
    3f1b:	08 00                	or     BYTE PTR [rax],al
    3f1d:	00 00                	add    BYTE PTR [rax],al
    3f1f:	00 fe                	add    dh,bh
    3f21:	ff                   	(bad)  
    3f22:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3f25:	00 00                	add    BYTE PTR [rax],al
    3f27:	00 58 05             	add    BYTE PTR [rax+0x5],bl
    3f2a:	00 00                	add    BYTE PTR [rax],al
    3f2c:	00 00                	add    BYTE PTR [rax],al
    3f2e:	00 00                	add    BYTE PTR [rax],al
    3f30:	ff                   	(bad)  
    3f31:	ff                   	(bad)  
    3f32:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3f35:	00 00                	add    BYTE PTR [rax],al
    3f37:	00 01                	add    BYTE PTR [rcx],al
    3f39:	00 00                	add    BYTE PTR [rax],al
    3f3b:	00 00                	add    BYTE PTR [rax],al
    3f3d:	00 00                	add    BYTE PTR [rax],al
    3f3f:	00 f0                	add    al,dh
    3f41:	ff                   	(bad)  
    3f42:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3f45:	00 00                	add    BYTE PTR [rax],al
    3f47:	00 42 05             	add    BYTE PTR [rdx+0x5],al
    3f4a:	00 00                	add    BYTE PTR [rax],al
    3f4c:	00 00                	add    BYTE PTR [rax],al
    3f4e:	00 00                	add    BYTE PTR [rax],al
    3f50:	f9                   	stc    
    3f51:	ff                   	(bad)  
    3f52:	ff 6f 00             	jmp    FWORD PTR [rdi+0x0]
    3f55:	00 00                	add    BYTE PTR [rax],al
    3f57:	00 03                	add    BYTE PTR [rbx],al
	...

Disassembly of section .got:

0000000000003fb0 <_GLOBAL_OFFSET_TABLE_>:
    3fb0:	c0 3d 00 00 00 00 00 	sar    BYTE PTR [rip+0x0],0x0        # 3fb7 <_GLOBAL_OFFSET_TABLE_+0x7>
	...
    3fc7:	00 30                	add    BYTE PTR [rax],dh
    3fc9:	10 00                	adc    BYTE PTR [rax],al
	...

Disassembly of section .data:

0000000000004000 <__data_start>:
	...

0000000000004008 <__dso_handle>:
    4008:	08 40 00             	or     BYTE PTR [rax+0x0],al
    400b:	00 00                	add    BYTE PTR [rax],al
    400d:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .bss:

0000000000004010 <completed.0>:
	...

Disassembly of section .comment:

0000000000000000 <.comment>:
   0:	47                   	rex.RXB
   1:	43                   	rex.XB
   2:	43 3a 20             	rex.XB cmp spl,BYTE PTR [r8]
   5:	28 55 62             	sub    BYTE PTR [rbp+0x62],dl
   8:	75 6e                	jne    78 <__abi_tag-0x314>
   a:	74 75                	je     81 <__abi_tag-0x30b>
   c:	20 31                	and    BYTE PTR [rcx],dh
   e:	31 2e                	xor    DWORD PTR [rsi],ebp
  10:	33 2e                	xor    ebp,DWORD PTR [rsi]
  12:	30 2d 31 75 62 75    	xor    BYTE PTR [rip+0x75627531],ch        # 75627549 <_end+0x75623531>
  18:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  19:	74 75                	je     90 <__abi_tag-0x2fc>
  1b:	31 7e 32             	xor    DWORD PTR [rsi+0x32],edi
  1e:	32 2e                	xor    ch,BYTE PTR [rsi]
  20:	30 34 29             	xor    BYTE PTR [rcx+rbp*1],dh
  23:	20 31                	and    BYTE PTR [rcx],dh
  25:	31 2e                	xor    DWORD PTR [rsi],ebp
  27:	33 2e                	xor    ebp,DWORD PTR [rsi]
  29:	30 00                	xor    BYTE PTR [rax],al

Disassembly of section .debug_aranges:

0000000000000000 <.debug_aranges>:
   0:	2c 00                	sub    al,0x0
   2:	00 00                	add    BYTE PTR [rax],al
   4:	02 00                	add    al,BYTE PTR [rax]
   6:	00 00                	add    BYTE PTR [rax],al
   8:	00 00                	add    BYTE PTR [rax],al
   a:	08 00                	or     BYTE PTR [rax],al
   c:	00 00                	add    BYTE PTR [rax],al
   e:	00 00                	add    BYTE PTR [rax],al
  10:	59                   	pop    rcx
  11:	11 00                	adc    DWORD PTR [rax],eax
  13:	00 00                	add    BYTE PTR [rax],al
  15:	00 00                	add    BYTE PTR [rax],al
  17:	00 f4                	add    ah,dh
	...

Disassembly of section .debug_info:

0000000000000000 <.debug_info>:
   0:	3b 01                	cmp    eax,DWORD PTR [rcx]
   2:	00 00                	add    BYTE PTR [rax],al
   4:	05 00 01 08 00       	add    eax,0x80100
   9:	00 00                	add    BYTE PTR [rax],al
   b:	00 07                	add    BYTE PTR [rdi],al
   d:	20 00                	and    BYTE PTR [rax],al
   f:	00 00                	add    BYTE PTR [rax],al
  11:	1d 00 00 00 00       	sbb    eax,0x0
  16:	09 00                	or     DWORD PTR [rax],eax
  18:	00 00                	add    BYTE PTR [rax],al
  1a:	59                   	pop    rcx
  1b:	11 00                	adc    DWORD PTR [rax],eax
  1d:	00 00                	add    BYTE PTR [rax],al
  1f:	00 00                	add    BYTE PTR [rax],al
  21:	00 f4                	add    ah,dh
	...
  2b:	00 00                	add    BYTE PTR [rax],al
  2d:	00 01                	add    BYTE PTR [rcx],al
  2f:	08 07                	or     BYTE PTR [rdi],al
  31:	ae                   	scas   al,BYTE PTR es:[rdi]
  32:	00 00                	add    BYTE PTR [rax],al
  34:	00 01                	add    BYTE PTR [rcx],al
  36:	04 07                	add    al,0x7
  38:	b3 00                	mov    bl,0x0
  3a:	00 00                	add    BYTE PTR [rax],al
  3c:	01 01                	add    DWORD PTR [rcx],eax
  3e:	08 cb                	or     bl,cl
  40:	00 00                	add    BYTE PTR [rax],al
  42:	00 01                	add    BYTE PTR [rcx],al
  44:	02 07                	add    al,BYTE PTR [rdi]
  46:	00 00                	add    BYTE PTR [rax],al
  48:	00 00                	add    BYTE PTR [rax],al
  4a:	01 01                	add    DWORD PTR [rcx],eax
  4c:	06                   	(bad)  
  4d:	cd 00                	int    0x0
  4f:	00 00                	add    BYTE PTR [rax],al
  51:	01 02                	add    DWORD PTR [rdx],eax
  53:	05 fa 00 00 00       	add    eax,0xfa
  58:	08 04 05 69 6e 74 00 	or     BYTE PTR [rax*1+0x746e69],al
  5f:	01 08                	add    DWORD PTR [rax],ecx
  61:	05 e5 00 00 00       	add    eax,0xe5
  66:	03 c0                	add    eax,eax
  68:	00 00                	add    BYTE PTR [rax],al
  6a:	00 02                	add    BYTE PTR [rdx],al
  6c:	2d 1b 2e 00 00       	sub    eax,0x2e1b
  71:	00 01                	add    BYTE PTR [rcx],al
  73:	01 06                	add    DWORD PTR [rsi],eax
  75:	d4                   	(bad)  
  76:	00 00                	add    BYTE PTR [rax],al
  78:	00 09                	add    BYTE PTR [rcx],cl
  7a:	72 00                	jb     7c <__abi_tag-0x310>
  7c:	00 00                	add    BYTE PTR [rax],al
  7e:	03 13                	add    edx,DWORD PTR [rbx]
  80:	00 00                	add    BYTE PTR [rax],al
  82:	00 01                	add    BYTE PTR [rcx],al
  84:	03 0f                	add    ecx,DWORD PTR [rdi]
  86:	8a 00                	mov    al,BYTE PTR [rax]
  88:	00 00                	add    BYTE PTR [rax],al
  8a:	02 8f 00 00 00 0a    	add    cl,BYTE PTR [rdi+0xa000000]
  90:	58                   	pop    rax
  91:	00 00                	add    BYTE PTR [rax],al
  93:	00 9f 00 00 00 04    	add    BYTE PTR [rdi+0x4000000],bl
  99:	9f                   	lahf   
  9a:	00 00                	add    BYTE PTR [rax],al
  9c:	00 05 00 02 79 00    	add    BYTE PTR [rip+0x790200],al        # 7902a2 <_end+0x78c28a>
  a2:	00 00                	add    BYTE PTR [rax],al
  a4:	0b f3                	or     esi,ebx
  a6:	00 00                	add    BYTE PTR [rax],al
  a8:	00 03                	add    BYTE PTR [rbx],al
  aa:	64 01 0c 58          	add    DWORD PTR fs:[rax+rbx*2],ecx
  ae:	00 00                	add    BYTE PTR [rax],al
  b0:	00 bc 00 00 00 04 9f 	add    BYTE PTR [rax+rax*1-0x60fc0000],bh
  b7:	00 00                	add    BYTE PTR [rax],al
  b9:	00 05 00 0c d9 00    	add    BYTE PTR [rip+0xd90c00],al        # d90cbf <_end+0xd8cca7>
  bf:	00 00                	add    BYTE PTR [rax],al
  c1:	01 0a                	add    DWORD PTR [rdx],ecx
  c3:	05 58 00 00 00       	add    eax,0x58
  c8:	d1 11                	rcl    DWORD PTR [rcx],1
  ca:	00 00                	add    BYTE PTR [rax],al
  cc:	00 00                	add    BYTE PTR [rax],al
  ce:	00 00                	add    BYTE PTR [rax],al
  d0:	7c 00                	jl     d2 <__abi_tag-0x2ba>
  d2:	00 00                	add    BYTE PTR [rax],al
  d4:	00 00                	add    BYTE PTR [rax],al
  d6:	00 00                	add    BYTE PTR [rax],al
  d8:	01 9c ed 00 00 00 06 	add    DWORD PTR [rbp+rbp*8+0x6000000],ebx
  df:	66 6d                	ins    WORD PTR es:[rdi],dx
  e1:	74 00                	je     e3 <__abi_tag-0x2a9>
  e3:	0b 07                	or     eax,DWORD PTR [rdi]
  e5:	ed                   	in     eax,dx
  e6:	00 00                	add    BYTE PTR [rax],al
  e8:	00 02                	add    BYTE PTR [rdx],al
  ea:	91                   	xchg   ecx,eax
  eb:	50                   	push   rax
  ec:	00 0d 72 00 00 00    	add    BYTE PTR [rip+0x72],cl        # 164 <__abi_tag-0x228>
  f2:	fd                   	std    
  f3:	00 00                	add    BYTE PTR [rax],al
  f5:	00 0e                	add    BYTE PTR [rsi],cl
  f7:	2e 00 00             	cs add BYTE PTR [rax],al
  fa:	00 0f                	add    BYTE PTR [rdi],cl
  fc:	00 0f                	add    BYTE PTR [rdi],cl
  fe:	de 00                	fiadd  WORD PTR [rax]
 100:	00 00                	add    BYTE PTR [rax],al
 102:	01 05 06 59 11 00    	add    DWORD PTR [rip+0x115906],eax        # 115a0e <_end+0x1119f6>
 108:	00 00                	add    BYTE PTR [rax],al
 10a:	00 00                	add    BYTE PTR [rax],al
 10c:	00 78 00             	add    BYTE PTR [rax+0x0],bh
 10f:	00 00                	add    BYTE PTR [rax],al
 111:	00 00                	add    BYTE PTR [rax],al
 113:	00 00                	add    BYTE PTR [rax],al
 115:	01 9c 39 01 00 00 10 	add    DWORD PTR [rcx+rdi*1+0x10000001],ebx
 11c:	ee                   	out    dx,al
 11d:	00 00                	add    BYTE PTR [rax],al
 11f:	00 01                	add    BYTE PTR [rcx],al
 121:	05 1a 7e 00 00       	add    eax,0x7e1a
 126:	00 02                	add    BYTE PTR [rdx],al
 128:	91                   	xchg   ecx,eax
 129:	58                   	pop    rax
 12a:	06                   	(bad)  
 12b:	70 74                	jo     1a1 <__abi_tag-0x1eb>
 12d:	72 00                	jb     12f <__abi_tag-0x25d>
 12f:	06                   	(bad)  
 130:	11 39                	adc    DWORD PTR [rcx],edi
 132:	01 00                	add    DWORD PTR [rax],eax
 134:	00 02                	add    BYTE PTR [rdx],al
 136:	91                   	xchg   ecx,eax
 137:	60                   	(bad)  
 138:	00 02                	add    BYTE PTR [rdx],al
 13a:	2e 00 00             	cs add BYTE PTR [rax],al
	...

Disassembly of section .debug_abbrev:

0000000000000000 <.debug_abbrev>:
   0:	01 24 00             	add    DWORD PTR [rax+rax*1],esp
   3:	0b 0b                	or     ecx,DWORD PTR [rbx]
   5:	3e 0b 03             	ds or  eax,DWORD PTR [rbx]
   8:	0e                   	(bad)  
   9:	00 00                	add    BYTE PTR [rax],al
   b:	02 0f                	add    cl,BYTE PTR [rdi]
   d:	00 0b                	add    BYTE PTR [rbx],cl
   f:	21 08                	and    DWORD PTR [rax],ecx
  11:	49 13 00             	adc    rax,QWORD PTR [r8]
  14:	00 03                	add    BYTE PTR [rbx],al
  16:	16                   	(bad)  
  17:	00 03                	add    BYTE PTR [rbx],al
  19:	0e                   	(bad)  
  1a:	3a 0b                	cmp    cl,BYTE PTR [rbx]
  1c:	3b 0b                	cmp    ecx,DWORD PTR [rbx]
  1e:	39 0b                	cmp    DWORD PTR [rbx],ecx
  20:	49 13 00             	adc    rax,QWORD PTR [r8]
  23:	00 04 05 00 49 13 00 	add    BYTE PTR [rax*1+0x134900],al
  2a:	00 05 18 00 00 00    	add    BYTE PTR [rip+0x18],al        # 48 <__abi_tag-0x344>
  30:	06                   	(bad)  
  31:	34 00                	xor    al,0x0
  33:	03 08                	add    ecx,DWORD PTR [rax]
  35:	3a 21                	cmp    ah,BYTE PTR [rcx]
  37:	01 3b                	add    DWORD PTR [rbx],edi
  39:	0b 39                	or     edi,DWORD PTR [rcx]
  3b:	0b 49 13             	or     ecx,DWORD PTR [rcx+0x13]
  3e:	02 18                	add    bl,BYTE PTR [rax]
  40:	00 00                	add    BYTE PTR [rax],al
  42:	07                   	(bad)  
  43:	11 01                	adc    DWORD PTR [rcx],eax
  45:	25 0e 13 0b 03       	and    eax,0x30b130e
  4a:	1f                   	(bad)  
  4b:	1b 1f                	sbb    ebx,DWORD PTR [rdi]
  4d:	11 01                	adc    DWORD PTR [rcx],eax
  4f:	12 07                	adc    al,BYTE PTR [rdi]
  51:	10 17                	adc    BYTE PTR [rdi],dl
  53:	00 00                	add    BYTE PTR [rax],al
  55:	08 24 00             	or     BYTE PTR [rax+rax*1],ah
  58:	0b 0b                	or     ecx,DWORD PTR [rbx]
  5a:	3e 0b 03             	ds or  eax,DWORD PTR [rbx]
  5d:	08 00                	or     BYTE PTR [rax],al
  5f:	00 09                	add    BYTE PTR [rcx],cl
  61:	26 00 49 13          	es add BYTE PTR [rcx+0x13],cl
  65:	00 00                	add    BYTE PTR [rax],al
  67:	0a 15 01 27 19 49    	or     dl,BYTE PTR [rip+0x49192701]        # 4919276e <_end+0x4918e756>
  6d:	13 01                	adc    eax,DWORD PTR [rcx]
  6f:	13 00                	adc    eax,DWORD PTR [rax]
  71:	00 0b                	add    BYTE PTR [rbx],cl
  73:	2e 01 3f             	cs add DWORD PTR [rdi],edi
  76:	19 03                	sbb    DWORD PTR [rbx],eax
  78:	0e                   	(bad)  
  79:	3a 0b                	cmp    cl,BYTE PTR [rbx]
  7b:	3b 05 39 0b 27 19    	cmp    eax,DWORD PTR [rip+0x19270b39]        # 19270bba <_end+0x1926cba2>
  81:	49 13 3c 19          	adc    rdi,QWORD PTR [r9+rbx*1]
  85:	01 13                	add    DWORD PTR [rbx],edx
  87:	00 00                	add    BYTE PTR [rax],al
  89:	0c 2e                	or     al,0x2e
  8b:	01 3f                	add    DWORD PTR [rdi],edi
  8d:	19 03                	sbb    DWORD PTR [rbx],eax
  8f:	0e                   	(bad)  
  90:	3a 0b                	cmp    cl,BYTE PTR [rbx]
  92:	3b 0b                	cmp    ecx,DWORD PTR [rbx]
  94:	39 0b                	cmp    DWORD PTR [rbx],ecx
  96:	49 13 11             	adc    rdx,QWORD PTR [r9]
  99:	01 12                	add    DWORD PTR [rdx],edx
  9b:	07                   	(bad)  
  9c:	40 18 7c 19 01       	sbb    BYTE PTR [rcx+rbx*1+0x1],dil
  a1:	13 00                	adc    eax,DWORD PTR [rax]
  a3:	00 0d 01 01 49 13    	add    BYTE PTR [rip+0x13490101],cl        # 134901aa <_end+0x1348c192>
  a9:	01 13                	add    DWORD PTR [rbx],edx
  ab:	00 00                	add    BYTE PTR [rax],al
  ad:	0e                   	(bad)  
  ae:	21 00                	and    DWORD PTR [rax],eax
  b0:	49 13 2f             	adc    rbp,QWORD PTR [r15]
  b3:	0b 00                	or     eax,DWORD PTR [rax]
  b5:	00 0f                	add    BYTE PTR [rdi],cl
  b7:	2e 01 3f             	cs add DWORD PTR [rdi],edi
  ba:	19 03                	sbb    DWORD PTR [rbx],eax
  bc:	0e                   	(bad)  
  bd:	3a 0b                	cmp    cl,BYTE PTR [rbx]
  bf:	3b 0b                	cmp    ecx,DWORD PTR [rbx]
  c1:	39 0b                	cmp    DWORD PTR [rbx],ecx
  c3:	27                   	(bad)  
  c4:	19 11                	sbb    DWORD PTR [rcx],edx
  c6:	01 12                	add    DWORD PTR [rdx],edx
  c8:	07                   	(bad)  
  c9:	40 18 7c 19 01       	sbb    BYTE PTR [rcx+rbx*1+0x1],dil
  ce:	13 00                	adc    eax,DWORD PTR [rax]
  d0:	00 10                	add    BYTE PTR [rax],dl
  d2:	05 00 03 0e 3a       	add    eax,0x3a0e0300
  d7:	0b 3b                	or     edi,DWORD PTR [rbx]
  d9:	0b 39                	or     edi,DWORD PTR [rcx]
  db:	0b 49 13             	or     ecx,DWORD PTR [rcx+0x13]
  de:	02 18                	add    bl,BYTE PTR [rax]
  e0:	00 00                	add    BYTE PTR [rax],al
	...

Disassembly of section .debug_line:

0000000000000000 <.debug_line>:
   0:	86 00                	xchg   BYTE PTR [rax],al
   2:	00 00                	add    BYTE PTR [rax],al
   4:	05 00 08 00 3c       	add    eax,0x3c000800
   9:	00 00                	add    BYTE PTR [rax],al
   b:	00 01                	add    BYTE PTR [rcx],al
   d:	01 01                	add    DWORD PTR [rcx],eax
   f:	fb                   	sti    
  10:	0e                   	(bad)  
  11:	0d 00 01 01 01       	or     eax,0x1010100
  16:	01 00                	add    DWORD PTR [rax],eax
  18:	00 00                	add    BYTE PTR [rax],al
  1a:	01 00                	add    DWORD PTR [rax],eax
  1c:	00 01                	add    BYTE PTR [rcx],al
  1e:	01 01                	add    DWORD PTR [rcx],eax
  20:	1f                   	(bad)  
  21:	03 09                	add    ecx,DWORD PTR [rcx]
  23:	00 00                	add    BYTE PTR [rax],al
  25:	00 21                	add    BYTE PTR [rcx],ah
  27:	00 00                	add    BYTE PTR [rax],al
  29:	00 44 00 00          	add    BYTE PTR [rax+rax*1+0x0],al
  2d:	00 02                	add    BYTE PTR [rdx],al
  2f:	01 1f                	add    DWORD PTR [rdi],ebx
  31:	02 0f                	add    cl,BYTE PTR [rdi]
  33:	04 00                	add    al,0x0
	...
  3d:	00 51 00             	add    BYTE PTR [rcx+0x0],dl
  40:	00 00                	add    BYTE PTR [rax],al
  42:	01 59 00             	add    DWORD PTR [rcx+0x0],ebx
  45:	00 00                	add    BYTE PTR [rax],al
  47:	02 05 20 00 09 02    	add    al,BYTE PTR [rip+0x2090020]        # 209006d <_end+0x208c055>
  4d:	59                   	pop    rcx
  4e:	11 00                	adc    DWORD PTR [rax],eax
  50:	00 00                	add    BYTE PTR [rax],al
  52:	00 00                	add    BYTE PTR [rax],al
  54:	00 16                	add    BYTE PTR [rsi],dl
  56:	f2 05 11 e5 05 85    	repnz add eax,0x8505e511
  5c:	01 83 05 02 82 05    	add    DWORD PTR [rbx+0x5820205],eax
  62:	5e                   	pop    rsi
  63:	3c 05                	cmp    al,0x5
  65:	02 82 05 38 3c 05    	add    al,BYTE PTR [rdx+0x53c3805]
  6b:	02 82 05 01 08 ad    	add    al,BYTE PTR [rdx-0x52f7fefb]
  71:	05 0c 08 68 ba       	add    eax,0xba68080c
  76:	05 07 e5 05 02       	add    eax,0x205e507
  7b:	08 ad 08 9f 05 09    	or     BYTE PTR [rbp+0x9059f08],ch
  81:	e5 05                	in     eax,0x5
  83:	01 59 02             	add    DWORD PTR [rcx+0x2],ebx
  86:	16                   	(bad)  
  87:	00 01                	add    BYTE PTR [rcx],al
  89:	01                   	.byte 0x1

Disassembly of section .debug_str:

0000000000000000 <.debug_str>:
   0:	73 68                	jae    6a <__abi_tag-0x322>
   2:	6f                   	outs   dx,DWORD PTR ds:[rsi]
   3:	72 74                	jb     79 <__abi_tag-0x313>
   5:	20 75 6e             	and    BYTE PTR [rbp+0x6e],dh
   8:	73 69                	jae    73 <__abi_tag-0x319>
   a:	67 6e                	outs   dx,BYTE PTR ds:[esi]
   c:	65 64 20 69 6e       	gs and BYTE PTR fs:[rcx+0x6e],ch
  11:	74 00                	je     13 <__abi_tag-0x379>
  13:	70 72                	jo     87 <__abi_tag-0x305>
  15:	69 6e 74 66 5f 70 74 	imul   ebp,DWORD PTR [rsi+0x74],0x74705f66
  1c:	72 5f                	jb     7d <__abi_tag-0x30f>
  1e:	74 00                	je     20 <__abi_tag-0x36c>
  20:	47                   	rex.RXB
  21:	4e 55                	rex.WRX push rbp
  23:	20 43 31             	and    BYTE PTR [rbx+0x31],al
  26:	37                   	(bad)  
  27:	20 31                	and    BYTE PTR [rcx],dh
  29:	31 2e                	xor    DWORD PTR [rsi],ebp
  2b:	33 2e                	xor    ebp,DWORD PTR [rsi]
  2d:	30 20                	xor    BYTE PTR [rax],ah
  2f:	2d 6d 74 75 6e       	sub    eax,0x6e75746d
  34:	65 3d 67 65 6e 65    	gs cmp eax,0x656e6567
  3a:	72 69                	jb     a5 <__abi_tag-0x2e7>
  3c:	63 20                	movsxd esp,DWORD PTR [rax]
  3e:	2d 6d 61 72 63       	sub    eax,0x6372616d
  43:	68 3d 78 38 36       	push   0x3638783d
  48:	2d 36 34 20 2d       	sub    eax,0x2d203436
  4d:	67 20 2d 66 61 73 79 	and    BYTE PTR [eip+0x79736166],ch        # 797361ba <_end+0x797321a2>
  54:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  55:	63 68 72             	movsxd ebp,DWORD PTR [rax+0x72]
  58:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  59:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  5a:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  5b:	75 73                	jne    d0 <__abi_tag-0x2bc>
  5d:	2d 75 6e 77 69       	sub    eax,0x69776e75
  62:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  63:	64 2d 74 61 62 6c    	fs sub eax,0x6c626174
  69:	65 73 20             	gs jae 8c <__abi_tag-0x300>
  6c:	2d 66 73 74 61       	sub    eax,0x61747366
  71:	63 6b 2d             	movsxd ebp,DWORD PTR [rbx+0x2d]
  74:	70 72                	jo     e8 <__abi_tag-0x2a4>
  76:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  77:	74 65                	je     de <__abi_tag-0x2ae>
  79:	63 74 6f 72          	movsxd esi,DWORD PTR [rdi+rbp*2+0x72]
  7d:	2d 73 74 72 6f       	sub    eax,0x6f727473
  82:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  83:	67 20 2d 66 73 74 61 	and    BYTE PTR [eip+0x61747366],ch        # 617473f0 <_end+0x617433d8>
  8a:	63 6b 2d             	movsxd ebp,DWORD PTR [rbx+0x2d]
  8d:	63 6c 61 73          	movsxd ebp,DWORD PTR [rcx+riz*2+0x73]
  91:	68 2d 70 72 6f       	push   0x6f72702d
  96:	74 65                	je     fd <__abi_tag-0x28f>
  98:	63 74 69 6f          	movsxd esi,DWORD PTR [rcx+rbp*2+0x6f]
  9c:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  9d:	20 2d 66 63 66 2d    	and    BYTE PTR [rip+0x2d666366],ch        # 2d666409 <_end+0x2d6623f1>
  a3:	70 72                	jo     117 <__abi_tag-0x275>
  a5:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  a6:	74 65                	je     10d <__abi_tag-0x27f>
  a8:	63 74 69 6f          	movsxd esi,DWORD PTR [rcx+rbp*2+0x6f]
  ac:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  ad:	00 6c 6f 6e          	add    BYTE PTR [rdi+rbp*2+0x6e],ch
  b1:	67 20 75 6e          	and    BYTE PTR [ebp+0x6e],dh
  b5:	73 69                	jae    120 <__abi_tag-0x26c>
  b7:	67 6e                	outs   dx,BYTE PTR ds:[esi]
  b9:	65 64 20 69 6e       	gs and BYTE PTR fs:[rcx+0x6e],ch
  be:	74 00                	je     c0 <__abi_tag-0x2cc>
  c0:	5f                   	pop    rdi
  c1:	5f                   	pop    rdi
  c2:	75 69                	jne    12d <__abi_tag-0x25f>
  c4:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  c5:	74 36                	je     fd <__abi_tag-0x28f>
  c7:	34 5f                	xor    al,0x5f
  c9:	74 00                	je     cb <__abi_tag-0x2c1>
  cb:	75 6e                	jne    13b <__abi_tag-0x251>
  cd:	73 69                	jae    138 <__abi_tag-0x254>
  cf:	67 6e                	outs   dx,BYTE PTR ds:[esi]
  d1:	65 64 20 63 68       	gs and BYTE PTR fs:[rbx+0x68],ah
  d6:	61                   	(bad)  
  d7:	72 00                	jb     d9 <__abi_tag-0x2b3>
  d9:	6d                   	ins    DWORD PTR es:[rdi],dx
  da:	61                   	(bad)  
  db:	69 6e 00 73 6f 6c 76 	imul   ebp,DWORD PTR [rsi+0x0],0x766c6f73
  e2:	65 72 00             	gs jb  e5 <__abi_tag-0x2a7>
  e5:	6c                   	ins    BYTE PTR es:[rdi],dx
  e6:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  e7:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  e8:	67 20 69 6e          	and    BYTE PTR [ecx+0x6e],ch
  ec:	74 00                	je     ee <__abi_tag-0x29e>
  ee:	66 70 74             	data16 jo 165 <__abi_tag-0x227>
  f1:	72 00                	jb     f3 <__abi_tag-0x299>
  f3:	70 72                	jo     167 <__abi_tag-0x225>
  f5:	69 6e 74 66 00 73 68 	imul   ebp,DWORD PTR [rsi+0x74],0x68730066
  fc:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  fd:	72 74                	jb     173 <__abi_tag-0x219>
  ff:	20 69 6e             	and    BYTE PTR [rcx+0x6e],ch
 102:	74 00                	je     104 <__abi_tag-0x288>

Disassembly of section .debug_line_str:

0000000000000000 <.debug_line_str>:
   0:	73 6f                	jae    71 <__abi_tag-0x31b>
   2:	6c                   	ins    BYTE PTR es:[rdi],dx
   3:	76 65                	jbe    6a <__abi_tag-0x322>
   5:	72 2e                	jb     35 <__abi_tag-0x357>
   7:	63 00                	movsxd eax,DWORD PTR [rax]
   9:	2f                   	(bad)  
   a:	68 6f 6d 65 2f       	push   0x2f656d6f
   f:	61                   	(bad)  
  10:	6e                   	outs   dx,BYTE PTR ds:[rsi]
  11:	67 65 72 2f          	addr32 gs jb 44 <__abi_tag-0x348>
  15:	75 70                	jne    87 <__abi_tag-0x305>
  17:	2f                   	(bad)  
  18:	6c                   	ins    BYTE PTR es:[rdi],dx
  19:	61                   	(bad)  
  1a:	62                   	(bad)  
  1b:	2f                   	(bad)  
  1c:	6c                   	ins    BYTE PTR es:[rdi],dx
  1d:	61                   	(bad)  
  1e:	62                   	(bad)  
  1f:	34 00                	xor    al,0x0
  21:	2f                   	(bad)  
  22:	75 73                	jne    97 <__abi_tag-0x2f5>
  24:	72 2f                	jb     55 <__abi_tag-0x337>
  26:	69 6e 63 6c 75 64 65 	imul   ebp,DWORD PTR [rsi+0x63],0x6564756c
  2d:	2f                   	(bad)  
  2e:	78 38                	js     68 <__abi_tag-0x324>
  30:	36 5f                	ss pop rdi
  32:	36 34 2d             	ss xor al,0x2d
  35:	6c                   	ins    BYTE PTR es:[rdi],dx
  36:	69 6e 75 78 2d 67 6e 	imul   ebp,DWORD PTR [rsi+0x75],0x6e672d78
  3d:	75 2f                	jne    6e <__abi_tag-0x31e>
  3f:	62                   	(bad)  
  40:	69 74 73 00 2f 75 73 	imul   esi,DWORD PTR [rbx+rsi*2+0x0],0x7273752f
  47:	72 
  48:	2f                   	(bad)  
  49:	69 6e 63 6c 75 64 65 	imul   ebp,DWORD PTR [rsi+0x63],0x6564756c
  50:	00 74 79 70          	add    BYTE PTR [rcx+rdi*2+0x70],dh
  54:	65 73 2e             	gs jae 85 <__abi_tag-0x307>
  57:	68 00 73 74 64       	push   0x64747300
  5c:	69                   	.byte 0x69
  5d:	6f                   	outs   dx,DWORD PTR ds:[rsi]
  5e:	2e                   	cs
  5f:	68                   	.byte 0x68
	...
