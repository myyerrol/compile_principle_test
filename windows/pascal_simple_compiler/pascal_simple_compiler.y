%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "pascal_simple_compiler_lex.h"
#include "pascal_simple_compiler_yacc.h"
#include "pascal_handle_semantics.h"
#include "pascal_handle_symbol_table.h"
#include "pascal_handle_quaternion.h"
#include "pascal_handle_syntax_tree.h"
#include "pascal_debug_program.h"

#define YYERROR_VERBOSE

extern int g_quaternion_index;
extern int g_temp_count;

int yyerror(const char *string);
%}

%union {
    int                     type;
    char                    *string;
    struct Statement        *statement;
    struct WhileStatement   *while_statement;
    struct BoolExpression   *bool_expression;
    struct Expression       *expression;
    struct VariableList     *variable_list;
    struct Variable         *variable;
    struct Constant         *constant;
    struct RelationOperator *relation_operator;
}

%token <string> IDENTIFIER
%token <string> NUMBER_INTEGER
%token <string> NUMBER_REAL
%token          PROGRAM
%token          ERROR_STRING
%token          SEMICOLON
%token          COMMA
%token          COLON
%token          DOT
%token          VAR
%token          INTEGER
%token          REAL
%token          STATEMENT_BEGIN
%token          STATEMENT_END
%token          ASSIGN
%token          IF
%token          ELSE
%token          THEN
%token          WHILE
%token          DO
%token          ADD
%token          SUB
%token          MUL
%token          DIV
%token          LP
%token          RP
%token          AND
%token          OR
%token          NOT
%token          LT
%token          GT
%token          LE
%token          GE
%token          EQ
%token          NE

%left OR
%left AND
%nonassoc NOT
%nonassoc LT GT LE GE EQ NE
%left ADD SUB
%left MUL DIV
%nonassoc UMINUS

%type <statement>         ProgramDefinition
%type <statement>         SubProgram
%type <statement>         VariableDefinition
%type <statement>         CompoundStatement
%type <statement>         VariableDefinitionList
%type <statement>         VariableDefinitionStatement
%type <variable_list>     VariableList
%type <type>              Type
%type <statement>         StatementList
%type <statement>         StatementSemicoln
%type <statement>         Statement
%type <statement>         AssignmentStatement
%type <statement>         IfStatementElse
%type <statement>         IfBoolExpressionThen
%type <while_statement>   WhileBoolExpressionDo
%type <while_statement>   While
%type <bool_expression>   BoolExpressionAnd
%type <bool_expression>   BoolExpressionOR
%type <bool_expression>   BoolExpression
%type <expression>        Expression
%type <variable>          Variable
%type <constant>          Constant
%type <relation_operator> RelationOperator

%start ProgramDefinition

%%
ProgramDefinition
    : PROGRAM IDENTIFIER SEMICOLON SubProgram DOT {
        // struct SyntaxTreeNode **ast_program_node, **ast_identifier_node;
        // struct SyntaxTreeNode **ast_semicolon_node, **ast_dot_node;
        // ast_program_node = createSyntaxTreeNodePointer();
        // ast_identifier_node = createSyntaxTreeNodePointer();
        // ast_semicolon_node = createSyntaxTreeNodePointer();
        // ast_dot_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode(ast_program_node);
        // createSyntaxTreeNode(ast_identifier_node);
        // createSyntaxTreeNode(ast_semicolon_node);
        // createSyntaxTreeNode(ast_dot_node);
        // setSyntaxTreeNode(*ast_program_node, NODE_PROGRAM, "program");
        // setSyntaxTreeNode(*ast_identifier_node, NODE_IDENTIFIER, $2);
        // setSyntaxTreeNode(*ast_semicolon_node, NODE_SEMICOLON, ";");
        // setSyntaxTreeNode(*ast_dot_node, NODE_DOT, ".");

        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = 0;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_REDUCE, "/\\");
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_program_node);
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_identifier_node);
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_semicolon_node);
        // addSyntaxTreeSonNode(*($$->ast_node), *($4->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_dot_node);

        printInformation();
        printf("Pascal program is identified successfully!!!\n");
        deleteConstantNode();
        deleteVariableNode();
    }
