Dump of assembler code for function phase_5:
   0x00000000004011c4 <+0>:	push   rbx
   0x00000000004011c5 <+1>:	sub    rsp,0x10 # create 16 bytes on stack
   0x00000000004011c9 <+5>:	mov    rbx,rdi 
   0x00000000004011cc <+8>:	mov    rax,QWORD PTR fs:0x28
   0x00000000004011d5 <+17>:	mov    QWORD PTR [rsp+0x8],rax # stack canary
   0x00000000004011da <+22>:	xor    eax,eax # zero out eax
   0x00000000004011dc <+24>:	call   0x401455 <string_length> # call some string length function
   0x00000000004011e1 <+29>:	cmp    eax,0x6 # string length must = 6
   0x00000000004011e4 <+32>:	je     0x4011eb <phase_5+39> # if str.len = 6 then jump to +39
   0x00000000004011e6 <+34>:	call   0x401742 <explode_bomb> # otherwise blow up bomb
   0x00000000004011eb <+39>:	mov    $0x0,%eax # move zero into eax
   # loop
   0x00000000004011f0 <+44>:	movzbl (%rbx,%rax,1),%edx # load charecter from input string
   0x00000000004011f4 <+48>:	and    $0xf,%edx # bitwise and, get last 4 bits
   0x00000000004011f7 <+51>:	movzbl 0x4027a0(%rdx),%edx # use result as index in table at 0x4027a0
   0x00000000004011fe <+58>:	mov    %dl,(%rsp,%rax,1) # store lookup char on stack
   0x0000000000401201 <+61>:	add    $0x1,%rax # increment loop counter
   0x0000000000401205 <+65>:	cmp    $0x6,%rax # check if we have done all 6 chars
   0x0000000000401209 <+69>:	jne    0x4011f0 <phase_5+44> # if not then jump to top of loop
   0x000000000040120b <+71>:	movb   $0x0,0x6(%rsp) # null terminate string?
   0x0000000000401210 <+76>:	mov    $0x402757,%esi # load addr of target string
   0x0000000000401215 <+81>:	mov    %rsp,%rdi # load addr of constructed string
   0x0000000000401218 <+84>:	call   0x401473 <strings_not_equal> # comapre string
   0x000000000040121d <+89>:	test   %eax,%eax # check func results
   0x000000000040121f <+91>:	je     0x401226 <phase_5+98> # skip explosion if strs are =
   0x0000000000401221 <+93>:	call   0x401742 <explode_bomb> # blow up
   # clean up stack
   0x0000000000401226 <+98>:	mov    0x8(%rsp),%rax 
   0x000000000040122b <+103>:	xor    %fs:0x28,%rax
   0x0000000000401234 <+112>:	je     0x40123b <phase_5+119>
   0x0000000000401236 <+114>:	call   0x400b90 <__stack_chk_fail@plt>
   0x000000000040123b <+119>:	add    $0x10,%rsp
   0x000000000040123f <+123>:	pop    %rbx
   0x0000000000401240 <+124>:	ret