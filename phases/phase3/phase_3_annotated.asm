Dump of assembler code for function phase_3:
=> 0x0000000000400fb1 <+0>:	sub    $0x28,%rsp # setup stack with 40 bytes
   0x0000000000400fb5 <+4>:	mov    %fs:0x28,%rax # 
   0x0000000000400fbe <+13>:	mov    %rax,0x18(%rsp) # 
   0x0000000000400fc3 <+18>:	xor    %eax,%eax # zero out eax = 0000....
   0x0000000000400fc5 <+20>:	lea    0x14(%rsp),%r8 # sets up some pointers on the stack into registers?
   0x0000000000400fca <+25>:	lea    0xf(%rsp),%rcx # probably for some string inputs, each 5 bytes apart?
   0x0000000000400fcf <+30>:	lea    0x10(%rsp),%rdx
   0x0000000000400fd4 <+35>:	mov    $0x40274e,%esi # probably a format string for sscanf
   0x0000000000400fd9 <+40>:	call   0x400c40 <__isoc99_sscanf@plt> # read input
   0x0000000000400fde <+45>:	cmp    $0x2,%eax # if eax < 2 ZF and SF are set
   0x0000000000400fe1 <+48>:	jg     0x400fe8 <phase_3+55> # if ZF and SF = 0 then jump
   0x0000000000400fe3 <+50>:	call   0x401742 <explode_bomb>
   0x0000000000400fe8 <+55>:	cmpl   $0x7,0x10(%rsp) # compare if first digit is > 7
   0x0000000000400fed <+60>:	ja     0x4010ef <phase_3+318> # if first digit is > 7 explode bomb
   0x0000000000400ff3 <+66>:	mov    0x10(%rsp),%eax # move first digit into eax. eax = first digit
   0x0000000000400ff7 <+70>:	jmp    *0x402760(,%rax,8) # 8 * first digit and jump to that address + 8 times 1st digit
   # Case 0 handler (jump table entry: 0x0000000000400ffe)
   0x0000000000400ffe <+77>:	mov    $0x6d,%eax # move 109 'd' into eax
   0x0000000000401003 <+82>:	cmpl   $0x31b,0x14(%rsp) # compare 3rd input with 795
   0x000000000040100b <+90>:	je     0x4010f9 <phase_3+328> # if = continue to final check
   0x0000000000401011 <+96>:	call   0x401742 <explode_bomb> # if not equal explode bomb
   0x0000000000401016 <+101>:	mov    $0x6d,%eax # reload 'm' into eax
   0x000000000040101b <+106>:	jmp    0x4010f9 <phase_3+328> # jump to final check
   # Case 1 handler (jump table entry: 0x0000000000401020)
   0x0000000000401020 <+111>:	mov    $0x75,%eax # load 'u' 117 into eax
   0x0000000000401025 <+116>:	cmpl   $0x325,0x14(%rsp) # compare 3rd input with 805
   0x000000000040102d <+124>:	je     0x4010f9 <phase_3+328> # if equal jump to final check
   0x0000000000401033 <+130>:	call   0x401742 <explode_bomb> # not equal blow up
   0x0000000000401038 <+135>:	mov    $0x75,%eax # reaload u into eax
   0x000000000040103d <+140>:	jmp    0x4010f9 <phase_3+328> # jump to final check
   # Case 2 handler (jump table entry: 0x0000000000401042)
   0x0000000000401042 <+145>:	mov    $0x6e,%eax # move 'n' 110 into eax
   0x0000000000401047 <+150>:	cmpl   $0x176,0x14(%rsp) # compare 3rd input with 374
   0x000000000040104f <+158>:	je     0x4010f9 <phase_3+328> #
   0x0000000000401055 <+164>:	call   0x401742 <explode_bomb>
   0x000000000040105a <+169>:	mov    $0x6e,%eax 
   0x000000000040105f <+174>:	jmp    0x4010f9 <phase_3+328>
   # Case 3 handler (jump table entry: 0x0000000000401064)
   0x0000000000401064 <+179>:	mov    $0x63,%eax # load 'c' 99 into eax
   0x0000000000401069 <+184>:	cmpl   $0x397,0x14(%rsp) # compare 3rd input with 919
   0x0000000000401071 <+192>:	je     0x4010f9 <phase_3+328> # if ewaul then proceed to final check
   0x0000000000401077 <+198>:	call   0x401742 <explode_bomb> # if not explode bomb
   0x000000000040107c <+203>:	mov    $0x63,%eax
   0x0000000000401081 <+208>:	jmp    0x4010f9 <phase_3+328>
   # Case 4 handler (jump table entry: 0x0000000000401083)
   0x0000000000401083 <+210>:	mov    $0x73,%eax # move 's' 115 into eax
   0x0000000000401088 <+215>:	cmpl   $0x99,0x14(%rsp) # compare third input with 153
   0x0000000000401090 <+223>:	je     0x4010f9 <phase_3+328> # if ewaul continue to final check
   0x0000000000401092 <+225>:	call   0x401742 <explode_bomb> # otherwise explode bomb
   0x0000000000401097 <+230>:	mov    $0x73,%eax # reload s into eax
   0x000000000040109c <+235>:	jmp    0x4010f9 <phase_3+328> # proceed to final check
   # Case 5 handler (jump table entry: 0x000000000040109e)
   0x000000000040109e <+237>:	mov    $0x73,%eax # move 's' 115 into eax
   0x00000000004010a3 <+242>:	cmpl   $0xd6,0x14(%rsp) # comapre 3rd input with 214
   0x00000000004010ab <+250>:	je     0x4010f9 <phase_3+328> # if equal continue
   0x00000000004010ad <+252>:	call   0x401742 <explode_bomb> # otherwise blow up
   0x00000000004010b2 <+257>:	mov    $0x73,%eax
   0x00000000004010b7 <+262>:	jmp    0x4010f9 <phase_3+328>
   # Case 6 handler (jump table entry: 0x00000000004010b9)
   0x00000000004010b9 <+264>:	mov    $0x6c,%eax # load 'l' 108 into eax
   0x00000000004010be <+269>:	cmpl   $0x1d3,0x14(%rsp) # compare 3rd input with 467
   0x00000000004010c6 <+277>:	je     0x4010f9 <phase_3+328> # if equal continue to final check
   0x00000000004010c8 <+279>:	call   0x401742 <explode_bomb> # othwerwise explode bomb
   0x00000000004010cd <+284>:	mov    $0x6c,%eax
   0x00000000004010d2 <+289>:	jmp    0x4010f9 <phase_3+328>
   # Case 7 handler (jump table entry: 0x00000000004010d4)
   0x00000000004010d4 <+291>:	mov    $0x78,%eax # load 'x' 120 into eax
   0x00000000004010d9 <+296>:	cmpl   $0xdc,0x14(%rsp) # compare 3rd input with 220
   0x00000000004010e1 <+304>:	je     0x4010f9 <phase_3+328> # continu to final check if equal
   0x00000000004010e3 <+306>:	call   0x401742 <explode_bomb> # otherwise blow yp
   0x00000000004010e8 <+311>:	mov    $0x78,%eax
   0x00000000004010ed <+316>:	jmp    0x4010f9 <phase_3+328>
   # Default case handler (input > 7)
   0x00000000004010ef <+318>:	call   0x401742 <explode_bomb> # explode bomb for invalid first input
   0x00000000004010f4 <+323>:	mov    $0x63,%eax # load 'c' into eax
   # final check for all cases
   0x00000000004010f9 <+328>:	cmp    0xf(%rsp),%al # compare second input char with expected char in al
   0x00000000004010fd <+332>:	je     0x401104 <phase_3+339> # if 2nd char = al then continue
   0x00000000004010ff <+334>:	call   0x401742 <explode_bomb> # otherwise blow up
   # clean up stack
   0x0000000000401104 <+339>:	mov    0x18(%rsp),%rax
   0x0000000000401109 <+344>:	xor    %fs:0x28,%rax
   0x0000000000401112 <+353>:	je     0x401119 <phase_3+360>
   0x0000000000401114 <+355>:	call   0x400b90 <__stack_chk_fail@plt>
   0x0000000000401119 <+360>:	add    $0x28,%rsp
   0x000000000040111d <+364>:	ret