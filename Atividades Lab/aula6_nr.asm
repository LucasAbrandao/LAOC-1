000   # r0: tamanho do vetor
001   # r1: auxiliar
010   # r2: maior valor
011   # r3: menor valor
100   # r4
101   # rr: registrador de resultado geral
101   # ra
111   # sp: stack pointer

rst $rr                  # 000 00 100   # rr = 0 
addi 5                   # 010 00101    # rr += 5
move $r0                 # 000 01 000   # r0 = rr

rst $rr                  # 000 00 100   # rr = 0
addi 20                  # 010 10100    # rr += 20
inv $rr                  # 000 00 100   # rr = -rr
move $sp                 # 000 01 101   # sp = rr

#v[0] = 17
rst $rr                  # 000 00 100   # rr = 0
addi 17                  # 110 010001   # rr += 17
rmove $r1                # 000 10 001   # r1 = rr = 17
sw $r1, $sp              # 100 01 101   # v[0] = 17
rmove $sp                # 000 10 101   # rr = sp
addi 4                   # 110 00100    # rr += 4 --> 'sp += 4'
move $sp                 # 000 01 101   # sp = rr

#v[1] = 15
rst $rr                  # 000 00 100   # rr = 0
addi 15                  # 010 01111    # rr += 15
rmove $r1                # 000 10 001   # r1 = rr = 15
sw $r1, $sp              # 100 01 101   # v[1] = 15 
rmove $sp                # 000 10 101   # rr = sp
addi 4                   # 010 00100    # rr += 4 --> 'sp += 4'
move $sp                 # 000 01 101   # sp = rr

#v[2] = 28
rst $rr                  # 000 00 100   # rr = 0
addi 28                  # 010 11100    # rr += 28
rmove $r1                # 000 10 001   # r1 = rr = 15
sw $r1, $sp              # 100 01 101   # v[2] = 28
rmove $sp                # 000 10 101   # rr = sp
addi 4                   # 110 00100    # rr += 4 --> 'sp += 4'
move $sp                 # 000 01 101   # sp = rr

#v[3] = 10
rst $rr                  # 000 00 100   # rr = 0
addi 10                  # 110 01010    # rr += 10
rmove $r1                # 000 10 001   # r1 = rr = 15
sw $r1, $sp              # 100 01 101   # v[3] = 10
rmove $sp                # 000 10 101   # rr = sp
addi 4                   # 110 00100    # rr += 4 --> 'sp += 4' 
move $sp                 # 000 01 101   # sp = rr

#v[4] = 5
rst $rr                  # 000 00 100   # rr = 0
addi 5                   # 000 00101    # rr += 5
rmove $r1                # 000 10 001   # r1 = rr = 15
sw $r1, $sp              # 100 01 101   # v[4] = 5

lw $r2, $sp              # 011 10 101   # r2 = v[4]
lw $r3, $sp              # 011 11 101   # r3 = v[4]

#while: 

   # n--
   rst $rr               # 000 00 100   # rr = 0
   addi 1                # 010 00001    # rr += 1
   inv $rr               # 000 11 100   # rr = -rr
   add $r0, $rr          # 001 00 100   # r0 += -1

   # v++
   rst $rr               # 000 00 100   # rr = 0
   addi 4                # 010 00100    # rr += 4   
   inv $rr               # 000 11 100   # rr = -rr
   move $r1              # 000 01 001   # r1 = rr
   add $r1, $sp          # 001 01 101   # sp += -4

   rst $rr               # 000 00 100   # rr = 0
   addi 31               # 010 11111    # rr += 31
   addi 28               # 010 11100    # rr += 28
   move $ra              # 000 01 110   # ra = rr

   beqz $r0              # 101 01 000   # if(n == 0) exit()
   jr $ra                # 101 11 110   # j exit

   lw $r1, $sp           # 011 01 101   # aux = v[n]

   rst $rr               # 000 00 100   # rr = 0
   addi 31               # 010 11111    # rr += 34
   addi 3                # 010 00011    # rr += 3
   move $ra              # 000 01 110   # ra = rr

   slt $r1, $r3          # 110 01 011   # rr = (v[n] < menor)
   beqz $rr              # 101 01 100   # bne zero => pula 2 linhas
   # linha livre
   jr $ra                # 101 11 110   # j menor if (v[n] < menor)

#if_2: 
   rst $rr               # 000 00 100   # rr = 0
   addi 31               # 010 11111    # rr += 31
   addi 14               # 010 01110    # rr += 14
   inv $rr               # 000 11 100   # rr = -rr
   move $ra              # 000 10 110   # ra = rr

   slt $r1, $r2          # 110 01 010   # rr = (v[n] < maior)
   beqz $rr              # 101 01 100   # bne $rr, $zero, while --> (v[n] < maior) => while
   # linha livre
   jr $ra                # 101 11110    #  (v[n] < maior) => while 

   rst $rr               # 000 00100    # rr = 0
   addi 31               # 010 11111    # rr += 31
   addi 23               # 010 10111    # rr += 23
   inv $rr               # 000 11 100   # rr = -rr
   move $ra              # 000 01 110   # ra = rr

   beqr $r1, $r2         # 101 01 010   
   jr $ra                # 101 11 110   # (v[n] = maior) => while
   # linha livre
   rst $r2               # 000 00 010   # r2 = 0
   add $r2, $r1          # 001 10 001   # r2 += r1 --> maior = v[n]

   rst $rr               # 000 00 100   # rr = 0
   addi 22               # 010 10110    # rr += 22
   addi 22               # 010 10110    # rr += 22
   addi 22               # 010 10101    # rr += 22
   inv $rr               # 000 11 10    # rr = -rr
   move $ra              # 000 01110    # ra = rr

   jr $ra                # 101 11110    # j while

#menor:
   rst $r3              # 000 00 011    # r3 = 0
   add $r3, $r1         # 001 11001     # menor = v[n]

   rst $rr              # 000 00100     # rr = 0
   addi 31              # 010 11111     # rr += 31
   addi 12              # 010 01100     # rr += 12
   inv $rr              # 000 11 100    # rr = -rr
   move $ra             # 000 01 110    # ra = rr

   jr $ra               # 101 11 110    # j if_2 

#exit:
   halt                 # 101 00 000    # Para a execução do programa.