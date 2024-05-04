#!/usr/bin/env python3
# A16351004 #PID

# import all modules here if you need any

import numpy as np
import random

# your file should always start from definition of functions 



def computeBFStree(AdjTable, start): 
    """ descriptions here """
    
    ##########
    #### Your code goes here ####
    ##########

    # keep looping until there are nodes still to be checked
    # there should be three different types of results to return:  

    if start in AdjTable:
        # Initiate parent dictionary
        parent = {}
        for node in AdjTable:
            parent[node] = "NONE"
       
        # keep track of all visited nodes
        visited = []
        # keep track of nodes to be checked
        queue = [start]
        # visits all the nodes of a AdjTable (connected component) using BFS
        
        parent[start] = start
        while queue:
            curr_node = queue[0]
            visited.append(curr_node)
            #print(visited, curr_node)
            del queue[0]
            for i in range(len(AdjTable[curr_node])):
                next_node = AdjTable[curr_node][i]
                #print(AdjTable[curr_node], next_node)
                if parent[next_node] == "NONE":
                    parent[next_node] = curr_node
                    #print(parent[next_node])
                    queue.append(next_node)
                    #print(queue)
                    # Shows edge doesn't exist between nodes
                    if parent[next_node] not in AdjTable[next_node]:
                        return 'AdjTable is invalid'

        # or a vector of pointers parents describing the BFS tree rooted at start
        # equivalently, a list of nodes in visited order, start from the 'start node' 
        # outputs visited nodes and parents associated
        return visited, parent # list of visited node e.g. [ 'A', 'B', 'C', 'D']

    else:
         return 'No start node in the graph'
    

def computeBFSpath(AdjTable, start, goal):
    """ descriptions here """

    BFStree, parent = computeBFStree(AdjTable, start)
    # define some variables etc.
    if start not in parent:
        return 'No start node in the graph'
    if goal not in parent:
        return 'No goal node in the graph'

    # keep track of visited nodes
    visited = [BFStree]
    # keep track of all the paths to be checked
    #queue = [[start]]
    # return path if start is goal
    path = []
    curr_node = goal

    while curr_node != start:
         path.append(curr_node)
         curr_node = parent[curr_node]

    path.append(start)
    path.reverse()
    return path

    
    
if __name__ == '__main__':
    """ 
    This is the place where you can test your function. 
    You can define variables, feed them into your function and check the output   
    """
    
    # AdjTable defined as a dictionary 
    
    #Testing with input of AdjTable
    AdjTable = {'A': ['B', 'D'],
                'B': ['A'],
                'C': ['D'],
                'D': ['A', 'F', 'C'],
                'E': ['F'],
                'F': ['D', 'E']}
    
    start='A'
    goal='C'
    
    myBFSTree, parent =computeBFStree(AdjTable, start)
    print(myBFSTree)
    #print(parent)
    # output should be a list: 
    # ['A', 'B', 'D', 'F', 'C', 'E']

    myBFSPath=computeBFSpath(AdjTable, start, goal)
    print(myBFSPath)
    # output should be a list: 
    # ['A', 'D', 'C']
    
    
    #Writing maze graph in E2.8 as the AdjTable1 and testing based on the nodes marked 
    AdjTable1 = {1: [2,3],2: [1,4,17],3: [1,4,5],4: [2,3,6],5: [3,6,7],6: [4,5,8],7:[5,8,9],
                 8: [6,7,10],9: [7,10],10: [8,9,11],11: [10,12],12: [11,13],13:[12,14],
             14: [13,15],15: [14,26,16],16: [15,32],17: [2,18],18: [17,19], 
             19:[18,20,21],20: [19,22], 21: [19,22,23],22: [20,21,24],23: [21,24,27],
             24:[22,23,25],25: [24,26],26: [25,15],27: [23,28],28: [27,29],29: [28,30],
             30:[29,31],31: [30,32],32: [16,31]}
    start, goal = 1, 32
    myBFSTree, parent =computeBFStree(AdjTable1, start)
    print(myBFSTree)
    #print(parent)
    # solution should be a list: 
    #[1, 2, 3, 4, 17, 5, 6, 18, 7, 8, 19, 9, 10, 20, 21, 11, 22, 23, 12, 24, 
    #27, 13,25, 28, 14, 26, 29, 15, 30, 16, 31, 32]
     
    myBFSPath=computeBFSpath(AdjTable1, start,goal)
    print(myBFSPath)
    # [1, 2, 4, 6, 8, 10, 11, 12, 13, 14, 15, 16, 32]