SubProgram
    : VariableDefinition CompoundStatement {
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = 0;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_REDUCE, "/\\");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *($2->ast_node));
    }
VariableDefinition
    : VAR VariableDefinitionList SEMICOLON {
        // struct SyntaxTreeNode **ast_var_node, **ast_semicolon_node;
        // ast_var_node = createSyntaxTreeNodePointer();
        // ast_semicolon_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode(ast_var_node);
        // createSyntaxTreeNode(ast_semicolon_node);
        // setSyntaxTreeNode(*ast_var_node, NODE_VAR, "var");
        // setSyntaxTreeNode(*ast_semicolon_node, NODE_SEMICOLON, ";");

        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = 0;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_VAR_SEMICOLON, "var;");
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_var_node);
        // addSyntaxTreeSonNode(*($$->ast_node), *($2->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_semicolon_node);
    }
VariableDefinitionList
    : VariableDefinitionList SEMICOLON VariableDefinitionStatement {
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = 0;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_SEMICOLON, ";");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *($3->ast_node));
    }
    | VariableDefinitionStatement {
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = 0;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // $$->ast_node = $1->ast_node;
    }
VariableDefinitionStatement
    : VariableList COLON Type {
        char *type;
        // struct SyntaxTreeNode **ast_type_node;
        // ast_type_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode(ast_type_node);

        if ($3 == TYPE_INTEGER) {
            type = "integer";
        }
        else if ($3 ==  TYPE_REAL) {
            type = "real";
        }

        // setSyntaxTreeNode(*ast_type_node, NODE_TYPE, type);

        backpatchVariableNodeChain($1->chain, $3);
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = 0;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_COLON, ":");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_type_node);
        printDebugVariableInformation();
    }
Type
    : INTEGER {
        $$ = TYPE_INTEGER;
    }
    | REAL {
        $$ = TYPE_REAL;
    }
VariableList
    : VariableList COMMA Variable {
        if (getVariableNodeDefine($3->index_symbol) == TRUE) {
            if (judgeVariableNodeExist($3->name)) {
                printf("\nError, variable is defined rpeatedly!\n");
                exit(EXIT_FAILURE);
            }
        }
        else if (getVariableNodeDefine($3->index_symbol) == ERROR) {
            printf("\nError, there is not the variable!\n");
            exit(EXIT_FAILURE);
        }

        modifyVariableNodeDefine($3->index_symbol);

        $$ = ALLOCATE_STRUCT_MEMORY(VariableList);
        modifyVariableNodeChain($1->chain, $3->chain);
        $$->chain = $1->chain;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_COMMA, ",");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *($3->ast_node));
        printDebugVariableInformation();
    }
    | Variable {
        modifyVariableNodeDefine($1->index_symbol);
        $$ = ALLOCATE_STRUCT_MEMORY(VariableList);
        $$->chain = $1->chain;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // $$->ast_node = $1->ast_node;
        printDebugVariableInformation();
    }
StatementList
    : StatementSemicoln Statement {
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = $2->chain;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_STATEMENT_LIST,
        //                   "statement_list");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *($2->ast_node));
    }
    | Statement {
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = $1->chain;
        $$->ast_node = $1->ast_node;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_STATEMENT_LIST,
        //                   "statement_list");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
    }
StatementSemicoln
    : StatementList SEMICOLON {
        // struct SyntaxTreeNode **ast_semicolon_node;
        // ast_semicolon_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode(ast_semicolon_node);
        // setSyntaxTreeNode(*ast_semicolon_node, NODE_SEMICOLON, ";");

        backpatchQuaternionNodeChain($1->chain, g_quaternion_index);
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_STATEMENT_SEMICOLON,
        //                   "statement;");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_semicolon_node);
        printDebugQuaternionInformation();
        // printDebugAbstractSyntaxTreeInformation(*($$->ast_node));
    }
