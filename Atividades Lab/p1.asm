addi $s0,$zero,120
addi $t1,$zero,1
addi $t0,$zero,80
bne $s0,$t1,Loop 
j Exit

Loop:	slti $t2,$s0,80 # t2 marca se s0 < 80 
	bne $t2,$zero,Else # se < 80 vai pro else
	beq $t0,$s0,Else # se = 80 vai pro else
	
	subi $s0,$s0,2
	bne $s0,$t1,Loop 
	j Exit
	
Else:	slti $t2,$s0,80 # t2 marca se s0 < 80 
	bne $t2,$zero,MenIq80 # se < 80 vai pro else
	beq $t0,$s0,MenIq80 # se = 80 vai pro else
	
MenIq80:
	srl $s0,$s0,2
	beq $t1,$s0,Exit
	j Loop	

Exit:
