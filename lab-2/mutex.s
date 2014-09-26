	.syntax unified
	.arch armv7-a
	.text

	.equ locked, 1
	.equ unlocked, 0

	.global lock_mutex
	.type lock_mutex, function
lock_mutex:
        @ INSERT CODE BELOW
	ldr r1, =locked		@ load 'lock taken' to reg1
	.L2:
	ldrex r2, [r0]		@ load exclusive lock value from memory
	cmp r2, unlocked	@ check if the mutex is unlocked, flag
	strexeq r2, r1, [r0]	@ if mutex is unlocked, lock it and assign r2 value
	cmpeq r2, #0		@ check if Store-Exclusive succeed, 0 is succeed 
	bne .L2			@ if flag is false loop
	@ END CODE INSERT
	bx lr
	.size lock_mutex, .-lock_mutex

	.global unlock_mutex
	.type unlock_mutex, function
unlock_mutex:
	@ INSERT CODE BELOW
	ldr r1, = unlocked	@ load 'unlock tacken' to r1
	str r1, [r0]
        @ END CODE INSERT
	bx lr
	.size unlock_mutex, .-unlock_mutex

	.end