Statement
    : AssignmentStatement {
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = 0;
        $$->ast_node = $1->ast_node;
    }
    | IfStatementElse Statement {
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = mergeQuaternionNodeChain($1->chain, $2->chain);
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_STATEMENT, "statement");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *($2->ast_node));
        printDebugQuaternionInformation();
    }
    | IfBoolExpressionThen Statement {
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = mergeQuaternionNodeChain($1->chain, $2->chain);
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_STATEMENT, "statement");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *($2->ast_node));
        printDebugQuaternionInformation();
    }
    | WhileBoolExpressionDo Statement {
        backpatchQuaternionNodeChain($2->chain, $1->loop_start);
        generateQuaternionNode(0, 0, $1->loop_start, OPCODE_JMP);
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = $1->chain;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_STATEMENT, "statement");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *($2->ast_node));
        printDebugQuaternionInformation();
    }
    | CompoundStatement {
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = $1->chain;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_STATEMENT, "statement");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
    }
    | {
        printf("");
    }
CompoundStatement
    : STATEMENT_BEGIN StatementList STATEMENT_END {
        // struct SyntaxTreeNode **ast_begin_node, **ast_end_node;
        // ast_begin_node = createSyntaxTreeNodePointer();
        // ast_end_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode(ast_begin_node);
        // createSyntaxTreeNode(ast_end_node);
        // setSyntaxTreeNode(*ast_begin_node, NODE_BEGIN, "begin");
        // setSyntaxTreeNode(*ast_end_node, NODE_THEN, "end");

        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = $2->chain;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_BEGIN_END, "begin_end");
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_begin_node);
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_end_node);
    }
AssignmentStatement
    : Variable ASSIGN Expression {
        if (getVariableNodeDefine($1->index_symbol) == FALSE) {
            printf("\nError, variable is used but not defined!\n");
            exit(EXIT_FAILURE);
        }
        else if (getVariableNodeDefine($1->index_symbol) == ERROR) {
            printf("\nError, there is not the variable!\n");
            exit(EXIT_FAILURE);
        }

        modifyVariableNode($1->index_symbol, $3->type, $3->value);
        generateQuaternionNode($3->index_symbol, 0, $1->index_symbol,
                               OPCODE_ASSIGN);
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->ast_node = createSyntaxTreeNodePointer();
        createSyntaxTreeNode($$->ast_node);
        setSyntaxTreeNode(*($$->ast_node), NODE_ASSIGN, ":=");
        addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        addSyntaxTreeSonNode(*($$->ast_node), *($3->ast_node));
        printDebugInformation();
        printDebugAbstractSyntaxTreeInformation(*($$->ast_node));
    }
IfStatementElse
    : IfBoolExpressionThen Statement ELSE {
        int temp = g_quaternion_index;
        // struct SyntaxTreeNode **ast_else_node;
        // ast_else_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode(ast_else_node);
        // setSyntaxTreeNode(*(ast_else_node), NODE_ELSE, "else");

        generateQuaternionNode(0, 0, 0, OPCODE_JMP);
        backpatchQuaternionNodeChain($1->chain, g_quaternion_index);
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = mergeQuaternionNodeChain($2->chain, temp);
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_IF_THEN_ELSE, "if_then_else");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *($2->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_else_node);
        printDebugQuaternionInformation();
    }
IfBoolExpressionThen
    : IF BoolExpression THEN {
        // struct SyntaxTreeNode **ast_if_node, **ast_then_node;
        // ast_if_node = createSyntaxTreeNodePointer();
        // ast_then_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode(ast_if_node);
        // createSyntaxTreeNode(ast_then_node);
        // setSyntaxTreeNode(*ast_if_node, NODE_IF, "if");
        // setSyntaxTreeNode(*ast_then_node, NODE_THEN, "then");

        backpatchQuaternionNodeChain($2->chain_true, g_quaternion_index);
        $$ = ALLOCATE_STRUCT_MEMORY(Statement);
        $$->chain = $2->chain_false;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_IF_THEN, "if_then");
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_if_node);
        // addSyntaxTreeSonNode(*($$->ast_node), *($2->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_then_node);
        printDebugQuaternionInformation();
    }
