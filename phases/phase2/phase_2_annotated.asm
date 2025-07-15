Dump of assembler code for function phase_2:
   0x0000000000400f49 <+0>:	push   %rbp
   0x0000000000400f4a <+1>:	push   %rbx # will be used as a counter
   0x0000000000400f4b <+2>:	sub    $0x28,%rsp # setup 40 bytes on the stack
   0x0000000000400f4f <+6>:	mov    %fs:0x28,%rax # stack canary
   0x0000000000400f58 <+15>:	mov    %rax,0x18(%rsp)
   0x0000000000400f5d <+20>:	xor    %eax,%eax # 0 out eax
   0x0000000000400f5f <+22>:	mov    %rsp,%rsi # move top of stack into rsi so read_six_numbers knows where to store data
   0x0000000000400f62 <+25>:	call   0x401778 <read_six_numbers> # rsi is passed as second argument to function call. rsi = rsp
   0x0000000000400f67 <+30>:	cmpl   $0x0,(%rsp)  # compare first argument with 0
   0x0000000000400f6b <+34>:	jns    0x400f72 <phase_2+41>    # jump if not signed SF = 0
   0x0000000000400f6d <+36>:	call   0x401742 <explode_bomb> # first number was < 0
   0x0000000000400f72 <+41>:	mov    %rsp,%rbp    # rsp is the same address as rsi which contains the string of 6 numbers
   0x0000000000400f75 <+44>:	mov    $0x1,%ebx    # set ebx to 1 prolly to set up a loop?
   0x0000000000400f7a <+49>:	mov    %ebx,%eax    # move 1 to eax. eax = 2
   0x0000000000400f7c <+51>:	add    0x0(%rbp),%eax # rbp = second element + 2
   0x0000000000400f7f <+54>:	cmp    %eax,0x4(%rbp) # compare sum with next array element
   0x0000000000400f82 <+57>:	je     0x400f89 <phase_2+64> # if element i and i + 1 are = jump and increment loop
   0x0000000000400f84 <+59>:	call   0x401742 <explode_bomb>
   0x0000000000400f89 <+64>:	add    $0x1,%ebx # increment counter i 
   0x0000000000400f8c <+67>:	add    $0x4,%rbp # move base pointer to next elemenet in array
   0x0000000000400f90 <+71>:	cmp    $0x6,%ebx # if ebx = 6 then end loop
   0x0000000000400f93 <+74>:	jne    0x400f7a <phase_2+49> # go back to top of loop if ebx != 6
   0x0000000000400f95 <+76>:	mov    0x18(%rsp),%rax # stack canary stuff
   0x0000000000400f9a <+81>:	xor    %fs:0x28,%rax # comapre with orignal canary
   0x0000000000400fa3 <+90>:	je     0x400faa <phase_2+97> # if canaries are unchanged continue and clean up stack
   0x0000000000400fa5 <+92>:	call   0x400b90 <__stack_chk_fail@plt>
   0x0000000000400faa <+97>:	add    $0x28,%rsp # clean up stack
   0x0000000000400fae <+101>:	pop    %rbx
   0x0000000000400faf <+102>:	pop    %rbp
   0x0000000000400fb0 <+103>:	ret
End of assembler dump.
>>> disas read_six_numbers
Dump of assembler code for function read_six_numbers:
   0x0000000000401778 <+0>:	sub    $0x8,%rsp    # setup stack for 8 bytes
   0x000000000040177c <+4>:	mov    %rsi,%rdx    # rsi is the starting address of where are digits are loaded into
   0x000000000040177f <+7>:	lea    0x4(%rsi),%rcx   # loads 2 digit into rcx
   0x0000000000401783 <+11>:	lea    0x14(%rsi),%rax  # loads 6th digit into rax and then pushes it onto the stack
   0x0000000000401787 <+15>:	push   %rax     # push rax onto stack (6th digit)
=> 0x0000000000401788 <+16>:	lea    0x10(%rsi),%rax  # push 5th digit onto the stack
   0x000000000040178c <+20>:	push   %rax
   0x000000000040178d <+21>:	lea    0xc(%rsi),%r9    # load 4th digit into r9
   0x0000000000401791 <+25>:	lea    0x8(%rsi),%r8    # load 3rd digit into r8
   0x0000000000401795 <+29>:	mov    $0x4029f1,%esi   # format string for scanf: "%d %d %d %d %d %d %d"
   0x000000000040179a <+34>:	mov    $0x0,%eax            # Zero out eax 
   0x000000000040179f <+39>:	call   0x400c40 <__isoc99_sscanf@plt> # Call scanf to read the numbers
   0x00000000004017a4 <+44>:	add    $0x10,%rsp           # Clean up stack (remove the two pushed addresses)
   0x00000000004017a8 <+48>:	cmp    $0x5,%eax            # Check if scanf read at least 6 numbers (returns count)
   0x00000000004017ab <+51>:	jg     0x4017b2 <read_six_numbers+58> # If more than 5 nums read, continue
   0x00000000004017ad <+53>:	call   0x401742 <explode_bomb> # Explode if fewer than 6 numbers were read
   0x00000000004017b2 <+58>:	add    $0x8,%rsp            # Clean up remaining stack allocation
   0x00000000004017b6 <+62>:	ret                         # Return from function