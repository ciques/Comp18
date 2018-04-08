/*
	Compiladores - Prof. Marcelo Johann

	Gustavo Rosa
	Rafael Allegretti
*/

int main(int argc, char *argv[]) 
{
	yyin = fopen(argv[1], "r");
	if (argc < 2)
	{
		fprintf(stderr, "Número de argumentos inválido!\n");
		exit(1);
	}

	if (!yyin)
	{
		fprintf(stderr, "Não foi possível abrir o arquivo!\n");
		exit(2);
	}
	

	int token = 0;
	initMe();
	
	while(isRunning()) 
	{	
		if(!isRunning())
		{
			break;
		}
	
		token = yylex();

		switch(token)
		{
			// PALAVRAS RESERVADAS
			case KW_CHAR:
				fprintf(stderr, "Achei um KW_CHAR - linha %i\n", getLineNumber());
				break;
			case KW_INT:
				fprintf(stderr, "Achei um KW_INT - linha %i\n", getLineNumber());
				break;
			case KW_FLOAT:
				fprintf(stderr, "Achei um KW_FLOAT - linha %i\n", getLineNumber());
				break;
			case KW_IF:
				fprintf(stderr, "Achei um KW_IF - linha %i\n", getLineNumber());
				break;
			case KW_THEN:
				fprintf(stderr, "Achei um KW_THEN - linha %i\n", getLineNumber());
				break;
			case KW_ELSE:
				fprintf(stderr, "Achei um KW_ELSE - linha %i\n", getLineNumber());
				break;
			case KW_WHILE:
				fprintf(stderr, "Achei um KW_WHILE - linha %i\n", getLineNumber());
            			break;
			case KW_FOR:
				fprintf(stderr, "Achei um KW_FOR - linha %i\n", getLineNumber());
				break;
			case KW_READ:
				fprintf(stderr, "Achei um KW_READ - linha %i\n", getLineNumber());
				break;
			case KW_PRINT:
				fprintf(stderr, "Achei um KW_PRINT - linha %i\n", getLineNumber());
				break;
			case KW_RETURN:
				fprintf(stderr, "Achei um KW_RETURN - linha %i\n", getLineNumber());
				break;
				
			// OPERADORES COMPOSTOS
			case OPERATOR_LE:
				fprintf(stderr, "Achei um OPERATOR_LE - linha %i\n", getLineNumber());
				break;
			case OPERATOR_GE:
				fprintf(stderr, "Achei um OPERATOR_GE - linha %i\n", getLineNumber());
				break;
			case OPERATOR_EQ:
				fprintf(stderr, "Achei um OPERATOR_EQ - linha %i\n", getLineNumber());
				break;
			case OPERATOR_NE:
				fprintf(stderr, "Achei um OPERATOR_NE - linha %i\n", getLineNumber());
				break;
			case OPERATOR_AND:
				fprintf(stderr, "Achei um OPERATOR_AND - linha %i\n", getLineNumber());
				break;
			case OPERATOR_OR:
				fprintf(stderr, "Achei um OPERATOR_OR - linha %i\n", getLineNumber());
				break;

			// IDENTIFICADOR
			case TK_IDENTIFIER:
				fprintf(stderr, "Achei um TK_IDENTIFIER - linha %i\n", getLineNumber());
				break;

			// LITERAIS
			case LIT_INTEGER:
				fprintf(stderr, "Achei um LIT_INTEGER - linha %i\n", getLineNumber());
				break;
			case LIT_REAL:
				fprintf(stderr, "Achei um LIT_REAL - linha %i\n", getLineNumber());
				break;
			case LIT_CHAR:
				fprintf(stderr, "Achei um LIT_CHAR - linha %i\n", getLineNumber());
				break;
			case LIT_STRING:
				fprintf(stderr, "Achei um LIT_STRING - linha %i\n", getLineNumber());
				break;
			
			// ERROR
			case TOKEN_ERROR:
				fprintf(stderr, "Achei um TOKEN_ERROR - linha %i\n", getLineNumber());
				break;
			default:
				fprintf(stderr, "Achei %c - line %i\n", token, getLineNumber());
				break;
		}
	}

	fprintf(stderr, "\n-------------------- TABELA HASH -------------------------\n");
	hashPrint();

	exit(0);
}
