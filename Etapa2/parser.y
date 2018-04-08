%{
	/*
		Compiladores - Prof. Marcelo Johann

		Gustavo Rosa
		Rafael Allegretti
	*/

	#include <stdio.h>
	#include <stdlib.h>
	#include "hash.c"

	int getLineNumber();
	int yyerror();
	int yylex();
%}

/* PALAVRAS RESERVADAS */
%token KW_CHAR
%token KW_INT
%token KW_FLOAT
%token KW_IF
%token KW_THEN
%token KW_ELSE
%token KW_FOR
%token KW_WHILE
%token KW_RETURN
%token KW_PRINT
%token KW_READ
%token KW_TO

/* OPERADORES */
%token OPERATOR_LE
%token OPERATOR_GE
%token OPERATOR_EQ
%token OPERATOR_NE
%token OPERATOR_AND
%token OPERATOR_OR

/* SÍMBOLOS */
%token <symbol>TK_IDENTIFIER
%token <symbol>LIT_INTEGER
%token <symbol>LIT_CHAR
%token <symbol>LIT_STRING
%token <symbol>LIT_REAL

%token TOKEN_ERROR

%union
{
	HASH_NODE *symbol;
}

%%

/* PROGRAMA */
programa		: declaracao	
			| programa declaracao
			;

/* PODE SER FUNÇÃO OU DECLARAÇÃO DE VARIÁVEL */
declaracao 		: funcao 
			| global ';'
			;

global 			: variavel	
			| array 
			;

/* VARIÁVEIS SÃO DECLARADAS COMO TIPO NOME = VALOR */
variavel 		: tipo TK_IDENTIFIER '=' literal
			;

/* TIPOS POSSÍVEIS */
tipo 			: KW_CHAR 	
			| KW_INT  
			| KW_FLOAT  
			;

/* LITERAIS POSSÍVEIS */
literal			: LIT_INTEGER		
			| LIT_CHAR	
			| LIT_STRING	
			| LIT_REAL	
			;

/* ARRAYS SÃO DECLARADOS COMO TIPO NOME [TAMANHO] = , E PODE SER INICIALIZADO */
array 			: tipo TK_IDENTIFIER '[' LIT_INTEGER ']' '='
			| tipo TK_IDENTIFIER '[' LIT_INTEGER ']' '=' lista_literais 	
			;
			
/* LITERAL OU LITERAL + LISTA DE LITERAIS, PARA EXPANSÃO */
lista_literais 		: literal
			| literal lista_literais
			;

/* DECLARAÇÃO DE FUNÇÕES E SEUS ARGUMENTOS */
funcao	 		: tipo TK_IDENTIFIER '(' lista_argumentos ')' comando
			| tipo TK_IDENTIFIER '(' ')' comando
			;

lista_argumentos	: argumento
			| argumento ',' lista_argumentos
			;

/* ARGUMENTO É DECLARADO NA FORMA: TIPO NOME */
argumento 		: tipo TK_IDENTIFIER
			;

/* COMANDOS POSSÍVEIS */
comando			: comandos_controle_fluxo
			| bloco_comandos
			| atribuicao
			| read
			| print
			| return
			|
			;

/* UM BLOCO DE COMANDO PODE SER VÁZIO, OU SÓ CONTER ';' OU CONTER OUTROS COMANDOS */
bloco_comandos 		: '{' '}'
			| '{' lista_comandos '}'
			;

/* UMA LISTA DE COMANDOS É UM COMANDO SEGUIDO DE 0 OU MAIS COMANDOS */
lista_comandos 		: comando
			| comando ';' lista_comandos
			;

/* DUAS FORMAS POSSÍVEIS DE ATRIBUIÇÃO CONFORME ESPECIFICAÇÃO */
atribuicao 		: TK_IDENTIFIER '=' expressao	
			| TK_IDENTIFIER '#' expressao '=' expressao
			;

/* TRÊS INSTRUÇÕES PARA COMANDOS DE CONTROLE DE FLUXO */
comandos_controle_fluxo : comando_for
			| comando_if
			| comando_while
			;

/* FOR NOME '=' EXPRESSAO TO EXPRESSAO COMANDO */
comando_for 		: KW_FOR '(' TK_IDENTIFIER '=' expressao KW_TO expressao ')' comando
			;

/* IF THEN & IF THEN ELSE */			
comando_if 		: KW_IF '(' expressao ')' KW_THEN comando 
			| KW_IF '(' expressao ')' KW_THEN comando KW_ELSE comando
			;

/* WHILE EXPRESSAO COMANDO */
comando_while 		: KW_WHILE '(' expressao ')' comando
			;

/* READ NOME */			
read 			: KW_READ TK_IDENTIFIER
			;

/* PRINT - PODE IMPRIMIR QUALQUER EXPRESSAO */
print 			: KW_PRINT lista_print 
			;

lista_print 		: lista_print expressao
			| expressao
			;

/* RETORNA EXPRESSAO */
return 			: KW_RETURN expressao
			;

/* TIPOS DE EXPRESSAO POSSÍVEIS */
expressao 		: TK_IDENTIFIER
			| TK_IDENTIFIER '[' expressao ']'
			| TK_IDENTIFIER '(' ')'
			| TK_IDENTIFIER '(' lista_expressoes ')'
			| '&' TK_IDENTIFIER
			| '#' TK_IDENTIFIER
			| literal
			| '(' expressao ')'
			| expressao OPERATOR_LE expressao
			| expressao OPERATOR_GE expressao
			| expressao OPERATOR_EQ expressao
			| expressao OPERATOR_NE expressao
			| expressao OPERATOR_AND expressao
			| expressao OPERATOR_OR expressao
			| expressao '<' expressao
			| expressao '>' expressao
			| expressao '!' expressao
			| expressao '-' expressao
			| expressao '+' expressao
			| expressao '*' expressao
			| expressao '/' expressao
			;

lista_expressoes 	: lista_expressoes ',' expressao
			| expressao
			;


%%

int yyerror() 
{	 
	fprintf(stderr, "Erro de sintaxe na linha %d.\n", getLineNumber());
	exit(3);
}
