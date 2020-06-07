.section .rodata #read only data section
	.align 8 #8 byte memory alignment for jump table
.L0: 
	.quad .L1 #x = 1 (Throttle: move down)
	.quad .L2 #x = 2 (Throttle: move up) 
	.quad .L3 #x = 3 (Pitch: move forward)
	.quad .L4 #x = 4 (Pitch: move backward)
	.quad .L5 #x = 5 (Roll: Bend left)
	.quad .L6 #x = 6 (Roll: Bend right)
	.quad .L7 #x = 7 (Yaw: rotate left)
	.quad .L8 #x = 8 (Yaw: rotate right)
	.quad .L9 #extra case? 
	
.section .data
	requestInput: .string "Enter rotor quadcopter movement\n"


.section .text #Instructions
	.global _start  

_start: 
	callq getSignal
	
	#debug
	movq $2, %rdi
	
	callq moveToRotorFunction

	callq exitProgram



getSignal: 
	#write(1, requestInput, 32)
	movq $1, %rax
	movq $1, %rdi
	movq $requestInput, %rsi
	movq $32, %rdx 
	syscall 

	#read in an 8 bit ASCII character from STDIN

	#read(file descriptor, buffer, len(buffer))
#	movq $0, %rax
#	movq $0, %rdi
	ret 

moveToRotorFunction: 
	jmp *.L0(,%rdi,8) #indirect jump Mem[start of table + [rdi] + 8] 
	
	
	.L1: #x = 1 (Throttle: move down)
		#All rotors set to low speed
		ret

	.L2: #x = 2 (Throttle: move up)
		#All rotors set to high speed
		nop 
		ret

	.L3: #x = 3 (Pitch: move forward)
		#R1/R4 set to high speed
		#R2/R3 set to low speed
		ret

	.L4: #x = 4 (Pitch: move backward)
		#R2/R3 set to high speed
		#R1/R4 set to low speed
		ret

	.L5: #x = 5 (Roll: Bend left)
		#R1/R2 set to low speed
		#R3/R4 set to high speed
		ret

	.L6: #x = 6 (Roll: Bend right)
		#R1/R2 set to high speed
		#R3/R4 set to low speed
		ret

	.L7: #x = 7 (Yaw: rotate left)
		#R1/R3 set to high speed
		#R2/R4 set to low speed
		ret

	.L8: #x = 8 (Yaw: rotate right)
		#R2/R4 set to high speed
		#R1/R3 set to low speed
		ret

	.L9: #extra casedd? 
		ret
 
	
		


exitProgram: 
	#exit(0)
	mov $60, %rax
	xor %rdi, %rdi 
	syscall

