.text
.globl __start

__start:
# prints array {6, 7, 2, 8, 5, 9]
 la $a0, antes
 li $v0, 4
 syscall
 li $a0, 6
 li $v0, 1
 sw $a0, array
 syscall
 la $a0, coma
 li $v0, 4
 syscall
 li $a0, 7
 li $v0, 1
 sw $a0, array+4
 syscall
 la $a0, coma
 li $v0, 4
 syscall
 li $a0, 2
 li $v0, 1
 sw $a0, array+8
 syscall
 la $a0, coma
 li $v0, 4
 syscall
 li $a0, 8
 li $v0, 1
 sw $a0, array+12
 syscall
 la $a0, coma
 li $v0, 4
 syscall
 li $a0, 5
 li $v0, 1
 sw $a0, array+16
 syscall
 la $a0, coma
 li $v0, 4
 syscall
 li $a0, 9
 li $v0, 1
 sw $a0, array+20
 syscall
# sets $a0 to the address of the first element (pointer)
# and $a1 to the address of the last element (pointer)
 la $a0, array
 la $a1, array+20

sort:
  beq $a0, $a1, end  # stops if $a0 == $a1
  jal max            # call the max procedure
  lw $t0, 0($a1)     # load last element into $t0
  sw $t0, 0($v0)     # copy the last element to max loc
  sw $v1, 0($a1)     # copy max value to last element
  addi $a1, $a1, -4  # decrement pointer to last element
  j sort             # repeat sort for smaller list

end:
# prints sorted array
  la $a0, despues
  li $v0, 4
  syscall
  lw $a0, array
  li $v0, 1
  syscall
  la $a0, coma
  li $v0, 4
  syscall
  lw $a0, array+4
  li $v0, 1
  syscall
  la $a0, coma
  li $v0, 4
  syscall
  lw $a0, array+8
  li $v0, 1
  syscall
  la $a0, coma
  li $v0, 4
  syscall
  lw $a0, array+12
  li $v0, 1
  syscall
  la $a0, coma
  li $v0, 4
  syscall
  lw $a0, array+16
  li $v0, 1
  syscall
  la $a0, coma
  li $v0, 4
  syscall
  lw $a0, array+20
  li $v0, 1
  syscall
  li $v0,10
  syscall
 
max:
  la $v0, ($a0)           # initialize max loc to &(A[0])
  lw $v1, 0($a0)          # initialize maximum to A[0]
  li $t1, 0               # initialize index i to 0
  sub $t5, $a1, $a0
  div $t5, $t5, 4
  addi $t5, $t5, 1        # set $t5 to n of elements in A
  loop:
    add $t1, $t1, 1       # increment index i by 1
    beq $t1, $t5, endloop # stop if index == n elements
    mul $t2, $t1, 4       # compute 4i in $t2
    add $t2, $t2, $a0     # form address of A[i] in $t2
    lw $t3, 0($t2)        # load value of A[i] into $t3
    slt $t4, $v1, $t3     # maximum < A[i]?
    beq $t4, $zero, loop  # if not, repeat with no change
    la $v0, ($t2)
    la $v1, ($t3)         # if so, A[i] is the new maximum
    j loop
    
  endloop:
  jr $ra                  # finish max procedure
  
.data
array: .space 24 # reserve 24 bytes (6 words)
coma: .asciiz ", "
antes: .asciiz "Antes:   "
despues: .asciiz "\nDespues: "

