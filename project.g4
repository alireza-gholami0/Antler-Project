grammar project;

start: including* class* ;
including:  DATANAME ( ',' DATANAME )* '=' impor SEMICOLON;
impor: ( 'from'  DATANAME  )? ( 'require' | '=>')  DATANAME  (',' ( 'from'  DATANAME  )? ( 'require' | '=>') '<' DATANAME '>')* ;
//.................................................................................//
class: 'class' DATANAME '(' DATANAME? ')' (implements)? 'begin' code* 'end';
extend:  '(' DATANAME ')';
implements:  'implements' DATANAME ( ',' DATANAME )*;
//.................................................................................//
obj_define: ACCESS? 'cost'? DATANAME DATANAME obj1?  SEMICOLON;
obj1: ('=' 'Null') | ('=' DATANAME '(' VALUE? (',' VALUE)* ')' );
//.................................................................................//
constructor: DATANAME '(' DATATYPE DATANAME (',' DATATYPE DATANAME)* ')' 'begin' constructor_body* 'end';
constructor_body: 'this.' DATANAME '=' DATANAME SEMICOLON;
//.................................................................................//
for: 'for' '(' for_input ')' 'begin' code* 'end' ;
for_input: (DATATYPE? DATANAME '=' INT SEMICOLON  expression (('and' | 'or') expression)* SEMICOLON expression? ) | (DATANAME 'in' DATANAME ) ;
//.................................................................................//
while: 'while' '(' expression ')' 'begin' code* 'end';
do_while: 'do' 'begin' code* 'end' while;
//.................................................................................//
if : (if_input) ( (if_input) | (else_if) )* (else)? ;
if_input : 'if' '(' expression ')' 'begin' code* 'end' ;
else_if : 'else' if_input ;
else : 'else' 'begin' code* 'end' ;
//.................................................................................//
varialble_define: (ACCESS)? ('cost')? variable | array;
variable: DATATYPE DATANAME ('=' VALUE)? (',' DATANAME ('=' VALUE)?)* SEMICOLON ;
array: DATATYPE DATANAME '[]' ('=' '[' VALUE (',' VALUE)* ']')? | ('=' 'new' DATATYPE '[' INT  ']')? SEMICOLON ;
//.................................................................................//
function:DATATYPE DATANAME '(' (DATATYPE DATANAME (',' DATATYPE DATANAME)*)? ')' 'begin' code* 'return' expression 'end';
//.................................................................................//
call_func: (ACCESS? DATATYPE? DATANAME '=')? DATANAME ('.' DATANAME)* '(' input_func? ')' SEMICOLON ;
input_func: (VALUE | DATANAME)? (',' (VALUE | DATANAME))*  ;
//.................................................................................//
switch: 'switch' expression 'begin' ('case' VALUE ':' code* 'break')+ ('default' code* 'break')? 'end' ;
//.................................................................................//
exception: 'try' 'begin' code* 'end' catch0*;
catch0: 'catch' '(' DATANAME (',' DATANAME)* ')' 'begin' code* 'end' ;
//.................................................................................//
code: constructor|for | while | do_while | if | switch | expression SEMICOLON | varialble_define | obj_define | exception | call_func SEMICOLON ;
//.................................................................................//
expression: '(' expression ')'
| expression '**' expression
| '~' expression
| expression ('-' | '+') expression
| expression ('++' | '--')
| expression ('>>' | '<<') expression
| expression ('&' | '|' '^') expression
| expression ('==' | '!=' | '<>') expression
| expression ('<' | '>' | '<=' | '>=') expression
| expression ('not' | 'and' | 'or' | '||' | '&&') expression
| expression ('=' | '##=') expression
| expression ('+=' | '-=' | '*=' | '/=') expression
| DATANAME
| VALUE ;
//.................................................................................//
SEMICOLON:          ';' ;
WS: ('\t' | '\r' | '\n' | ' ' )* -> skip;
LETTER: [a-zA-Z];
VALUE: INT | FLOAT | DOUBLE | STRING | BOOL | CHAR | 'Null' ;
INT: ('-' | '+')? (DIGIT | ([1,9]DIGIT+));
DIGIT:  [0-9] ;
DATATYPE:           ('int' | 'bool' | 'double' | 'string' | 'char' ) ;
ACCESS: ('public' | 'private' );
DATANAME:           (LETTER | '$') (LETTER | DIGIT | '_')+ ;
FLOAT: ('-' | '+')? (DIGIT* '.' DIGIT+);
CHAR:               ([a-zA-Z] | '_' | '$') ;
DOUBLE: FLOAT;
BOOL: 'true' | 'false' ;
STRING: '"' (LETTER | DIGIT | ' ')* '"';

