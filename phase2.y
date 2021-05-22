%{ 
#include <stdio.h>
#include <stdlib.h>

extern FILE* yyin;
extern int yylineno;
extern char* yytext;
int yylex(void);
void yyerror(char *);
%} 
%token ID STRING_LITERAL INT_LITERAL DBL_LITERAL AND OR EQUAL NE LT GT INT DOUBLE IF READ PRINT WHILE START END
%right '='
%left OR
%left AND
%left EQUAL NE
%left '<' LT '>' GT
%left '+' '-'
%left '*' '/'
%right '!' 
%%
Program: START Statements END
;
Statements: Statements Statement
| Statement
;
Statement: Dec_stmt
| Assignment_stmt
| Print_stmt
| Read_stmt
| Condition_stmt
| While_stmt
;
Dec_stmt: Type ID
| Type ID','IDList
;
IDList: ID
| ID','IDList
;
Type: INT
| DOUBLE
;
Assignment_stmt: ID '=' Expression
;
Expression: exp EQUAL exp
| exp NE exp
| exp '<' exp
| exp LT exp
| exp '>' exp
| exp GT exp
| exp
;
exp: exp '+' exp
| exp '-' exp
| exp '*' exp
| exp '/' exp
| exp OR exp
| exp AND exp
| '!'exp
| Factor
;
Factor: '('exp')'
| INT_LITERAL
| DBL_LITERAL
| ID
;
Print_stmt: PRINT'('ID')'
|PRINT'('STRING_LITERAL')'
;
Read_stmt: ID '=' READ'('')'
;
Condition_stmt: IF'('Expression')''{'Statements'}'
;
While_stmt: WHILE'('Expression')''{'Statements'}'
;
%%
void yyerror(char* message)
{ printf("Syntax error at Line %d \n", yylineno); }


int main(int argc, char *argv[])
{ printf("Enter the expression: \n");
yyin= fopen(argv[1], "r");

if(yyparse() == 0)
printf("\nParsing complete \n");

else
printf("Error");

fclose(yyin);
return 0; }