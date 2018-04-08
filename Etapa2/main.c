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
	
	yyparse();
        fprintf(stderr, "Sucesso!\n");
	fprintf(stderr, "\n----------------------- TABELA HASH -----------------------\n");
	hashPrint();
	exit(0);
}