%{
#include "analisis.tab.h"
void yyerror (char *s);
int yylex();
%}
%option nounput yylineno
%%

"&"					return toScan;
"int"				return tipo;
"printf"			return t_print;
"scanf"				return t_scan;
"float"				return tipo;
"char"				return tipo;
"main"				return t_main;
"return"			return t_retorno;
"void"				return t_void;
"if"				return t_if;
"else"				return t_else;
"while"				return t_while;
[a-zA-Z][_a-zA-Z0-9]*	return identificador;
[0-9][0-9]*			return numeroEntero;
[0-9]+"."[0-9]+	return numeroDecimal;
\"[^"]+\"    	return cadena;
"("				return parentesisa;
")"				return parentesisc;
"{"				return corchetea;
"}"				return corchetec;
";"				return t_puntocoma;
","				return t_coma;
"=="            return t_log;
"!="            return t_log;
">="            return t_log;
"<="            return t_log;
">"            return t_log;
"<"            return t_log;
"="				return t_igual;
"'"[a-zA-Z]"'"  return caracter;
[-+/*]         return operador;

%%
int yywrap (void) {return 1;}

