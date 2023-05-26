.data
	#área para dados na memória principal
	msg: .asciiz "Olá, mundo" #mensagem a ser exibida ao usuario
.text
	#área para instruções do programa 
	li $v0, 4 #instruções para imprimir string
	la $a0, msg #indicar o endereço onde estará a mensagem
	syscall #comando para imprimir
	