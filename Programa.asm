.data
#Seção é usada para declarar e definir dados.
    menu: .asciiz "*****OPÇÕES******\n1. Converte: Fahrenheit - Celsius\n2. Fibonnnaci\n3. Enésimo Par\n4. Sair\n Escolha uma opção:" #mensagem(string) a ser exibida, insereida na "variavel menu".
    invalido: .asciiz "Opção inválida!\n" #menssagem a ser exibida caso nenhuma das 4 opções seja selecionada.

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

    # verificar a opção escolhida
    beq $t0, 1, escolha1   #Instrução de desvio condicional beq, ou seja, se a opção for 1, pular para o termo "escolha1"
    beq $t0, 2, escolha2   #Se a opção for 2, pular para o termo "escolha2"
    beq $t0, 3, escolha3   #Se a opção for 3, pular para o termo "escolha3"
    beq $t0, 4, sair     # e a opção for 4, pular para o termo "sair"

    # Opção inválida
    li $v0, 4            #atribuir a mensagem de menu, atrávez do código de chamada 4 no registrador $v0 (syscall para impressão de string
    la $a0, invalido     #indicar o endereço do menu no registrador $a0.
    syscall              # Fazer a syscall para imprimir a mensagem de opção inválida

    # Voltar ao início do programa
    j main

escolha1: #termo utilizado para indicar o inicio do código da escolha1
  
    # ...
    j main              # Voltar ao início do programa

escolha2:#termo utilizado para indicar o inicio do código da escolha2

    # ...
    j main              # Voltar ao início do programa

escolha3:#termo utilizado para indicar o inicio do código da escolha3
    
    # ...
    j main              # Voltar ao início do programa

sair:#termo utilizado para indicar o código de saida.
    # Encerrar o programa
    li $v0, 10           # atribuir o comando 10 no registrador $v0 (syscall para encerrar o programa)
    syscall              # Fazer a syscall para encerrar o programa
