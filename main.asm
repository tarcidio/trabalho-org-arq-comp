#TRABALHO DE ORGANIZAÇÃO E ARQUITETURA DE COMPUTADORES
#UNIVERSIDADE DE SÃO PAULO - SÃO CARLOS
#INSTITUO DE CIÊNCIAS MATEMÁTICAS E DE COMPUTAÇÃO (ICMC)
#MEMBROS:
#TARCÍDIO ANTÔNIO JÚNIOR - 10748347

#Resumo do Programa: implementação, em Assembly RISC-V, de uma lista ligada. Ela armazenará
#duas informações: um ID (inteiro - 4 bytes) e uma string de tamanho fixo de 28 caracteres (28 bytes).

	.data	
SYS:			
			.eqv SYS_PRINT_INT, 1
			.eqv SYS_PRINT_STRING, 4
			.eqv SYS_READ_INT, 5
			.eqv SYS_READ_STRING, 8
			.eqv SYS_SBRK, 9 		#Alocacao na heap da memória
			.eqv SYS_EXIT, 93
STRUCT:			.eqv SIZE_ELEM, 36 		#Tamanho da lista será de 36 bytes:
			.eqv SIZE_ID_ELEM, 4		#4 bytes: ID
			.eqv SIZE_STRING_ELEM, 28	#28 bytes: string de tamanho fixo
			.eqv SIZE_ID_STRING, 32
			.eqv SIZE_POINTER, 4		#4 bytes: valor do endereço do próximo elemento
string_criacao_lista:	.asciz "Digite a quantidade de elementos da lista: "

string_leitura1:	.asciz "Digite o elemento número "
string_leitura2:	.asciz " da lista\n"
string_leitura_id:	.asciz "ID: "
string_leitura_str:	.asciz "String: "

string_percorre:	.asciz "Vamos percorrer a lista em ordem de ligação: \n"
string_percorre_id:	.asciz "ID: "
string_percorre_str:	.asciz " | String: "

string_final:		.asciz "Programa executado. Encerrando."

	.text
	.globl main

main:
	#Imprimindo texto para usuário: print("Digite a quantidade de elementos da lista")
	addi a7, zero, SYS_PRINT_STRING #a7 = SYS_PRINT_STRING
	la a0, string_criacao_lista 	#a0 = endereco(string_criacao_lista)
	ecall
	
	#Lendo quantidade de elementos
	addi a7, zero, SYS_READ_INT	#a7 = SYS_READ_INT
	ecall				#a0 = entrada inteira
	add s0, zero, a0		#s0 = a0: salvando o número de elementos da lista
	
	#s1: armazenará o endereço do primeiro componente do primeiro elemento da lista 
	addi s1, zero, -1		#s1 = -1: determinando s1 como ponteiro vazio
	#s2: armazenará o endereço do último componente do último elemento da lista
	addi s2, zero, -1		#s2 = -1: determinando s2 como ponteiro vazio
	#Lendo os elementos da lista
	add t0, zero, zero		#t0 = 0: registrador auxiliar para o while
while_leitura:
	beq t0, s0, fim_leitura		#enquanto t0 != s0 faça:
	
	#Alocando dinamicamente o próximo elemento
	addi a7, zero, SYS_SBRK		#a7 = SYS_SBRK
	addi a0, zero, SIZE_ELEM	#a0 = SIZE_ELEM
	ecall				#a0 = endereco(bloco) = endereco(primeiro componente do bloco)
	add t1, zero, a0		#t1 = a0: salvando o ponteiro do elemento
	add t2, zero, a0		#t2 = a0: salvando o ponteiro para PERCORRER o elemento
	
	#Imprimindo texto para o usuário: print("Digite o elemento {t0 + 1} da lista")
	#print(string_leitura1)
	addi a7, zero, SYS_PRINT_STRING #a7 = SYS_PRINT_STRING
	la a0, string_leitura1		#a0 = endereco(string_leitura1)
	ecall
	#print(t0 + 1)
	addi a7, zero, SYS_PRINT_INT 	#a7 = SYS_PRINT_STRING
	add a0, zero, t0		#a0 = t0
	addi a0, a0, 1			#a0 = a0 + 1 = t0 + 1
	ecall
	#print(string_leitura2)
	addi a7, zero, SYS_PRINT_STRING #a7 = SYS_PRINT_STRING
	la a0, string_leitura2		#a0 = endereco(string_leitura2)
	ecall
	
	#Leitura do ID
	#Imprimindo texto para o usuário: print("ID: ")
	#print(string_leitura_id)
	addi a7, zero, SYS_PRINT_STRING #a7 = SYS_PRINT_STRING
	la a0, string_leitura_id	#a0 = endereco(string_leitura_id)
	ecall
	#Lendo o ID
	addi a7, zero, SYS_READ_INT	#a7 = SYS_READ_INT
	ecall				#a0 = ID
	#Salvando ID
	sw a0, (t2)			#elemento[t2] = a0
	addi t2, t2, SIZE_ID_ELEM	#t2 += SIZE_ID_ELEM
		
	#Leitura da String
	#Imprimindo texto para o usuário: print("String: ")
	#print(string_leitura_id)
	addi a7, zero, SYS_PRINT_STRING #a7 = SYS_PRINT_STRING
	la a0, string_leitura_str	#a0 = endereco(string_leitura_str)
	ecall
	#Lendo a string
	addi a7, zero, SYS_READ_STRING	#a7 = SYS_READ_STRING
	#la a0, buffer
	add a0, zero, t2
	addi a1, zero, SIZE_STRING_ELEM	#a1 = SIZE_STRING_ELEM
	ecall				#elemento[t2] = string[0]
	
	#Determinando ponteiro nulo
	addi t3, zero, -1		#t3 = -1
	#Salvando ponteiro
	addi t2, t1, SIZE_ID_STRING	#t2 = elemento[SIZE_ID_STRING]
	sw t3, (t2)			#elemento[t2] = t3

	#Concatenando elementos
	#s1: armazenará o endereço do primeiro componente do primeiro elemento da lista 
	#s2: armazenará o endereço do último componente do último elemento da lista
