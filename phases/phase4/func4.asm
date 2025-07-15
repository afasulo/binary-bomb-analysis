Dump of assembler code for function func4:
   0x000000000040111e <+0>:	push   %rbx             ; Save the value of RBX on the stack (callee-saved register).

   ; Calculate 'range = high - low'
   0x000000000040111f <+1>:	mov    %edx,%eax        ; Move 'high' (edx) into EAX. (EAX = high)
   0x0000000000401121 <+3>:	sub    %esi,%eax        ; Subtract 'low' (esi) from EAX. (EAX = high - low)

   ; Calculate 'midpoint_offset = range / 2' (integer division, accounts for negative range)
   0x0000000000401123 <+5>:	mov    %eax,%ebx        ; Copy 'range' (EAX) into EBX. (EBX = high - low)
   0x0000000000401125 <+7>:	shr    $0x1f,%ebx       ; Arithmetic Right Shift EBX by 31 bits.
                                                   ; This effectively extracts the sign bit of EBX (0 for positive, -1/0xFFFFFFFF for negative).
                                                   ; This is part of the common trick for signed integer division by 2 in assembly (adding 1 to negative numbers before shifting).
   0x0000000000401128 <+10>:	add    %ebx,%eax        ; Add the sign bit (EBX) to EAX (range).
                                                   ; If range is positive, EAX remains 'range'.
                                                   ; If range is negative, EAX becomes 'range - 1'.
   0x000000000040112a <+12>:	sar    $0x1,%eax        ; Arithmetic Right Shift EAX by 1 bit.
                                                   ; This performs signed integer division by 2. (EAX = (high - low) / 2)
                                                   ; So, EAX now holds the 'midpoint offset' from 'low'.

   ; Calculate 'midpoint = low + midpoint_offset'
   0x000000000040112c <+14>:	lea    (%rax,%rsi,1),%ebx ; Calculate 'midpoint = EAX + ESI' and store it in EBX.
                                                   ; (EBX = (high - low) / 2 + low)

   ; Compare 'midpoint' with 'input_val'
   0x000000000040112f <+17>:	cmp    %edi,%ebx        ; Compare 'midpoint' (EBX) with 'input_val' (EDI).
   0x0000000000401131 <+19>:	jle    0x40113f <func4+33> ; Jump if Less than or Equal.
                                                   ; If 'midpoint' <= 'input_val', jump to 0x40113f (right side of the recursive logic).

   ; Case 1: 'midpoint' > 'input_val' (Recursive call with new 'high' bound)
   0x0000000000401133 <+21>:	lea    -0x1(%rbx),%edx  ; Calculate 'new_high = midpoint - 1' and store it in EDX.
                                                   ; EDX will be the third argument for the recursive call.
   0x0000000000401136 <+24>:	call   0x40111e <func4> ; Recursive call to func4.
                                                   ; Arguments: func4(input_val, low, midpoint - 1)
                                                   ; The return value of this call will be in EAX.
   0x000000000040113b <+29>:	add    %ebx,%eax        ; Add 'midpoint' (EBX) to the recursive call's return value (EAX).
                                                   ; This is the sum component of the recursive function.
   0x000000000040113d <+31>:	jmp    0x40114f <func4+49> ; Jump to the function epilogue (return path).

   ; Case 2: 'midpoint' <= 'input_val'
   0x000000000040113f <+33>:	mov    %ebx,%eax        ; Move 'midpoint' (EBX) into EAX.
                                                   ; EAX now holds 'midpoint'. This is a potential direct return if conditions below are met.
   0x0000000000401141 <+35>:	cmp    %edi,%ebx        ; Compare 'midpoint' (EBX) with 'input_val' (EDI).
   0x0000000000401143 <+37>:	jge    0x40114f <func4+49> ; Jump if Greater than or Equal.
                                                   ; If 'midpoint' >= 'input_val', jump to the function epilogue (return path).
                                                   ; This implies that if 'midpoint' == 'input_val', the function returns 'midpoint' directly.

   ; Case 3: 'midpoint' < 'input_val' (Recursive call with new 'low' bound)
   0x0000000000401145 <+39>:	lea    0x1(%rbx),%esi   ; Calculate 'new_low = midpoint + 1' and store it in ESI.
                                                   ; ESI will be the second argument for the recursive call.
   0x0000000000401148 <+42>:	call   0x40111e <func4> ; Recursive call to func4.
                                                   ; Arguments: func4(input_val, midpoint + 1, high)
                                                   ; The return value of this call will be in EAX.
   0x000000000040114d <+47>:	add    %ebx,%eax        ; Add 'midpoint' (EBX) to the recursive call's return value (EAX).
                                                   ; This is the sum component of the recursive function.

   ; Function Epilogue / Return Path
   0x000000000040114f <+49>:	pop    %rbx             ; Restore the original value of RBX from the stack.
   0x0000000000401150 <+50>:	ret                     ; Return from the function. The final result is in EAX.