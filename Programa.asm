.data
#Se��o � usada para declarar e definir dados.
    menu: .asciiz "*****OP��ES******\n1. Converte: Fahrenheit - Celsius\n2. Fibonnnaci\n3. En�simo Par\n4. Sair\n Escolha uma op��o:" #mensagem(string) a ser exibida, insereida na "variavel menu".
    invalido: .asciiz "Op��o inv�lida!\n" #menssagem a ser exibida caso nenhuma das 4 op��es seja selecionada.
    fahrenheit_msg: .asciiz "Digite a temperatura em Fahrenheit: "
    resultado_msg: .asciiz "O resultado em Celsius: "
    nova_linha: .asciiz "\n"
    FahrenheitToCelsius: .float 5.0  # Constante usada para a convers�o de Fahrenheit para Celsius
    Float32: .float 32.0  # Constante usada na f�rmula de convers�o
    Float1p8: .float 1.8  # Constante usada na f�rmula de convers�o

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

# Fun��o para ler um n�mero float do usu�rio
readFloat:
    li $v0, 6
    syscall
    jr $ra

# Fun��o para imprimir um n�mero float
printFloat:
    li $v0, 2
    syscall
    jr $ra

# Fun��o para converter Fahrenheit para Celsius
escolha1:
    # Ler temperatura em Fahrenheit
    li $v0, 4
    la $a0, fahrenheit_msg
    syscall

    # Chamar fun��o para ler o valor do usu�rio
    jal readFloat
    mov.s $f12, $f0

    # Converter para Celsius
    li $v0, 4
    la $a0, resultado_msg
    syscall

    # Executar a convers�o de Fahrenheit para Celsius
    l.s $f0, FahrenheitToCelsius
    mul.s $f2, $f12, $f0
    l.s $f1, Float32
    sub.s $f4, $f2, $f1
    l.s $f3, Float1p8
    div.s $f6, $f4, $f3

    # Exibir resultado
    li $v0, 2
    mov.s $f12, $f6
    syscall

    jr $ra


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


