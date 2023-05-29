.data
#Seção é usada para declarar e definir dados.
    menu: .asciiz "*****OPÇÕES******\n1. Converte: Fahrenheit -> Celsius\n2. Fibonnnaci\n3. Enésimo Par\n4. Sair\n Escolha uma opção: " #mensagem(string) a ser exibida, insereida na "variavel menu".
    invalido: .asciiz "Opção inválida!\n" #menssagem a ser exibida caso nenhuma das 4 opções seja selecionada.
    fahrenheit_msg: .asciiz "Digite a temperatura em Fahrenheit: "
    fahrenheit_resultado: .asciiz "O resultado em Celsius: "
    nova_linha: .asciiz "\n"
    Float32: .float 32.0
    Float5: .float 5.0
    Float9: .float 9.0
    fibonnacci_msg: .asciiz "Digite o valor de n para calcular o enesimo termo da sequencia de Fibonacci: "
    fibonnacci_resultado: .asciiz "O enésimo termo da sequência de Fibonnacci é: "
    enesimo_msg: .asciiz "Digite o valor de n para calcular o enesimo numero par: "
    enesimo_resultado: .asciiz "O enesimo numero par e: "

.text
#área pra instruções do programa.

.globl main #ponto de entrada para o prgorama.

main: #termo utilizado para indiciar o menu preincipal.
    # exibir o menu de opções
    li $v0, 4           #atribuir a mensagem de menu, atrávez do código de chamada 4 no registrador $v0 (syscall para impressão de string).
    la $a0, menu        #indicar o endereço do menu no registrador $a0.
    syscall             #imprimir o menu, dentro do registrador $a0.

    #ler a opção escolhida
    li $v0, 5            #atribuir um inteiro no registrador $v0 (syscall para ler um inteiro).
    syscall              #fazer a syscall para ler a opção escolhida.
    move $t0, $v0        #copiar e armazenar a opção escolhida no registrador $t0.

    #verificar a opção escolhida
    beq $t0, 1, escolha1   #Instrução de desvio condicional beq, ou seja, se a opção for 1, pular para o termo "escolha1"
    beq $t0, 2, escolha2   #Se a opção for 2, pular para o termo "escolha2"
    beq $t0, 3, escolha3   #Se a opção for 3, pular para o termo "escolha3"
    beq $t0, 4, sair     #se a opção for 4, pular para o termo "sair"

    #Opção inválida
    li $v0, 4            #atribuir a mensagem de menu, atrávez do código de chamada 4 no registrador $v0 (syscall para impressão de string
    la $a0, invalido     #indicar o endereço do menu no registrador $a0.
    syscall              # Fazer a syscall para imprimir a mensagem de opção inválida

    #Voltar ao início do programa
    j main


escolha1: #termo utilizado para indicar o inicio do código da escolha1
   # Exibir mensagem para digitar a temperatura em Fahrenheit
    li $v0, 4            # Carregar o valor 4 no registrador $v0 (syscall para impressão de string)
    la $a0, fahrenheit_msg  # Carregar o endereço da mensagem de entrada em Fahrenheit no registrador $a0
    syscall              # Fazer a syscall para imprimir a mensagem

    # Ler a temperatura em Fahrenheit
    li $v0, 6            # ** Carregar o valor 6 no registrador $v0 (syscall para ler um float) **
    syscall              # Fazer a syscall para ler a temperatura
    mov.s $f12, $f0        # Armazenar a temperatura em Fahrenheit no registrador $f12
    
    #exibir mensagem com o resultado
    li $v0, 4            # Carregar o valor 4 no registrador $v0 (syscall para impressão de string)
    la $a0, fahrenheit_resultado   # Carregar o endereço da mensagem de resultado em Celsius no registrador $a0
    syscall              # Fazer a syscall para imprimir a mensagem
    
    # Converter de Fahrenheit para Celsius 
    l.s $f0, Float32
    sub.s $f2, $f12, $f0    # Subtrair 32 para obter a diferença em relação ao ponto de congelamento da água **
    
    l.s $f3, Float5           # Carregar o valor 5 no registrador $t2 **
    mul.s $f4, $f2, $f3        # Multiplicar a diferença por 5

    l.s $f5, Float9            # Carregar o valor 9 no registrador $t2
    div.s $f6, $f4, $f5         # Dividir o resultado por 9

    # Exibir o resultado em Celsius com até 3 casas decimais
    li $v0, 2            # Carregar o valor 2 no registrador $v0 (syscall para impressão de ponto flutuante)
    mov.s $f12, $f6      # Mover o resultado em ponto flutuante para $f12
    li $a1, 3		# Carregar o valor 3 no registrador $a1 (número de casas decimais)
    syscall              # Fazer a syscall para imprimir o resultado com casas decimais
    #pular linha para reiniciar o menu
    li $v0, 4            # Carregar o valor 4 no registrador $v0 (syscall para impressão de string)
    la $a0, nova_linha      # Carregar o endereço da string de nova linha no registrador $a0
    syscall              # Fazer a syscall para imprimir a nova linha
    j main              #Voltar ao início do programa