if_concatenando:			#Se esse é o primeiro elemento da lista
	addi t6, zero, -1		#t6 = -1 (apenas como auxiliar)
	bne s1, t6, else_concatenando	#se s1 == -1
	add s1, zero, t1		#s1 = t1
	addi s2, t1, SIZE_ID_STRING	#s2 = elemento[SIZE_ID+STRING]
	j fim_if_concatenando
else_concatenando:			#Se esse não é o primeiro elemento da lista
	sw t1, (s2)			#elemento[s2] = t1
	add s2, zero, t2		#s2 = t2
fim_if_concatenando:
	addi t0, t0, 1			#t0 ++
	j while_leitura
	
fim_leitura:
	
percorre_elementos:
	#Percorrendo lista ligada
	add t0, zero, s1		#t0 = s1: copia do ponteiro do início da lista
	addi t6, zero, -1		#t6 = -1: registrador auxiliar
	#Imprimindo texto para o usuário: print("Vamos percorrer a lista: ")
	#print(string_percorre)
	addi a7, zero, SYS_PRINT_STRING #a7 = SYS_PRINT_STRING
	la a0, string_percorre		#a0 = endereco(string_percorre)
	ecall
while_percorre:	
	beq t0, t6, fim_while_percorre	#enquanto t0 != -1, faça:
	add t1, zero, t0		#t1 = t0: salvar para garantir depois que vamos acessar corretamente o ponteiro
	
	#Imprimindo texto para o usuário: print("ID: {ID} | String: {string}")
	#print(string_percorre_id)
	addi a7, zero, SYS_PRINT_STRING #a7 = SYS_PRINT_STRING
	la a0, string_percorre_id	#a0 = endereco(string_percorre_id)
	ecall
	#Leitura do ID
	lw t2, (t0)			#t2 = elemento[0]
	addi t0, t0, SIZE_ID_ELEM	#t0 += SIZE_ID
	#print(ID)
	addi a7, zero, SYS_PRINT_INT 	#a7 = SYS_PRINT_STRING
	add a0, zero, t2		#a0 = t2 (ID)
	ecall
	#print(string_percorre_str)
	addi a7, zero, SYS_PRINT_STRING #a7 = SYS_PRINT_STRING
	la a0, string_percorre_str	#a0 = endereco(string_percorre_str)
	ecall
	#Printando string
	addi a7, zero, SYS_PRINT_STRING
	add a0, zero, t0
	ecall
	
	#Pega o valor do próximo elemento
	addi t0, t1, SIZE_ID_STRING	#t0 = endereco(elemento[SIZE_ID_STRING])
	lw t0, (t0)			#t0 = elemento[SIZE_ID_STRING]
	j while_percorre
fim_while_percorre:
	#Imprimindo texto para usuário: print("Programa executado. Encerrando.")
	addi a7, zero, SYS_PRINT_STRING #a7 = SYS_PRINT_STRING
	la a0, string_final 		#a0 = endereco(string_criacao_lista)
	ecall
	
	#Encerrando o programa
	addi a0, zero, 0		#a0 = 0 (valor para retornar)
	addi a7, zero, SYS_EXIT		#a7 = SYS_EXIT
	ecall				#encerrando programa
