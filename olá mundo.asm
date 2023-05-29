.data
	msg: .asciiz "Ola, mundo" #mensagem a ser exibida ao usuario
.text
	li $v0, 4
	la $a0, msg
	syscall
