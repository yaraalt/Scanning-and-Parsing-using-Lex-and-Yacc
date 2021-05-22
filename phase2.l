%{ 
#include "phase2.tab.h"
#include <stdio.h>
%} 

/* regular definitions */ 
delim	[ \t] 
ws	{delim}+ 
identifier	[A-Z][A-Za-z0-9_]*[A-Z]
and	"&&"
or	"||"
equal	"=="
not_equal	"<>"
less_than	"<="
greater_than	">="
integer	"int"
double	"double"
if	"if"
read	"read"
print	"print"
while	"while"
start	"START"
end	"END"
comment	@([^@])*@	
string_literal	(\")([^\"])*(\")
int_literal	[+|-]?[0-9]+
double_literal	[+|-]?[0-9]+\.[0-9]+
%% 
"+"	{return( '+' );}
"-"	{return( '-' );}
"*"	{return( '*' );}
"/"	{return( '/' );}
{and}	{return AND;}
{or}	{return OR;}
"!"	{return( '!' );}
{equal}	{return EQUAL;}
{not_equal}	{return NE;}
"<"	{return( '<' );}
{less_than}	{return LT;}
">"	{return( '>' );}
{greater_than}	{return GT;}
"="	{return( '=' );}
"("	{return( '(' );}
")"	{return( ')' );}
"{"	{return( '{' );}
"}"	{return( '}' );}
","	{return( ',' );}
{integer}	{return INT;}
{double}	{return DOUBLE;}
{if}	{return IF;}
{read}	{return READ;}
{print}	{return PRINT;}
{while}	{return WHILE;}
{start}	{return START;}
{end}	{return END;}
{identifier}	{return ID;}
{comment}	{for (int i= 0; i < strlen(yytext); i++)
		if(yytext[i] == '\n')
		yylineno++; }
{string_literal}	{for (int i= 0; i < strlen(yytext); i++)
			if(yytext[i] == '\n')
			yylineno++; 
			return STRING_LITERAL;}
{int_literal}	{return INT_LITERAL;}
{double_literal}	{return DBL_LITERAL;}
{ws}	{;} 
[\n]	{yylineno++;}
.	{return 1;}
%%
int yywrap(void)
{ return 1; }
