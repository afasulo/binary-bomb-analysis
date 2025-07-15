Dump of assembler code for function phase_4:
   0x0000000000401151 <+0>:	sub    $0x18,%rsp # setup 24 bytes of space on stack
   0x0000000000401155 <+4>:	mov    %fs:0x28,%rax # stack canary
   0x000000000040115e <+13>:	mov    %rax,0x8(%rsp) # store canary on stack
   0x0000000000401163 <+18>:	xor    %eax,%eax # clear eax 
   0x0000000000401165 <+20>:	lea    0x4(%rsp),%rcx # sets rcx to addr of second input
   0x000000000040116a <+25>:	mov    %rsp,%rdx # sets rdx to first addr of 1st input
   0x000000000040116d <+28>:	mov    $0x4029fd,%esi # format string for sscanf
   0x0000000000401172 <+33>:	call   0x400c40 <__isoc99_sscanf@plt>
   0x0000000000401177 <+38>:	cmp    $0x2,%eax # checks if 2 values were read
   0x000000000040117a <+41>:	jne    0x401182 <phase_4+49> # explode bomb if input != 2
   0x000000000040117c <+43>:	cmpl   $0xe,(%rsp) # compare if first num <= 14
   0x0000000000401180 <+47>:	jbe    0x401187 <phase_4+54> # skip explode if first num <= 14
   0x0000000000401182 <+49>:	call   0x401742 <explode_bomb>
   0x0000000000401187 <+54>:	mov    $0xe,%edx # sets third param to 14
   0x000000000040118c <+59>:	mov    $0x0,%esi # sets second param to 0
   0x0000000000401191 <+64>:	mov    (%rsp),%edi # set first param to first input
   0x0000000000401194 <+67>:	call   0x40111e <func4> # call func4(1,0,4)
   0x0000000000401199 <+72>:	cmp    $0x1b,%eax # check if func4 returns 27
   0x000000000040119c <+75>:	jne    0x4011a5 <phase_4+84> # explode if func4 doesnt return 27
   0x000000000040119e <+77>:	cmpl   $0x1b,0x4(%rsp) # check is 2nd input is 27
   0x00000000004011a3 <+82>:	je     0x4011aa <phase_4+89> # skip explode if second input is 27
   0x00000000004011a5 <+84>:	call   0x401742 <explode_bomb> # explode bomb
   # clean up stack
   0x00000000004011aa <+89>:	mov    0x8(%rsp),%rax
   0x00000000004011af <+94>:	xor    %fs:0x28,%rax
   0x00000000004011b8 <+103>:	je     0x4011bf <phase_4+110>
   0x00000000004011ba <+105>:	call   0x400b90 <__stack_chk_fail@plt>
   0x00000000004011bf <+110>:	add    $0x18,%rsp
   0x00000000004011c3 <+114>:	ret

   Dump of assembler code for function func4:
   0x000000000040111e <+0>:	push   %rbx # save rbx reg
   0x000000000040111f <+1>:	mov    %edx,%eax # eax = edx (third param, 14)
   0x0000000000401121 <+3>:	sub    %esi,%eax # eax = edx - edi (14-0) = 14
   0x0000000000401123 <+5>:	mov    %eax,%ebx # ebx = eax (14)
   0x0000000000401125 <+7>:	shr    $0x1f,%ebx # shift ebx right by 31 9extract sign bit)
   0x0000000000401128 <+10>:	add    %ebx,%eax # eax = eax + ebx (14 + 1)
   0x000000000040112a <+12>:	sar    %eax # arithmetic shift right \2
   0x000000000040112c <+14>:	lea    (%rax,%rsi,1),%ebx # ebx = rax + rsi (mid + low)
   0x000000000040112f <+17>:	cmp    %edi,%ebx # compare input (edi) with ebx
   0x0000000000401131 <+19>:	jle    0x40113f <func4+33> # if ebx <= input, jump to +33
   0x0000000000401133 <+21>:	lea    -0x1(%rbx),%edx # edx = rbx -1 (new high)
   0x0000000000401136 <+24>:	call   0x40111e <func4> # recursion. gross. func4(inpt, low, mid-1)
   0x000000000040113b <+29>:	add    %ebx,%eax # eax = eax + ebx
   0x000000000040113d <+31>:	jmp    0x40114f <func4+49> # jmp to return
   0x000000000040113f <+33>:	mov    %ebx,%eax # eax = ebx ( mid value)
   0x0000000000401141 <+35>:	cmp    %edi,%ebx # cmp input with ebx
   0x0000000000401143 <+37>:	jge    0x40114f <func4+49> # if ebx >= input, jmp -> return
   0x0000000000401145 <+39>:	lea    0x1(%rbx),%esi # esi = rbx + 1 (new low)
   0x0000000000401148 <+42>:	call   0x40111e <func4> # func4 (input, mid+1, high)
   0x000000000040114d <+47>:	add    %ebx,%eax # eax = eax + ebx (return + mid)
   0x000000000040114f <+49>:	pop    %rbx # restore rbx
   0x0000000000401150 <+50>:	ret # return