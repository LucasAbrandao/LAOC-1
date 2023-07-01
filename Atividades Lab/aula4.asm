.text

main:   addi $a0, $zero, 33 # a0 = y
        jal f # chama funcao f

        add $t0, $zero, $v0 # result = f(32)
        add $v0, $zero, $t0 # armazena em v0 o result
        j exit_total # return result

f:      subi $sp, $sp, 128 # aloca o vetor de tamanho 32 na stack
        add $t7, $zero, $sp # endereco base do vetor

        addi $t1, $zero, -1
        sw $t1, 0($sp) # a[0] = -1
        sw $t1, 4($sp) # a[1] = -1

        addi $t0, $zero, 2 # int i = 2
        addi $t7, $t7, 8 # endereco base move duas posicoes (2 Bytes)

        slt $t2, $a0, $t0 # (y < i) o mesmo que (i > y) ? t2 = 1 : t2 = 0
        bne $t2, $zero, exit # nao entra no for se t2 == 1

for:    lw $t1, -4($t7) # t1 = a[i-1]
        lw $t2, -8($t7) # t2 = a[i-2]

        add $t3, $t1, $t2 # t3 = t1 + t2

        sw $t3, 0($t7) # a[i] = t3

        addi $t0, $t0, 1 # i++
        addi $t7, $t7, 4 # endereco base move 1 posicao (1 Byte)

        slt $t1, $a0, $t0 # y < i (i > y) se isso for falso (t1 == 0) quer dizer i <= y
        beq $t1, $zero, for # volta ao for se t1 == 0

exit:   lw $v0, -4($t7) # v0 = a[y]
        addi $sp, $sp, 128 # libera o vetor de tamanho 32 da stack

        jr $ra # return v0 (a[y])

exit_total:
