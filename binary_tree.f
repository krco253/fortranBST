c       ===========binary_tree.f============
c       AUTHOR: Kelsey Cole
C       COMPILE WITH: f95 -g -Wall 
c       DESCRIPTION: constructs a binary tree from user input
c       keys, prints the tree in preorder, and allows user to 
c       provide queries to search the tree

c       =====main program=====
        PROGRAM binary_tree 

        INTEGER nodeCount        
C        get input from user
c        WRITE(*,*) 'Number of nodes? '
        READ(*,*) nodeCount 
        IF (nodeCount .EQ. 0) GOTO 55
c       construct the tree
        CALL constructTree(nodeCount)
c       print the tree in preorder
        CALL printPreorder(1)
c       allow user to input queries
        CALL isPresent
55      IF (nodeCount .EQ. 0) WRITE(*,*) "Empty tree"
        END

C       ===== constructTree =====
c       asks for user input to create
c       nodes and constructs their binary tree

        SUBROUTINE constructTree(nodeCount)
        
        INTEGER num, key, root, nodeCount
c       binary tree is represented by array int_tree
        DIMENSION int_tree(100000)
c       tree is made global for other functions/subroutines to use
        COMMON int_tree

c       read in first node (root)        
c        WRITE(*,*) 'Enter node key: '
        READ (*,*) root

C       assign root 
        int_tree (1) = root

c       initialize tree
        do 40 num = 2, 100000
                int_tree(num) = 10001
40      CONTINUE 

c       get user input for nodes
        do 10 num = 2, nodeCount
c                WRITE(*,*) 'Enter node key: '
                READ(*,*) key
                CALL insert_node(1, key, nodeCount)
10      CONTINUE
c        CALL printTree(nodeCount) (used in debugging)
        END
        

c       ===== insert_hlpr =====
c       helper function for indx_to_insert
c       allows indirect recursion
        SUBROUTINE insert_hlpr(depth,num, ndeCt)
        INTEGER depth,num,ndeCt

        CALL insert_node(depth,num, ndeCt)
        END

c       ====== insert_node ======
c       inserts node into binary tree using recursion
        SUBROUTINE insert_node(dpth, num, ndeCt)
        INTEGER dpth, num, ndeCt
        DIMENSION int_tree(100000)
        COMMON int_tree

c       if we have reached a "null" node (1001 is being used in the 
c       purpose), we have reached the end of the branch.
        IF(int_tree(dpth) .EQ. 10001) GOTO 50
c       if a node is less than the current one, move "left"
        IF(num .LT. int_tree(dpth)) CALL insert_hlpr(2*dpth,num,ndeCt)
c       else, move "right" 
        IF(num .GE. int_tree(dpth))CALL insert_hlpr(2*dpth+1,num,ndeCt)
c       finally assign node value and return
50      IF(int_tree(dpth) .EQ. 10001) int_tree(dpth) = num
        END

c        ===== printTree =====
c       prints a binary tree in numerical order of indices in array
c       prints "null nodes" (nodes with 1001 as their key) as well
c       primarily used in debugging

        SUBROUTINE printTree(numNodes)
        INTEGER numNodes
        DIMENSION int_tree(100000)
        COMMON int_tree

        do 60 indx = 1, 2*numNodes+1
                WRITE(*,*) int_tree(indx)
60      CONTINUE
        END


c       ===== printPreorderHlpr =====
c       allows indirect recursion use of printPreorder
        SUBROUTINE printPreorderHlpr(node)
        INTEGER node
        DIMENSION int_tree(100000)
        COMMON int_tree

        CALL printPreorder(node)

        END

C       ====== printPreorder ======
C       prints a binary tree in preorder
c
        SUBROUTINE printPreorder(node)
        INTEGER node
        DIMENSION int_tree(100000)
        COMMON int_tree

c       if node is 1001 (essentially null), you have
c       reached the end of the branch -- return
        IF (int_tree(node) .EQ. 10001)  GOTO 70
c       else, print out the node
        WRITE(*,*) int_tree(node)
c       print the node's left branch
        CALL printPreorderHlpr(2*node)
c       print the node's right branch
        CALL printPreorderHlpr(2*node+1)
        
70      CONTINUE
        END        
        
c       ===== isPresent =====
c       reports whether probeCount number of queries are 
c       present in the tree
        SUBROUTINE isPresent
        INTEGER found, num, probeCount, query
        DIMENSION int_tree(100000)
        COMMON int_tree
        DIMENSION keys(100000)

c        WRITE(*,*) "probeCount?"
        READ(*,*) probeCount
        
c       read in queries
        do 42 num = 1, probeCount
                READ(*,*) query
                keys(num) = query
42      CONTINUE 

c       look for queries and print whether they are in a tree
        do 90 num = 1,probeCount
                query = keys(num)
                found = keyFind(1, query)
                IF (found .EQ. 10001) WRITE(*,*) query, " no"
                IF (found .EQ. query) WRITE(*,*) query, " yes"
90      CONTINUE
        END

c       ===== keyFindHlpr =====
c       enables indirect recursion in findKey
        INTEGER FUNCTION keyFindHlpr(node, key)
        INTEGER node, key
        DIMENSION int_tree(100000)
        COMMON int_tree
        
        keyFindHlpr = keyFind(node,key)
        RETURN
        END

c       ===== keyFind =====
c       determines whether or not a key is present in the binary
c       tree. returns 10001 if a key was not found, the key itself  
c       if it was found

        INTEGER FUNCTION keyFind(node, key)
        INTEGER node, key, current
        DIMENSION int_tree(100000)
        COMMON int_tree

        current = int_tree(node)
c       if the current node has the desired key, return
        IF (current .EQ. key) GOTO 11
c       if the current node is 1001, the key was not found (return)
        IF (current .EQ. 10001) GOTO 11

c       if the current node is less than the key, explore the left
c       branch        
        IF (key .LT. current) GOTO 16
16      keyFind = keyFindHlpr(2*node, key)
        IF (key .LT. current) GOTO 13
c       if the current node is greater than or equal to the key, explore
c       the right branch 
        IF (key .GE. current) GOTO 15
15      keyFind = keyFindHlpr(2*node+1, key)
        GOTO 13
c       return whether the node was found
11      keyFind = current
13      RETURN
        END


        