escolha2: #termo utilizado para indicar o inicio do código da escolha2
    # Exibir o prompt para digitar o valor de n para calcular o enésimo termo
    li $v0, 4    # Carregar o valor 4 no registrador $v0 (syscall para impressão de string)
    la $a0, fibonnacci_msg   # Carregar o endereço da mensagem de entrada para o cálculo do enésimo termo no registrador $a0
    syscall 

    # Ler o valor de n digitado pelo usuário
    li $v0, 5      # Carregar o valor 5 no registrador $v0 (syscall para ler um inteiro)
    syscall
    move $a0, $v0   # Armazenar o valor de n em $a0
    
    # Chamando a função fibonacci
    jal fibonacci     # Fazer uma chamada de função para a função fibonacci
    move $a1, $v0 # save return value to a1

    # Exibir a mensagem com o resultado
    li $v0, 4
    la $a0, fibonnacci_resultado
    syscall

    # Exibir o resultado
    li $v0, 1       # Carregar o valor 1 no registrador $v0 (syscall para imprimir um inteiro)
    move $a0, $a1   # Mover o valor do enésimo termo em $a1 para $a0
    syscall

    #pular linha para reiniciar o menu
    li $v0, 4            # Carregar o valor 4 no registrador $v0 (syscall para impressão de string)
    la $a0, nova_linha      # Carregar o endereço da string de nova linha no registrador $a0
    syscall              # Fazer a syscall para imprimir a nova linha
    j main              #Voltar ao início do programa

    ## Função fibonacci
    fibonacci:
    addi $sp, $sp, -12   # Alocar espaço na pilha para salvar registros
    sw $ra, 8($sp)       # Salvar o endereço de retorno na pilha
    sw $s0, 4($sp)      # Salvar o registrador $s0 na pilha
    sw $s1, 0($sp)    # Salvar o registrador $s1 na pilha
    move $s0, $a0     # Mover o valor de n para o registrador $s0
    li $v0, 1     # Definir o valor de retorno para a condição de terminação
    ble $s0, 0x2, fibonacciSaida   # Verificar a condição de terminação
    addi $a0, $s0, -1 # Definir os argumentos para a chamada recursiva para fibonacci(n-1)
    jal fibonacci     # Chamada recursiva para fibonacci(n-1)
    move $s1, $v0    # Armazenar o resultado de f(n-1) em $s1
    addi $a0, $s0, -2    # Definir os argumentos para a chamada recursiva para fibonacci(n-2)
    jal fibonacci        # Chamada recursiva para fibonacci(n-2)
    add $v0, $s1, $v0   # Adicionar o resultado de f(n-1) a ele
    
    fibonacciSaida:
    lw $ra, 8($sp)   # Carregar o valor de retorno (endereço de retorno) da pilha para o registrador $ra
    lw $s0, 4($sp)   # Carregar o valor de $s0 da pilha para o registrador $s0
    lw $s1, 0($sp)   # Carregar o valor de $s1 da pilha para o registrador $s1
    addi $sp, $sp, 12   # Liberar o espaço da pilha reservado para a função
    jr $ra     # Saltar para o endereço de retorno armazenado em $ra para retornar à função chamadora

    
escolha3: #termo utilizado para indicar o inicio do código da escolha3
    li $v0, 4            # Carregar o valor 4 no registrador $v0 (syscall para impressão de string)
    la $a0, enesimo_msg  # Carregar o endereço da mensagem de entrada em Fahrenheit no registrador $a0
    syscall              # Fazer a syscall para imprimir a mensagem
    
    # Ler a temperatura em Fahrenheit
    li $v0, 5            # ** Carregar o valor 5 no registrador $v0 (syscall para ler um inteirot) **
    syscall              # Fazer a syscall para ler a temperatura
    move $t0, $v0        # Armazenar a temperatura em Fahrenheit no registrador $f12
    
    # Calcular o enésimo número par
    li $t1, 0    # Inicializar o contador
    li $t2, 0    # Inicializar o enésimo número par
    
    enesimoParLoop:
        # Verificar se o contador atingiu o valor de n
        beq $t1, $t0, enesimoParSaida
        
        # Incrementar o contador e o enésimo número par
        addi $t1, $t1, 1    # Incrementar o contador
        addi $t2, $t2, 2    # Incrementar o enésimo número par
        
        j enesimoParLoop    # Saltar para enesimoParLoop
    
    enesimoParSaida:
        # Exibir o enésimo número par
        li $v0, 4         # Carregar o valor 4 no registrador $v0 (syscall para impressão de string)
        la $a0, enesimo_resultado       # Carregar o endereço da mensagem de resultado do enésimo número par no registrador $a0
        syscall
        
        move $a0, $t2           # Mover o enésimo número par em $t2 para $a0
        li $v0, 1               # Carregar o valor 1 no registrador $v0 (syscall para imprimir um inteiro)
        syscall
        
        #pular linha para reiniciar o menu
    	li $v0, 4            # Carregar o valor 4 no registrador $v0 (syscall para impressão de string)
    	la $a0, nova_linha      # Carregar o endereço da string de nova linha no registrador $a0
    	syscall              # Fazer a syscall para imprimir a nova linha
        
    	j main              #Voltar ao início do programa


sair:#termo utilizado para indicar o código de saida.
    #Encerrar o programa
    li $v0, 10           #atribuir o comando 10 no registrador $v0 (syscall para encerrar o programa)
    syscall              #Fazer a syscall para encerrar o programa
    
    
    
