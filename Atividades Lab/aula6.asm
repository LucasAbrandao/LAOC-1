# s0: tamanho do vetor
# s1: auxiliar
# s2: maior valor (50)
# s3: menor valor (5)
# s4: $rr
# sp: endereco do vetor (como unica coisa a ser armazenada é vetor, compenssp sr ponteiro)

addi $s0, $zero, 5 # n = 5

addi $sp, $sp, -20 # aloca espaço na pilha para o vetor v (v[5])

addi $s4, $zero, 17 
sw $s4, 0($sp) #v[0] = 17
addi $sp, $sp, 4 

addi $s4, $zero, 15
sw $s4, 0($sp) #v[1] = 15
addi $sp, $sp, 4

addi $s4, $zero, 28
sw $s4, 0($sp) #v[2] = 28
addi $sp, $sp, 4

addi $s4, $zero, 10
sw $s4, 0($sp) #v[3] = 10
addi $sp, $sp, 4

addi $s4, $zero, 5
sw $s4, 0($sp) #v[4] = 5

lw $s2, 0($sp)
lw $s3, 0($sp)

while:  addi $s0, $s0, -1               # n--
        addi $sp, $sp, -4               # v -= 4

        beq $s0, $zero, exit            # if(n == 0) exit() 
        
        lw $s1, 0($sp)                  # aux = v[n]
        slt $s4, $s1, $s3               # s4 = (v[n] < menor)
        bne $s4, $zero, menor
        
if_2:   slt $s4, $s1, $s2               # s4 = (v[n] < maior)  
        bne $s4, $zero, while           # (v[n] < maior) => while
        beq $s1, $s2, while             # (v[n] = maior) => while
        
        add $s2, $s1,$zero              # maior = v[n] 
        j while

menor:  add $s3, $s1,$zero              # menor = v[n]
        j if_2

exit: