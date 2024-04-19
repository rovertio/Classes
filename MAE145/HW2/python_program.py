#!/usr/bin/env python3
# A16351004

# import all modules here if you need any

import numpy as np
import random
# your file should always start from definition of functions 

def create_board():
    """ Add illustrations here, if needed """
    
    # define variables you need
    tile = 0
    b_len = 3

    # Using for loop to assign array elements
    board = np.zeros((b_len,b_len))
    for i in range(b_len):
        for j in range(b_len):
            board[i][j] = tile

    #numpy array to represent a 3 x 3 table, each element
    #should be set as an integer equal to zero
    
    return board

def place(board , player, position):
    """ Add illustrations here, if needed """
    
    # Operations
    if board[position[0]][position[1]] == 0:
        # If space available, prints a picture of the board 
        board[position[0]][position[1]] = player
        #print(board)
    else:
         # If already filled, returns a print of the board and message
        board = board
        #print(board)
        print("Position already taken")
        

    return board #(same data type as input board)

def possibilities(board):
    
    #operations
    # outputs locations where board value = 0 is true
    str_p = np.where(board == 0)

    ind = []
    # for loop to assemble tuples
    for i in range(len(str_p[1])):
        ind.append((str_p[0][i], str_p[1][i]))

    return ind #each element in this list should be tuple or it is
               #empty (return [])

def random_place(board, player):  # Important: you need to use a random seed of 1 to show results
    #random.seed(1)                # for truly random results comment this line out

    # operations
    # Select position at random from method
    p_sel = random.choice(possibilities(board))
    # Place for player using the randomly selected position available
    board = place(board, player, p_sel)
    
    return board

def repeat(n):                     # Important: you should enter 1 to initialize the random seed
                                   #  for truly random results comment this line out     
    board = create_board()
    #random.seed(1)
    # Operations
    # Create array with player's turns
    turns = range(2*n)
    turns = np.where(np.mod(turns, 2) == 0, 2, 1)
    for i in range(len(turns)):
        random_place(board, turns[i])
    
    return board
    
if __name__ == '__main__':
    """ 
    This is the place where you can test your function. 
    You can define variables, feed them into your function and check the output   
    """
    
    board = create_board()

    #print(type(board))
    
    board = place(board, 1, (0,0))  

    print(board)
    
    empty_positions = possibilities(board)

    print(empty_positions)
    
    board = random_place(board, 1)
 
    n =  4  # an integer n < 5 since there are only 9 cells in the board and two players in turn place the mark
                  # repeat n times
    board = repeat(n)

    print(board)
