.data
	#�rea para dados na mem�ria principal
	msg: .asciiz "Ol�, mundo" #mensagem a ser exibida ao usuario
.text
	#�rea para instru��es do programa 
	li $v0, 4 #instru��es para imprimir string
	la $a0, msg #indicar o endere�o onde estar� a mensagem
	syscall #comando para imprimir
	