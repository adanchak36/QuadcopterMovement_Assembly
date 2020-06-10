section .data
	textReqInput: db "Enter quadcopter rotor movement", 0xA
	textdebug: db "Your input is: "
	text1: db  "Throttle: move down", 0xA 
	text2: db  "Throttle: move up", 0xA
	
	badcalltext: db "Not equal", 0xA
	
section .bss
	buff resb 5

section .text
	global _start	

_start: 
	call main
	call exitProgram

main: 
	call printReqInput
	call getsignalInput
	call printbuff
	call checkSignal
	ret
	

printReqInput: 
	mov rax, 1
	mov rdi, 1
	mov rsi, textReqInput
	mov rdx, 32
	syscall
	ret

getsignalInput: 
	xor rax, rax
	xor rdi, rdi
	mov rsi, buff
	mov rdx, 5
	syscall
	ret

printbuff: 
	mov rax, 1
	mov rdi, 1
	mov rsi, textdebug
	mov rdx, 15
	syscall 
	
	mov rax, 1
	mov rdi, 1
	mov rsi, buff
	mov rdx, 5
	syscall 

	ret

checkSignal: 
	; Compare input to 'A'
	mov dil, [buff]
	mov sil, 'A'
	cmp dil, sil
	jne badCall
	ret 

badCall: 
	mov rax, 1
	mov rdi, 1
	mov rsi, buff
	mov rdx, 9
	syscall
	ret 

exitProgram: ;exit(0) 
	mov rax, 60
	xor rdi, rdi
	syscall