WhileBoolExpressionDo
    : While BoolExpression DO {
        // struct SyntaxTreeNode **ast_do_node;
        // ast_do_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode(ast_do_node);
        // setSyntaxTreeNode(*ast_do_node, NODE_DO, "do");

        backpatchQuaternionNodeChain($2->chain_true, g_quaternion_index);
        $$ = ALLOCATE_STRUCT_MEMORY(WhileStatement);
        $$->chain = $2->chain_false;
        $$->loop_start = $1->loop_start;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_WHILE_DO, "while_do");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *ast_do_node);
        printDebugQuaternionInformation();
    }
While
    : WHILE {
        $$ = ALLOCATE_STRUCT_MEMORY(WhileStatement);
        $$->chain = 0;
        $$->loop_start = g_quaternion_index;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_WHILE, "while");
        printDebugQuaternionInformation();
    }
Expression
    : Expression ADD Expression {
        $$ = performArithmeticOperation($1, $3, OPCODE_ADD, NODE_ADD, "+");
        printDebugInformation();
        printDebugAbstractSyntaxTreeInformation(*($$->ast_node));
    }
    | Expression SUB Expression {
        $$ = performArithmeticOperation($1, $3, OPCODE_SUB, NODE_SUB, "-");
        printDebugInformation();
        printDebugAbstractSyntaxTreeInformation(*($$->ast_node));
    }
    | Expression MUL Expression {
        $$ = performArithmeticOperation($1, $3, OPCODE_MUL, NODE_MUL, "*");
        printDebugInformation();
        printDebugAbstractSyntaxTreeInformation(*($$->ast_node));
    }
    | Expression DIV Expression {
        $$ = performArithmeticOperation($1, $3, OPCODE_DIV, NODE_DIV, "/");
        printDebugInformation();
        printDebugAbstractSyntaxTreeInformation(*($$->ast_node));
    }
    | LP Expression RP {
        $$ = $2;
    }
    | '-' Expression %prec UMINUS {
        int  index_symbol;
        char **temp_name = (char **)malloc(sizeof(char));
        char result[STRING_WITH_MINUS_SIZE] = "-";

        strcat(result, $2->value);

        if ($2->index_symbol > 0) {
            index_symbol = generateConstantNode($2->type, result);
        }
        else {
           if (!generateTempVariableName(temp_name)) {
                *temp_name = "temp";
            }
            index_symbol = generateVariableNode($2->type, VARIABLE_TEMP, result,
                                                *temp_name);
            free(*temp_name);
            *temp_name = NULL;
            g_temp_count++;
        }

        $$ = ALLOCATE_STRUCT_MEMORY(Expression);
        $$->index_symbol = index_symbol;
        $$->index_quaternion = generateQuaternionNode($2->index_symbol, 0,
                                                      $$->index_symbol,
                                                      OPCODE_MINUS);
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_NULL, result);
        printDebugInformation();
    }
    | Variable {
        if (getVariableNodeDefine($1->index_symbol) == FALSE) {
            printf("\nError, variable is used but not defined!\n");
            exit(EXIT_FAILURE);
        }
        else if (getVariableNodeDefine($1->index_symbol) == ERROR) {
            printf("\nError, there is not the variable!\n");
            exit(EXIT_FAILURE);
        }

        $$ = ALLOCATE_STRUCT_MEMORY(Expression);
        $$->index_symbol = $1->index_symbol;
        $$->type  = $1->type;
        $$->value = $1->value;
        $$->name  = $1->name;
        $$->index_quaternion = 0;
        $$->ast_node = $1->ast_node;
    }
    | Constant {
        $$ = ALLOCATE_STRUCT_MEMORY(Expression);
        $$->index_symbol = $1->index_symbol;
        $$->type  = $1->type;
        $$->value = $1->value;
        $$->name  = NULL;
        $$->index_quaternion = 0;
        $$->ast_node = $1->ast_node;
    }
