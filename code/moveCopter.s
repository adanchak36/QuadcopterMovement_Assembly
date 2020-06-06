#gcc -c moveCopter.s && ld moveCopter.o && ./a.out

#Pre-defined memory section
.section .data
	requestInput: .string "Enter rotor quadcopter movement\n"


#Instructions
.section .text
	.global _start  

_start: 
	callq getSignal
	
	callq exitProgram



getSignal: 
	#write(1, requestInput, 32)
	movq $1, %rax
	movq $1, %rdi
	movq $requestInput, %rsi
	movq $32, %rdx 
	syscall 
	ret 

exitProgram: 
	#exit(0)
	mov $60, %rax
	xor %rdi, %rdi 
	syscall
