.data
#Se��o � usada para declarar e definir dados.
    menu: .asciiz "*****OP��ES******\n1. Converte: Fahrenheit - Celsius\n2. Fibonnnaci\n3. En�simo Par\n4. Sair\n Escolha uma op��o:" #mensagem(string) a ser exibida, insereida na "variavel menu".
    invalido: .asciiz "Op��o inv�lida!\n" #menssagem a ser exibida caso nenhuma das 4 op��es seja selecionada.
    fahrenheit_msg: .asciiz "Digite a temperatura em Fahrenheit: "
    resultado_msg: .asciiz "O resultado em Celsius: "
    nova_linha: .asciiz "\n"

.text
#�rea pra instru��es do programa.

.globl main #ponto de entrada para o prgorama.

main: #termo utilizado para indiciar o menu preincipal.
    # exibir o menu de op��es
    li $v0, 4           #atribuir a mensagem de menu, atr�vez do c�digo de chamada 4 no registrador $v0 (syscall para impress�o de string).
    la $a0, menu        #indicar o endere�o do menu no registrador $a0.
    syscall             #imprimir o menu, dentro do registrador $a0.

    #ler a op��o escolhida
    li $v0, 5            #atribuir um inteiro no registrador $v0 (syscall para ler um inteiro).
    syscall              #fazer a syscall para ler a op��o escolhida.
    move $t0, $v0        #copiar e armazenar a op��o escolhida no registrador $t0.

    #verificar a op��o escolhida
    beq $t0, 1, escolha1   #Instru��o de desvio condicional beq, ou seja, se a op��o for 1, pular para o termo "escolha1"
    beq $t0, 2, escolha2   #Se a op��o for 2, pular para o termo "escolha2"
    beq $t0, 3, escolha3   #Se a op��o for 3, pular para o termo "escolha3"
    beq $t0, 4, sair     #se a op��o for 4, pular para o termo "sair"

    #Op��o inv�lida
    li $v0, 4            #atribuir a mensagem de menu, atr�vez do c�digo de chamada 4 no registrador $v0 (syscall para impress�o de string
    la $a0, invalido     #indicar o endere�o do menu no registrador $a0.
    syscall              # Fazer a syscall para imprimir a mensagem de op��o inv�lida

    #Voltar ao in�cio do programa
    j main

escolha1: #termo utilizado para indicar o inicio do c�digo da escolha1
   # Exibir mensagem para digitar a temperatura em Fahrenheit
    li $v0, 4            # Carregar o valor 4 no registrador $v0 (syscall para impress�o de string)
    la $a0, fahrenheit_msg  # Carregar o endere�o da mensagem de entrada em Fahrenheit no registrador $a0
    syscall              # Fazer a syscall para imprimir a mensagem

    # Ler a temperatura em Fahrenheit
    li $v0, 5            # Carregar o valor 5 no registrador $v0 (syscall para ler um inteiro)
    syscall              # Fazer a syscall para ler a temperatura
    move $t0, $v0        # Armazenar a temperatura em Fahrenheit no registrador $t0

    # Converter de Fahrenheit para Celsius
    subi $t1, $t0, 32    # Subtrair 32 para obter a diferen�a em rela��o ao ponto de congelamento da �gua
    li $t2, 5            # Carregar o valor 5 no registrador $t2
    mult $t1, $t2        # Multiplicar a diferen�a por 5
    mflo $t3             # Obter o resultado da multiplica��o

    li $t2, 9            # Carregar o valor 9 no registrador $t2
    div $t3, $t2         # Dividir o resultado por 9
    mflo $t3             # Obter o resultado da divis�o

    # Converter o resultado para ponto flutuante
    mtc1 $t3, $f0        # Mover o resultado para o registrador de ponto flutuante $f0
    cvt.s.w $f0, $f0     # Converter para ponto flutuante
    
    #exibir mensagem com o resultado
    li $v0, 4            # Carregar o valor 4 no registrador $v0 (syscall para impress�o de string)
    la $a0, resultado_msg   # Carregar o endere�o da mensagem de resultado em Celsius no registrador $a0
    syscall              # Fazer a syscall para imprimir a mensagem


    # Exibir o resultado em Celsius com at� 3 casas decimais
    li $v0, 2            # Carregar o valor 2 no registrador $v0 (syscall para impress�o de ponto flutuante)
    mov.s $f12, $f0      # Mover o resultado em ponto flutuante para $f12
    li $a1, 3		# Carregar o valor 3 no registrador $a1 (n�mero de casas decimais)
    syscall              # Fazer a syscall para imprimir o resultado com casas decimais
    #pular linha para reiniciar o menu
    li $v0, 4            # Carregar o valor 4 no registrador $v0 (syscall para impress�o de string)
    la $a0, nova_linha      # Carregar o endere�o da string de nova linha no registrador $a0
    syscall              # Fazer a syscall para imprimir a nova linha
    j main              #Voltar ao in�cio do programa

escolha2:#termo utilizado para indicar o inicio do c�digo da escolha2

    # ...
    j main              #Voltar ao in�cio do programa

escolha3:#termo utilizado para indicar o inicio do c�digo da escolha3
    
    # ...
    j main              #Voltar ao in�cio do programa

sair:#termo utilizado para indicar o c�digo de saida.
    #Encerrar o programa
    li $v0, 10           #atribuir o comando 10 no registrador $v0 (syscall para encerrar o programa)
    syscall              #Fazer a syscall para encerrar o programa
