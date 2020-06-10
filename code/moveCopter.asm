section .data
	textReqInput: db "Enter quadcopter rotor movement", 0xA
	lenReq: equ $-textReqInput
	textdebug: db "Your input is: "

	textIntro: db "Welcome: Below are your commands to control the quadcopter", 0xA ;len 59
	lenIntro: equ $-textIntro

	;be careful all contigous in memory
	text1: db  "A - Throttle: move down", 0xA ;len 23 
	len1: equ $-text1
	text2: db  "B - Throttle: move up", 0xA ;len 20
	len2: equ $-text2
	text3: db  "C - Pitch: move forward", 0xA ;len 23
	len3: equ $-text3
	text4: db  "D - Pitch: move backward", 0xA ;len 24
	len4: equ $-text4
	text5: db  "E - Roll: bend left", 0xA ;len 20
	len5: equ $-text5
	text6: db  "F - Roll: bend right", 0xA ;len 22
	len6: equ $-text6
	text7: db  "G - Yaw: rotate left", 0xA ;len 22
	len7: equ $-text7
	text8: db  "H - Yaw: rotate right", 0xA ;len 23
	len8: equ $-text8
	text9: db "Q - Exit and land", 0xA
	len9: equ $-text9
	
	badcalltext: db "Not equal", 0xA
	
section .bss
	buff resb 5

section .text
	global _start	

_start: 
	call main
	call exitProgram

main: 
	call setupInstructions
	call printReqInput
	call getsignalInput
	call printbuff
	call checkSignal
	ret

setupInstructions:
	call printIntro
	call printMoveA
	call printMoveB
	call printMoveC
	call printMoveD
	call printMoveE
	call printMoveF
	call printMoveG
	call printMoveH
	call printQuitMessage

	ret

printIntro: 
	mov rax, 1
	mov rdi, 1
	mov rsi, textIntro
	mov rdx, lenIntro
	syscall
	ret

printMoveA: 
	mov rax, 1
	mov rdi, 1
	mov rsi, text1
	mov rdx, len1 
	syscall
	ret	

printMoveB:
        mov rax, 1
        mov rdi, 1
        mov rsi, text2
        mov rdx, len2
        syscall
        ret

printMoveC:
        mov rax, 1
        mov rdi, 1
        mov rsi, text3
        mov rdx, len3
        syscall
        ret

printMoveD:
        mov rax, 1
        mov rdi, 1
        mov rsi, text4
        mov rdx, len4
        syscall
        ret

printMoveE:
        mov rax, 1
        mov rdi, 1
        mov rsi, text5
        mov rdx, len5
        syscall
        ret

printMoveF:
        mov rax, 1
        mov rdi, 1
        mov rsi, text6
        mov rdx, len6
        syscall
        ret

printMoveG:
        mov rax, 1
        mov rdi, 1
        mov rsi, text7
        mov rdx, len7
        syscall
        ret

printMoveH:
        mov rax, 1
        mov rdi, 1
        mov rsi, text8
        mov rdx, len8
        syscall
        ret

printQuitMessage:
	mov rax, 1
	mov rdi, 1
	mov rsi, text9
	mov rdx, len9
	syscall
	ret

printReqInput: 
	mov rax, 1
	mov rdi, 1
	mov rsi, textReqInput
	mov rdx, lenReq
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
	mov rsi, badcalltext
	mov rdx, 9
	syscall
	ret 

exitProgram: ;exit(0) 
	mov rax, 60
	xor rdi, rdi
	syscall
