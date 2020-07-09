   %{
void yyerror (char *s);
int yylex();
#include <stdio.h>     
#include <stdlib.h>
#include <ctype.h>
extern int yylineno;
extern char* yytext;
%}

%union {char id;}         
%start programa
%token tipo
%token t_main
%token t_retorno
%token identificador
%token t_void
%token numeroEntero
%token parentesisa
%token parentesisc
%token corchetea
%token corchetec
%token t_puntocoma
%token t_igual
%token numeroDecimal
%token cadena
%token caracter
%token operador
%token t_if
%token t_else
%token t_while
%token t_log
%token t_print
%token t_scan
%token t_coma
%token toScan


%%


programa    : tipoRetorno funcion parentesisa parametros parentesisc corchetea instrucciones  corchetec	{printf("Analisis concluido sin errores");}
			| tipoRetorno funcion parentesisa parametros parentesisc corchetea instrucciones  corchetec programa
        ;

tipoRetorno:	tipo
			| 	t_void
			;

funcion : t_main
		| identificador
		;

parametros : t_void
			| tipo identificador 
			;

parametroenv : 
				| identificador
			;

instrucciones : declaracion
				| asignacion
				| econdicion
				| erepeticion
				|salida
				|entrada
				|retorno
				;

declaracion : tipo identificador t_puntocoma
			| tipo identificador t_puntocoma instrucciones
			;
	
asignacion : identificador t_igual valor t_puntocoma
			| identificador t_igual valor t_puntocoma instrucciones
			;

valor : numeroEntero
		| numeroDecimal
		| cadena
		| identificador
		| caracter
		| expresion
		| llamada
		;

expresion : valor operador valor
		;

llamada : identificador parentesisa parametroenv parentesisc
		;

econdicion : t_if parentesisa condicion parentesisc corchetea instrucciones corchetec
			| t_if parentesisa condicion parentesisc corchetea instrucciones corchetec instrucciones
			;
erepeticion : t_while parentesisa condicion parentesisc corchetea instrucciones corchetec
			| t_while parentesisa condicion parentesisc corchetea instrucciones corchetec instrucciones
			;
condicion : valor t_log valor
			| identificador
			;

salida : t_print parentesisa cadena parentesisc t_puntocoma
		|   t_print parentesisa cadena parentesisc t_puntocoma instrucciones
		|	t_print parentesisa cadena t_coma identificador parentesisc t_puntocoma  
		|	t_print parentesisa cadena t_coma identificador parentesisc t_puntocoma instrucciones 
		;

entrada : t_scan parentesisa cadena t_coma toScan identificador parentesisc t_puntocoma
		|	t_scan parentesisa cadena t_coma toScan identificador parentesisc t_puntocoma instrucciones 
		;

retorno : t_retorno valor t_puntocoma
		;


%%                     


int main (void) {
	
	

	return yyparse ( );
}

void yyerror (char *s) {//fprintf (stderr, "%s\n", s);
						printf("error: unexpected token in line %d near '%s'\n", yylineno, yytext);
} 

