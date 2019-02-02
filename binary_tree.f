        PROGRAM binary_tree 

        INTEGER nodeCount        
c        DIMENSION int_tree(1000)
c        COMMON int_tree

C        get input from user
c        WRITE(*,*) 'Number of nodes? '
        READ(*,*) nodeCount 

        CALL constructTree(nodeCount)
        CALL printPreorder(1)
        CALL isPresent

        END

C       ===== constructTree =====
c       asks for user input to construct
c       nodes and constructs their binary tree

        SUBROUTINE constructTree(nodeCount)
        
        INTEGER num, key, root, nodeCount
        DIMENSION int_tree(1000)
        COMMON int_tree
        
c        WRITE(*,*) 'Enter node key: '
        READ (*,*) root

C       assign root 
        int_tree (1) = root

c       initialize tree
        do 40 num = 2, 1000
                int_tree(num) = 1001
40      CONTINUE 

c       get user input for nodes
        do 10 num = 2, nodeCount
c                WRITE(*,*) 'Enter node key: '
                READ(*,*) key
                CALL indx_to_insert(1, key, nodeCount)
10      CONTINUE
c        CALL printTree(nodeCount) (used in debugging)
        END
        

c       ===== insert_hlpr =====
c       helper function for indx_to_insert
c       allows indirect recursion
        SUBROUTINE insert_hlpr(depth,num, ndeCt)
        INTEGER depth,num,ndeCt

        CALL indx_to_insert(depth,num, ndeCt)
        END

c       ====== indx_to_insert ======
c       inserts node into binary tree using recursion
        SUBROUTINE indx_to_insert(dpth, num, ndeCt)
        INTEGER dpth, num, ndeCt
        DIMENSION int_tree(1000)
        COMMON int_tree

c       if we have reached a "null" node (1001 is being used in the 
c       purpose), we have reached the end of the branch.
        IF(int_tree(dpth) .EQ. 1001) GOTO 50
c       if a node is less than the current one, move "left"
        IF(num .LT. int_tree(dpth)) CALL insert_hlpr(2*dpth,num,ndeCt)
c       else, move "right" 
        IF(num .GE. int_tree(dpth))CALL insert_hlpr(2*dpth+1,num,ndeCt)
c       finally assign node value and return
50      IF(int_tree(dpth) .EQ. 1001) int_tree(dpth) = num
        END

c        ===== printTree =====
c       prints a binary tree in numerical order of indices in array
c       prints "null nodes" (nodes with 1001 as their key) as well
c       primarily used in debugging

        SUBROUTINE printTree(numNodes)
        INTEGER numNodes
        DIMENSION int_tree(1000)
        COMMON int_tree

        do 60 indx = 1, 2*numNodes+1
                WRITE(*,*) int_tree(indx)
60      CONTINUE
        END


c       ===== printPreorderHlpr =====
c       allows indirect recursion use of printPreorder
        SUBROUTINE printPreorderHlpr(node)
        INTEGER node
        DIMENSION int_tree(1000)
        COMMON int_tree

        CALL printPreorder(node)

        END

C       ====== printPreorder ======
C       prints a binary tree in preorder
c
        SUBROUTINE printPreorder(node)
        INTEGER node
        DIMENSION int_tree(1000)
        COMMON int_tree

c       if node is 1001 (essentially null), you have
c       reached the end of the branch -- return
        IF (int_tree(node) .EQ. 1001)  GOTO 70
c       else, print out the node
        WRITE(*,*) int_tree(node)
c       print the node's left branch
        CALL printPreorderHlpr(2*node)
c       print the node's right branch
        CALL printPreorderHlpr(2*node+1)
        
70      CONTINUE
        END        
        
c       ===== isPresent =====
c       finds keys in a binary tree
        SUBROUTINE isPresent
        INTEGER found, num, probeCount, query
        DIMENSION int_tree(1000)
        COMMON int_tree
c        WRITE(*,*) "probeCount?"
        READ(*,*) probeCount
        
        do 90 num = 1,probeCount
                READ(*,*) query
                found = keyFind(1, query)
                IF (found .EQ. 1) WRITE(*,*) query, " no"
                IF (found .EQ. 0) WRITE(*,*) query, " yes"
90      CONTINUE
        END

c       ===== findKeyHlpr =====
c       enables indirect recursion in findKey
        INTEGER FUNCTION keyFindHlpr(node, key)
        INTEGER node, key
        DIMENSION int_tree(1000)
        COMMON int_tree
        
        keyFindHlpr = keyFind(node,key)
        RETURN
        END

c       ===== findKey =====
c       determines whether or not a key is present in the binary
c       tree. returns 1 if a key was not found, 0 if it was found

        INTEGER FUNCTION keyFind(node, key)
        INTEGER node, key
        DIMENSION int_tree(1000)
        COMMON int_tree

        IF (int_tree(node) .EQ. key) GOTO 11
        IF (int_tree(node) .EQ. 1001) GOTO 12
        
        IF (key .GE. int_tree(node)) GOTO 15
15      keyFind = keyFindHlpr(2*node+1,key)
        GOTO 13
        IF (key .LT. int_tree(node)) GOTO 16
16      keyFind = keyFindHlpr(2*node,key)
        GOTO 13

11      keyFind = 0
        GOTO 13
12      keyFind = 1
13      RETURN
        END


        
