; Function phase_6: Expects 6 unique integers (1-6) as input.
; Rearranges pointers to nodes based on input order and checks if node values are descending.

; stack stuff
0x0000000000401241 <+0>:    push   %r13        ; Save register r13
0x0000000000401243 <+2>:    push   %r12        ; Save register r12
0x0000000000401245 <+4>:    push   %rbp        ; Save register rbp
0x0000000000401246 <+5>:    push   %rbx        ; Save register rbx
0x0000000000401247 <+6>:    sub    $0x68,%rsp  ; Allocate 104 bytes on stack
0x000000000040124b <+10>:   mov    %fs:0x28,%rax   ; Get stack canary 
0x0000000000401254 <+19>:   mov    %rax,0x58(%rsp) ; Store canary
0x0000000000401259 <+24>:   xor    %eax,%eax      ; Zero out eax

; --- Read Input ---
0x000000000040125b <+26>:   mov    %rsp,%rsi      ; Argument 2 for read_six_numbers: pointer to stack buffer (rsp)
0x000000000040125e <+29>:   call   0x401778 <read_six_numbers> ; Reads 6 integers into [rsp] to [rsp+0x14]

; --- Input Validation Loop 1: Check Range (1-6) and Uniqueness ---
0x0000000000401263 <+34>:   mov    %rsp,%r12      ; r12 points to the start of the input numbers on the stack
0x0000000000401266 <+37>:   mov    $0x0,%r13d     ; r13d = 0 (Outer loop counter: 0 to 5)
; Outer loop starts (checks numbers at index r13d = 0 through 5)
0x000000000040126c <+43>:   mov    %r12,%rbp      ; rbp points to the current number being checked by the outer loop (input[r13d])
0x000000000040126f <+46>:   mov    (%r12),%eax    ; eax = value of input[r13d]
0x0000000000401273 <+50>:   sub    $0x1,%eax      ; eax = input[r13d] - 1
0x0000000000401276 <+53>:   cmp    $0x5,%eax      ; Compare (input[r13d] - 1) with 5
0x0000000000401279 <+56>:   jbe    0x401280       ; Jump if <= 5 (means original number was 1 <= input[r13d] <= 6)
0x000000000040127b <+58>:   call   0x401742 <explode_bomb> ; Explode if number is out of range [1, 6]

; Start inner loop (checks for duplicates against input[r13d])
0x0000000000401280 <+63>:   add    $0x1,%r13d     ; Increment outer loop counter (now represents count 1 to 6)
0x0000000000401284 <+67>:   cmp    $0x6,%r13d     ; processed all 6 numbers in outer loop yet?
0x0000000000401288 <+71>:   je     0x4012c7       ; If yes, all numbers validated (range+unique), jump to node selection
0x000000000040128a <+73>:   mov    %r13d,%ebx     ; ebx = Inner loop counter, starting from index r13d (index 1 to 5)
; Inner loop starts (checks input[r13d] against input[ebx] where ebx > r13d-1)
0x000000000040128d <+76>:   movslq %ebx,%rax      ; rax = 64-bit version of inner loop index ebx
0x0000000000401290 <+79>:   mov    (%rsp,%rax,4),%eax ; eax = value of input[ebx] (number at index ebx)
0x0000000000401293 <+82>:   cmp    %eax,0x0(%rbp) ; Compare input[ebx] with input[r13d-1] (pointed to by rbp)
0x0000000000401296 <+85>:   jne    0x40129d       ; Jump if they are different (not a duplicate)
0x0000000000401298 <+87>:   call   0x401742 <explode_bomb> ; Explode if input[ebx] == input[r13d-1] (duplicate found)

; Increment inner loop and continue duplicate check
0x000000000040129d <+92>:   add    $0x1,%ebx      ; Increment inner loop index ebx
0x00000000004012a0 <+95>:   cmp    $0x5,%ebx      ; Have we checked against all subsequent numbers (up to index 5)?
0x00000000004012a3 <+98>:   jle    0x40128d       ; If ebx <= 5, loop back to check next inner index
; Inner loop finished for input[r13d-1]
0x00000000004012a5 <+100>:  add    $0x4,%r12      ; Move r12 to point to the next input number (input[r13d])
0x00000000004012a9 <+104>:  jmp    0x40126c       ; Jump back to start of outer loop for the next number

; --- Node Selection Loop (Using input numbers to select nodes) ---
; This section iterates through the validated input numbers
; For each input number N, it selects a node from the preset list
; The traversal code below appears to follow N-1 'next' links from 0x604300 which held me up for awhile
; However, this logic conflicts with the list structure for N=5 and N=6.
; The actual behavior is that input N selects the node identified as "Node N".
0x00000000004012c7 <+134>:  mov    $0x0,%esi      ; esi = 0 (Loop index for input array 0 to 5, used as offset multiplier)
; Node selection loop starts
0x00000000004012cc <+139>:  mov    (%rsp,%rsi,1),%ecx ; ecx = N = value of input[esi/4]
0x00000000004012cf <+142>:  mov    $0x1,%eax      ; eax = 1 (Counter for list traversal)
0x00000000004012d4 <+147>:  mov    $0x604300,%edx ; edx = Pointer to the head of the predefined linked list (Node 1)
0x00000000004012d9 <+152>:  cmp    $0x1,%ecx      ; Is the input number N == 1?
0x00000000004012dc <+155>:  jg     0x4012ab       ; If N > 1 jump to the traversal loop
0x00000000004012de <+157>:  jmp    0x4012b6       ; If N == 1skip traversal and jump directly to store the head node pointer

