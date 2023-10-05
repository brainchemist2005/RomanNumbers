.eqv PrintInt ,1
.eqv Exit ,10
.eqv PrintString, 4
.eqv PrintChar, 1
.eqv ReadChar, 12

.text
    li s1, 0
    li t0, 0

loop:
    li a7, ReadChar
    ecall
    li t3, -1
    beq a0, t3, done

    li t2, 'M'
    beq a0, t2, isM
    li t2, 'D'
    beq a0, t2, isD
    li t2, 'C'
    beq a0, t2, isC
    li t2, 'L'
    beq a0, t2, isL
    li t2, 'X'
    beq a0, t2, isX
    li t2, 'V'
    beq a0, t2, isV
    li t2, 'I'
    beq a0, t2, isI
    j done

isM:
    la t1, M_val
    j processNumeral
isD:
    la t1, D_val
    j processNumeral
isC:
    la t1, C_val
    j processNumeral
isL:
    la t1, L_val
    j processNumeral
isX:
    la t1, X_val
    j processNumeral
isV:
    la t1, V_val
    j processNumeral
isI:
    la t1, I_val
    j processNumeral

processNumeral:
    lw t2, 0(t1)
    li a7, PrintInt
    mv a0,s1
    ecall
    beq t0, zero, first
    blt t0, t2, subtract
    add s1, s1, t2
    j updatePrevious
    
first:
    add s1,s1,t2
    j updatePrevious

subtract:
    sub s1, s1, t0
    sub t4,t2 , t0
    add s1, s1, t4
    j updatePrevious

updatePrevious:
    mv t0, t2  
    j loop

done:
    li a7, PrintInt
    mv a0, s1
    ecall
    li a7, Exit
    ecall

err:
    li a7, PrintString
    lw a0, error
    ecall
    j done

.data
error: .string "err"
M_val: .word 1000
D_val: .word 500
C_val: .word 100
L_val: .word 50
X_val: .word 10
V_val: .word 5
I_val: .word 1
