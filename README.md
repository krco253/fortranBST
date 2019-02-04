#binary_tree-f

##Purpose
Creates a binary tree from user input node data, then probes that tree with user input data to determine if a certain node is present. 

##Organization
###Data Structures
The binary tree in this program is represented as an explicitly array called "int_tree", where int_tree(1) is the root of the tree, and subsequent children are stored in the following pattern: left children of a node at position n in the array are stored at position 2*n in the array. Right children of a node at position n in the array are stored at position 2*n+1 in the array.
int_tree is COMMON throughout the program.

###Algorithms
Both the search and insertion algorithsm were implemented "recursively."

isPresent is the "main" function for determining whether the nodes input by the user  are present in the tree. It is called directly in the main program. It prints out "yes" or "no" for each user query by calling keyFind, which recurisvely travels the tree searching for the node. Indirect recursion is supported by a helper function, findKeyHlpr. 

insert_node is the "main" function for inserting a new node in the tree. It is called by construct_tree, which is called in the main function. insert_hlpr is a helper function for insert_node, enabling its use of indirect recursion. 

##Compile with:
Simply utilize the included Makefile and run make.
Or, if you really want to put in extra work,

f95 -g -Wall binary_tree.f -o binary_tree-f
##Use
The first line of input should be the number of nodes input into the tree.
<nodeCount>
The subsequent lines after that should be the keys of the nodes to insert into the tree, separated by a newline.
<key1>
<key2>
. . .
<ENTER>

These can be pasted into the standard input.
The program will then print out the resulting tree in preorder. The user must wait until the program prints out the tree in preorder, then the next input that is expected is as follows.
The number of queries the user has:
<probeCount>
The subsequent lines should be the queries/probes the user wishes to "look" for, separated by a newline.
<query1>
<query2> 
. . .
<ENTER>
These can be pasted into the standard input as well.

##Test Data
Test data files are available for many test cases, with the exception of one: when input for the node count of the tree is 0. The program simply prints "empty tree" and exits.

The following is a list of test data and their corresponding outputs when ran on this program as described in the "use" section of this document. All files are available in this folder.

225_node_data.txt --> 225_node_results.txt
200_node_data.txt --> 200_node_results.txt
175_node_data.txt --> 175_node_results.txt
1_node_data.txt --> 1_node_results.txt
large_left_branch.txt --> large_left_results.txt
large_right_branch.txt --> large_right_results.txt

Test data characterized by number of nodes (e.g., "225_node_data.txt") were generated using the attached executable, "generate_data", which was built from the included source code, "test_data_generator.cpp" This data was generated using a pseudo random number generator, and includes negative and positive nodes. 

Large left branch and large right branch data were meant to demonstrate the program's behavior when the tree is left or right side "heavy."

##Limitations
This program will not work for node counts over 225.
