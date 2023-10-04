.eqv PrintInt ,1
.eqv Exit ,10
.eqv PrintString, 4
.eqv PrintChar, 1
.eqv ReadChar, 12

.text
    li s1, 0
    li t0,0   

loop:

    li a7, ReadChar
    ecall
    li t3 , -1
    beq a0,t3,done

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
    j checkGreater

isD:
    la t1, D_val
    j checkGreater

isC:
    la t1, C_val
    j checkGreater

isL:
    la t1, L_val
    j checkGreater
    
isX:
    la t1, X_val
    j checkGreater

isV:
    la t1, V_val
    j checkGreater

isI:
    la t1, I_val
    j checkGreater

checkGreater:
    lw t1, 0(t1)
    bge t0, t1, addition # the problem is in t1
    sub s1, s1, t0
    sub t4,t1 , t0 
    add s1, s1, t4
    mv t0, t1
    
    j loop


addition:
    lw t1, 0(t1)
    add s1, s1, t1  
    mv t0, t1        
    j loop


done:
    li a7, PrintInt
    mv a0, s1
    ecall
    li a7, Exit
    ecall

.data
M_val: .word 1000
D_val: .word 500
C_val: .word 100
L_val: .word 50
X_val: .word 10
V_val: .word 5
I_val: .word 1