; List traversal sub-loop (Attempts to find Nth node)
0x00000000004012ab <+106>:  mov    0x8(%rdx),%rdx ; rdx = rdx->next (Move to next node pointer at offset 8)
0x00000000004012af <+110>:  add    $0x1,%eax      ; Increment traversal counter
0x00000000004012b2 <+113>:  cmp    %ecx,%eax      ; Compare N (ecx) with counter (eax)
0x00000000004012b4 <+115>:  jne    0x4012ab       ; If counter != N continue traversing

; Store the selected node pointer
0x00000000004012b6 <+117>:  ; rdx now holds the pointer to the effectively selected node for input N
                           mov    %rdx,0x20(%rsp,%rsi,2) ; Store node pointer rdx into array at rsp+0x20 + esi*2
                           ; Array indices: (esi=0)->rsp+0x20, (esi=4)->rsp+0x28, ... (esi=20)->rsp+0x48
0x00000000004012bb <+122>:  add    $0x4,%rsi      ; Increment index offset esi by 4 for next input number
0x00000000004012bf <+126>:  cmp    $0x18,%rsi     ; Compare esi with 24 (0x18)
0x00000000004012c3 <+130>:  jne    0x4012cc       ; If esi != 24 (haven't processed all 6 inputs), loop back
0x00000000004012c5 <+132>:  jmp    0x4012e0       ; Finished selecting nodes, jump to re-linking phase

; --- Re-linking Phase ---
; Takes the 6 node pointers stored in the array at rsp+0x20 to rsp+0x48
; and links them according to the original input order.
0x00000000004012e0 <+159>:  mov    0x20(%rsp),%rbx ; rbx = pointer to first selected node ( input[0])
0x00000000004012e5 <+164>:  lea    0x20(%rsp),%rax ; rax = address of the start of the pointer array (rsp+0x20)
0x00000000004012ea <+169>:  lea    0x48(%rsp),%rsi ; rsi = address of the last pointer in the array (rsp+0x48)
0x00000000004012ef <+174>:  mov    %rbx,%rcx      ; rcx = pointer to current node being linked (starts with node from input[0])
; Re-linking loop
0x00000000004012f2 <+177>:  mov    0x8(%rax),%rdx ; rdx = pointer to next node from the array (node from input[k+1])
0x00000000004012f6 <+181>:  mov    %rdx,0x8(%rcx) ; Set (current node)->next = pointer to next node
0x00000000004012fa <+185>:  add    $0x8,%rax      ; Move rax to point to the next pointer slot in the array
0x00000000004012fe <+189>:  mov    %rdx,%rcx      ; Update current node for next iteration (rcx = next node)
0x0000000000401301 <+192>:  cmp    %rsi,%rax      ; Have we reached the address of the last pointer slot?
0x0000000000401304 <+195>:  jne    0x4012f2       ; If not, continue linking
; Finished loop, set last node's next pointer
0x0000000000401306 <+197>:  movq   $0x0,0x8(%rdx) ; Set (last node in sequence)->next = NULL

; --- Final Check: Descending Order Verification ---
; Iterates through the newly re-linked list (headed by rbx)
; and checks if the node values (at offset 0) are in descending order.
0x000000000040130e <+205>:  mov    $0x5,%ebp      ; ebp = 5 (Loop counter for 5 comparisons: 0-1, 1-2, ..., 4-5)
; Verification loop starts
0x0000000000401313 <+210>:  mov    0x8(%rbx),%rax ; rax = current_node->next (pointer to the next node)
0x0000000000401317 <+214>:  mov    (%rax),%eax    ; eax = value of next node (dereference pointer rax, read first 4 bytes)
0x0000000000401319 <+216>:  cmp    %eax,(%rbx)    ; Compare next_node_value (eax) with current_node_value (at rbx)
0x000000000040131b <+218>:  jge    0x401322       ; Jump if current_node_value >= next_node_value (descending order is maintained)
0x000000000040131d <+220>:  call   0x401742 <explode_bomb> ; Explode if current_node_value < next_node_value (not descending)

; Move to next node for comparison
0x0000000000401322 <+225>:  mov    0x8(%rbx),%rbx ; rbx = current_node->next (Move to the next node)
0x0000000000401326 <+229>:  sub    $0x1,%ebp      ; Decrement loop counter
0x0000000000401329 <+232>:  jne    0x401313       ; If counter != 0, loop back to compare next pair

; --- Phase Defused: Clean up and Return ---
; Stack Canary Check
0x000000000040132b <+234>:  mov    0x58(%rsp),%rax ; rax = canary value read from stack
0x0000000000401330 <+239>:  xor    %fs:0x28,%rax   ; Compare with original canary value. Result is 0 if they match.
0x0000000000401339 <+248>:  je     0x401340        ; Jump if canary is intact
0x000000000040133b <+250>:  call   0x400b90 <__stack_chk_fail@plt> ; Canary check failed, abort.

; Restore Stack and Registers
0x0000000000401340 <+255>:  add    $0x68,%rsp     ; Deallocate stack frame
0x0000000000401344 <+259>:  pop    %rbx           ; Restore rbx
0x0000000000401345 <+260>:  pop    %rbp           ; Restore rbp
0x0000000000401346 <+261>:  pop    %r12           ; Restore r12
0x0000000000401348 <+263>:  pop    %r13           ; Restore r13
0x000000000040134a <+265>:  ret                   ; Return from function