BoolExpression
    : Expression RelationOperator Expression {
        $$ = ALLOCATE_STRUCT_MEMORY(BoolExpression);

        if ($1->type == TYPE_INTEGER && $3->type == TYPE_INTEGER) {
            JUDGE_BOOL_EXPRESSION($1, $3, $$, $2, atoi);
        }
        else if ($1->type == TYPE_REAL && $3->type == TYPE_REAL) {
            JUDGE_BOOL_EXPRESSION($1, $3, $$, $2, atof);
        }
        else {
            printf("\nWarning, type [%s] mismatch type [%s]\n!", $1->value,
                $3->value);
            exit(EXIT_FAILURE);
        }

        $$->chain_true  = g_quaternion_index;
        $$->chain_false = g_quaternion_index + 1;
        generateQuaternionNode($1->index_symbol, $3->index_symbol, 0,
                               $2->type_opcode);
        generateQuaternionNode(0, 0, 0, OPCODE_JMP);
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), $2->type_ast, $2->value);
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        // addSyntaxTreeSonNode(*($$->ast_node), *($3->ast_node));
        printDebugQuaternionInformation();
    }
    | BoolExpressionAnd BoolExpression {
        $$ = ALLOCATE_STRUCT_MEMORY(BoolExpression);
        $$->chain_true = $2->chain_true;
        $$->chain_false = mergeQuaternionNodeChain($1->chain_false,
                                                   $2->chain_false);
        // $$->ast_node = createSyntaxTreeNodePointer();
        // addSyntaxTreeSonNode(*($1->ast_node), *($2->ast_node));
        // $$->ast_node = $1->ast_node;
        printDebugQuaternionInformation();
    }
    | BoolExpressionOR BoolExpression {
        $$ = ALLOCATE_STRUCT_MEMORY(BoolExpression);
        $$->chain_false = $2->chain_false;
        $$->chain_true = mergeQuaternionNodeChain($1->chain_true,
                                                  $2->chain_true);
        // $$->ast_node = createSyntaxTreeNodePointer();
        // addSyntaxTreeSonNode(*($1->ast_node), *($2->ast_node));
        // $$->ast_node = $1->ast_node;
        printDebugQuaternionInformation();
    }
    | NOT BoolExpression {
        $$ = ALLOCATE_STRUCT_MEMORY(BoolExpression);
        $$->true_or_false = ($2->true_or_false == TRUE) ? FALSE : TRUE;
        $$->chain_true = $2->chain_false;
        $$->chain_false = $2->chain_true;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_NOT, "not");
        // addSyntaxTreeSonNode(*($$->ast_node), *($2->ast_node));
        printDebugQuaternionInformation();
    }
    | LP BoolExpression RP {
        $$ = ALLOCATE_STRUCT_MEMORY(BoolExpression);
        $$->true_or_false = $2->true_or_false;
        $$->chain_true = $2->chain_true;
        $$->chain_false = $2->chain_false;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_LP_RP, "()");
        // addSyntaxTreeSonNode(*($$->ast_node), *($2->ast_node));
        printDebugQuaternionInformation();
    }
BoolExpressionAnd
    : BoolExpression AND {
        backpatchQuaternionNodeChain($1->chain_true, g_quaternion_index);
        $$ = ALLOCATE_STRUCT_MEMORY(BoolExpression);
        $$->true_or_false = $1->true_or_false;
        $$->chain_false = $1->chain_false;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_AND, "and");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        printDebugQuaternionInformation();
    }
BoolExpressionOR
    : BoolExpression OR {
        backpatchQuaternionNodeChain($1->chain_true, g_quaternion_index);
        $$ = ALLOCATE_STRUCT_MEMORY(BoolExpression);
        $$->true_or_false = $1->true_or_false;
        $$->chain_true = $1->chain_true;
        // $$->ast_node = createSyntaxTreeNodePointer();
        // createSyntaxTreeNode($$->ast_node);
        // setSyntaxTreeNode(*($$->ast_node), NODE_OR, "or");
        // addSyntaxTreeSonNode(*($$->ast_node), *($1->ast_node));
        printDebugQuaternionInformation();
    }
