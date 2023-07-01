000   # r0: tamanho do vetor
001   # r1: auxiliar
010   # r2: maior valor
011   # r3: menor valor
100   # r4
101   # rr: registrador de resultado geral
110   # ra
111   # sp: stack pointer

rst $rr                  # 00 101 100  # rr = 0      
addi 5                   # 10 00101 0  # rr += 5
rst $r0                  # 00 000 100  # r0 = 0
add $r0, $rr             # 01 000 101  # r0 += rr

rst $rr                  # 00 101 100  # rr = 0
addi 5                   # 10 00101 0  # rr += 5
inv $rr                  # 00 101 101  # rr = -rr
rst $sp                  # 00 111 100  # sp = 0
add $sp, $rr             # 01 111 101  # sp += rr

rst $rr                  # 00 101 100  # rr = 0
addi 17                  # 10 10001 0  # rr += 17
sw $sp                   # 00 111 010  # v[0] = 17
rst $rr                  # 00 101 100  # rr = 0
addi 1                   # 10 00001 0  # rr += 1
add $sp, $rr             # 01 111 101  # sp += rr

rst $rr                  # 00 101 100  # rr = 0
addi 15                  # 10 01111 0  # rr += 15
sw $sp                   # 00 111 010  # v[1] = 15
rst $rr                  # 00 101 100  # rr = 0
addi 1                   # 10 00001 0  # rr += 1
add $sp, $rr             # 01 111 101  # sp += rr 

rst $rr                  # 00 101 100  # rr = 0
addi 28                  # 10 11100 0  # rr += 28
sw $sp                   # 00 111 010  # v[2] = 28
rst $rr                  # 00 101 100  # rr = 0
addi 1                   # 10 00001 0  # rr += 1
add $sp, $rr             # 01 111 101  # sp += rr   

rst $rr                  # 00 101 100  # rr = 0
addi 10                  # 10 01010 0  # rr += 10
sw $sp                   # 00 111 010  # v[3] = 10
rst $rr                  # 00 101 100  # rr = 0
addi 1                   # 10 00001 0  # rr += 1
add $sp, $rr             # 01 111 101  # sp += rr 

rst $rr                  # 00 101 100  # rr = 0
addi 5                   # 10 00101 0  # rr += 5
sw $sp                   # 00 111 010  # v[4] = 5

lw $sp                   # 00 111 001  # rr = v[4]
rst $r2                  # 00 010 100  # r2 = 0
add $r2, $rr             # 01 010 101  # r2 += v[4]

rst $r3                  # 00 011 100  # r3 = 0
add $r3, $rr             # 01 011 101  # r3 = v[4]

#while:  
         rst $rr               # 00 101 100  # rr = 0
         addi 1                # 10 00001 0  # rr += 1
         inv $rr               # 00 101 101  # rr = -rr
         add $r0, $rr          # 01 000 101  # r0 += -1
         add $sp, $rr          # 01 000 101  # sp += -1

         rst $rr               # 00 101 100  #rr = 0
         addi 31               # 10 11111 0  # rr += 31
         addi 30               # 10 11110 0  # rr += 30
         rst $ra               # 00 110 100  # ra = 0
         add $ra, $rr          # 01 110 101  # ra += rr

         beqz $r0              # 00 000 110  # if(n == 0) exit()
         jr $ra                # 00 110 011  # j exit
         
         rst $rr               # 00 101 100  # rr = 0
         addi 31               # 10 11111 0  # rr += 31
         addi 3                # 10 00011 0  # rr += 3
         rst $ra               # 00 110 100  # ra = 0
         add $ra, $rr          # 01 110 101  # ra += rr

         lw $sp                # 00 111 001  # rr = v[n]
         rst $r1               # 00 001 100  # r1 = 0
         add $r1, $rr          # 01 001 101  # r1 += rr

         slt $r1, $r3          # 11 001 11 1 # rr = (v[n] < menor)
         beqz $rr              # 00 101 110  # if(rr != 0) => pula 2 linhas
         j 1                   # 10 00001 1  # pula 2 linhas
         jr $ra                # 00 110 011  # j 'menor' if (v[n] < menor)
#if_2: 
         rst $rr               # 00 101 100  # rr = 0
         addi 31               # 10 11111 0  # rr += 31
         addi 11               # 10 01011 0  # rr += 11
         inv $rr               # 00 101 101  # rr = -rr
         rst $ra               # 00 110 100  # ra = 0
         add $ra, $rr          # 01 110 101  # ra += rr

         slt $r1, $r2          # 11 001 10 1 # rr = (v[n] < maior)
         beqz $rr              # 00 101 110  # bne $rr, $zero, while --> (v[n] < maior) => while
         j 1                   # 10 00001 1  # pula 2 linhas
         jr $ra                # 00 110 011  # (v[n] < maior) => while 

         rst $rr               # 00 101 100  # rr = 0
         addi 31               # 10 11111 0  # rr += 31
         addi 21               # 10 10101 0  # rr += 21
         inv $rr               # 00 101 101  # rr = -rr
         rst $ra               # 00 110 100  # ra = 0
         add $ra, $rr          # 01 110 101  # ra += rr

         beqr $r1, $r2         # 11 001 10 0 # (v[n] == maior) => linha seguinte
         jr $ra                # 00 110 011  # (v[n] == maior) => while
         rst $r2               # 00 010 100  # r2 = 0
         add $r2, $r1          # 01 010 001  # r2 += r1 (maior = v[n])

         rst $rr               # 00 101 100  # rr = 0
         addi 22               # 10 10110 0  # rr += 22
         addi 22               # 10 10110 0  # rr += 22
         addi 20               # 10 10100 0  # rr += 20
         inv $rr               # 00 101 101  # rr = -rr
         rst $ra               # 00 110 100  # ra = 0
         add $ra, $rr          # 01 110 101  # ra += rr

         jr $ra                # 00 110 011  # j while
#menor:
         rst $r3               # 00 011 100  # r3 = 0
         add $r3, $r1          # 01 011 001  # menor += v[n]

         rst $rr               # 00 101 100  # rr = 0
         addi 31               # 10 11111 0  # rr += 31
         addi 15               # 10 01111 0  # rr += 15
         inv $rr               # 00 101 101  # rr = -rr
         rst $ra               # 00 110 100  # ra = 0
         add $ra, $rr          # 01 110 101  # ra += rr

         jr $ra                # 00 110 011  # j if_2 
#exit   
         halt                  # 00000000    # fim do programa