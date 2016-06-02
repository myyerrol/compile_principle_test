#ifndef PASCAL_HANDLE_SYNTAX_TREE_H
#define PASCAL_HANDLE_SYNTAX_TREE_H

#include <stdio.h>

#define STATE_NULL_NODE_POINTER        700
#define STATE_CREATE_NODE_SUCCESS      701
#define STATE_ALLOCATE_MEMORY_ERROR    702
#define STATE_INIT_NODE_SUCCESS        703
#define STATE_SET_NODE_SUCCESS         704
#define STATE_ADD_SON_NODE_SUCCESS     705
#define STATE_GET_SON_NODE_SUCCESS     706
#define STATE_ADD_BROTHER_NODE_SUCCESS 707
#define STATE_GET_BROTHER_NODE_SUCCESS 708
#define STATE_ADD_BROTHER_NODE_ERROR   709

#define NODE_NULL                      750
#define NODE_PROGRAM                   751
#define NODE_INTEGER                   752
#define NODE_REAL                      753
#define NODE_ADD                       754
#define NODE_SUB                       755
#define NODE_MUL                       756
#define NODE_DIV                       757
#define NODE_VARIABLE                  758
#define NODE_ASSIGN                    759

#define SPACE_POSITION                 6
#define SPACE_HALF_LENGTH              4

#define PRINT_SPACE(count)          \
do {                                \
    int i;                          \
    for (i = 0; i < (count); i++) { \
        printf(" ");                \
    }                               \
} while (0);

typedef struct SyntaxTreeNode {
    int                   type;
    char                  *value;
    struct SyntaxTreeNode *parent;
    struct SyntaxTreeNode *son;
    struct SyntaxTreeNode *brother;
} AbstractSyntaxTreeNode, SpecificSyntaxTreeNode;

extern void printAllAbstractSyntaxTreeNode(AbstractSyntaxTreeNode *ast_node);
extern int createSyntaxTreeNode(struct SyntaxTreeNode **st_node);
extern int initSyntaxTreeNode(struct SyntaxTreeNode *st_node);
extern int setSyntaxTreeNode(struct SyntaxTreeNode *st_node, int type,
                             char *value);
extern int addSyntaxTreeSonNode(struct SyntaxTreeNode *st_parent_node,
                                struct SyntaxTreeNode *st_son_node);
extern int addSyntaxTreeBrotherNode(struct SyntaxTreeNode *st_current_node,
                                    struct SyntaxTreeNode *st_brother_node);
extern int getSyntaxTreeSonNode(struct SyntaxTreeNode *st_parent_node,
                                struct SyntaxTreeNode **st_son_node);
extern int getSyntaxTreeBrotherNode(struct SyntaxTreeNode *st_current_node,
                                    struct SyntaxTreeNode **st_brother_node);
extern struct SyntaxTreeNode **createSyntaxTreeNodePointer();
#endif // PASCAL_HANDLE_SYNTAX_TREE_H