Variable
    : IDENTIFIER {
        $$ = ALLOCATE_STRUCT_MEMORY(Variable);

        if (judgeVariableNodeExist($1)) {
            VariableTableNode *variable_temp_node =
                getVariableNode(getVariableNodeIndex($1));
            $$->index_symbol = variable_temp_node->index;
            $$->chain = variable_temp_node->chain;
            $$->type = variable_temp_node->variable->type;

            if (variable_temp_node->variable->value == NULL) {
                $$->value = NULL;
            }
            else {
                $$->value =
                    (char *)malloc(
                    strlen(variable_temp_node->variable->value) + 1);
                strcpy($$->value, variable_temp_node->variable->value);
            }

            $$->name =
                (char *)malloc(strlen(variable_temp_node->variable->name) + 1);
            strcpy($$->name, variable_temp_node->variable->name);
        }
        else {
            $$->index_symbol = generateVariableNode(TYPE_NULL, VARIABLE_USER,
                                                    NULL, $1);
            $$->chain = $$->index_symbol;
            $$->type  = TYPE_NULL;
            $$->value = NULL;
            $$->name = (char *)malloc(strlen($1) + 1);
            strcpy($$->name, $1);
        }

        $$->ast_node = createSyntaxTreeNodePointer();
        createSyntaxTreeNode($$->ast_node);
        setSyntaxTreeNode(*($$->ast_node), NODE_NULL, $1);
        printDebugVariableInformation();
        printDebugAbstractSyntaxTreeInformation(*($$->ast_node));
    }
Constant
    : NUMBER_INTEGER {
        $$ = ALLOCATE_STRUCT_MEMORY(Constant);
        $$->index_symbol = generateConstantNode(TYPE_INTEGER, $1);
        $$->type  = TYPE_INTEGER;
        $$->value = (char *)malloc(strlen($1) + 1);
        strcpy($$->value, $1);
        $$->ast_node = createSyntaxTreeNodePointer();
        createSyntaxTreeNode($$->ast_node);
        setSyntaxTreeNode(*($$->ast_node), NODE_INTEGER, $1);
        printDebugConstantInformation();
        printDebugAbstractSyntaxTreeInformation(*($$->ast_node));
    }
    | NUMBER_REAL {
        $$ = ALLOCATE_STRUCT_MEMORY(Constant);
        $$->index_symbol = generateConstantNode(TYPE_REAL, $1);
        $$->type  = TYPE_REAL;
        $$->value = (char *)malloc(strlen($1) + 1);
        strcpy($$->value, $1);
        $$->ast_node = createSyntaxTreeNodePointer();
        createSyntaxTreeNode($$->ast_node);
        setSyntaxTreeNode(*($$->ast_node), NODE_REAL, $1);
        printDebugConstantInformation();
        printDebugAbstractSyntaxTreeInformation(*($$->ast_node));
    }
RelationOperator
    : LT {
        $$ = ALLOCATE_STRUCT_MEMORY(RelationOperator);
        $$->type_ast    = NODE_LT;
        $$->type_opcode = OPCODE_JLT;
        $$->value       = "LT";
    }
    | GT {
        $$ = ALLOCATE_STRUCT_MEMORY(RelationOperator);
        $$->type_ast    = NODE_GT;
        $$->type_opcode = OPCODE_JGT;
        $$->value       = "GT";
    }
    | LE {
        $$ = ALLOCATE_STRUCT_MEMORY(RelationOperator);
        $$->type_ast    = NODE_LE;
        $$->type_opcode = OPCODE_JLE;
        $$->value       = "LE";
    }
    | GE {
        $$ = ALLOCATE_STRUCT_MEMORY(RelationOperator);
        $$->type_ast    = NODE_GE;
        $$->type_opcode = OPCODE_JGE;
        $$->value       = "GE";
    }
    | EQ {
        $$ = ALLOCATE_STRUCT_MEMORY(RelationOperator);
        $$->type_ast    = NODE_EQ;
        $$->type_opcode = OPCODE_JEQ;
        $$->value       = "EQ";
    }
    | NE {
        $$ = ALLOCATE_STRUCT_MEMORY(RelationOperator);
        $$->type_ast    = NODE_NE;
        $$->type_opcode = OPCODE_JNE;
        $$->value       = "NE";
    }

%%
int yyerror(const char *string)
{
    printf("\n%d: %s at '%s'!\n", yylineno, string, yytext);
    return 0;
}
