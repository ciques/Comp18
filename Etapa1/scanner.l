%{
	/*
		Compiladores - Prof. Marcelo Johann

		Gustavo Rosa
		Rafael Allegretti
	*/

	#include "hash.c"
	#include "tokens.h"
	int lineNumber = 1;
	int running = 1;

	int getLineNumber();
	int isRunning();
	void initMe();
%}

%x COMMENT

%%
	/* PALAVRAS RESERVADAS DA LINGUAGEM */
	
char				{ return KW_CHAR; }
int				{ return KW_INT; }
float				{ return KW_FLOAT; }
if				{ return KW_IF; }
then				{ return KW_THEN; }
else				{ return KW_ELSE; }
for				{ return KW_FOR; }
while				{ return KW_WHILE; }
return				{ return KW_RETURN; }
print				{ return KW_PRINT; }
read				{ return KW_READ; }

	/* LITEIRAS E IDENTIFICADORES */

[a-zA-Z_][a-zA-Z_0-9_]*		{ hashInsert(TK_IDENTIFIER, yytext); return TK_IDENTIFIER; }
[0-9]+				{ hashInsert(LIT_INTEGER, yytext); return LIT_INTEGER; }
\'.\' 				{ hashInsert(LIT_CHAR, yytext); return LIT_CHAR; }
\"([^\"\\\n]|\\.)*\" 		{ hashInsert(LIT_STRING, yytext); return LIT_STRING; }
[0-9]+\.[0-9]+			{ hashInsert(LIT_REAL, yytext); return LIT_REAL; }

	/* CARACTERS ESPECIAIS */

[-,;:()\[\]{}*/+<>=!&#] 	{ return yytext[0]; }
	
	/* COMENTÁRIO DE UMA LINHA */

"//".*				{ }

	/* COMMENTÁRIO DE VÁRIAS LINHAS */

"/*" 				{ BEGIN(COMMENT); }
<COMMENT>"\n" 			{ lineNumber++; }
<COMMENT>"*/"			{ BEGIN(INITIAL); }
<COMMENT>. { }

	/* OPERADORES COMPOSTOS */

\<=				{ return OPERATOR_LE; }
>=				{ return OPERATOR_GE; }
==				{ return OPERATOR_EQ; }
!=				{ return OPERATOR_NE; }
&&				{ return OPERATOR_AND; }
\|\| 				{ return OPERATOR_OR; } 

	/* NOVA LINHA E TAB */
\n 				{ lineNumber++; }
[ \t] 				{ }

	/* TOKEN ERROR */
.				{ return TOKEN_ERROR; }

%%

int yywrap()
{
	running = 0;
	return 1;
}

void initMe()
{
	running = 1;
	lineNumber = 1;
	hashInit();
}

int getLineNumber() 
{
	return lineNumber;
}

int isRunning() 
{
	return running;
}

#include "main.c"
