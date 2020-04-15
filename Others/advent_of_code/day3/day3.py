# Day 3 in Advent of Code

import numpy as np

def part1():
    # Step1: Check size to initialiaze array
    rows,cols = 0,0
    for line in data:
        coord = list(map(int, line.split()[2].replace(':','').split(',')))
        kernel = list(map(int, line.split()[3].split('x')))

        rows = int(coord[0]+kernel[0]) if int(coord[0]+kernel[0]) > rows else rows
        cols = int(coord[1]+kernel[1]) if int(coord[1]+kernel[1]) > cols else cols

    arr = np.zeros((rows, cols))

    # Step2: Calculate overlaps
    for line in data:
        location = list(map(int, line.replace(':','').split()[2].split(',')))
        coord = list(map(int, line.split()[3].split('x')))

        arr[location[0]:location[0]+coord[0], location[1]:location[1]+coord[1]] += 1

    # Return arr for part2
    return (np.sum(arr >= 2), arr)

def part2(matrix):
    assert len(matrix) > 0, "Matrix has no values"

    for line in data:
        #Get values from string
        ID = int(line.split()[0].replace('#', ''))
        coord = list(map(int, line.split()[2].replace(':','').split(',')))
        kernel = list(map(int, line.split()[3].split('x')))

        end_rows = int(coord[0]+kernel[0])
        end_cols = int(coord[1]+kernel[1])

        checkClaim = matrix[coord[0]:end_rows, coord[1]:end_cols]

        if checkClaim.shape == (1,1) and (checkClaim == 1):
            return ID

        elif (checkClaim.shape != (1,1) and (checkClaim == 1).all()):
            return ID

    return "NotFound"

if __name__ == '__main__':
    with open('input.txt', 'r') as f:
        data = f.readlines()

    summ, matrix= part1()
    print(f'Answer to part 1 is {summ}')
    ID = part2(matrix)

    print(f'Answer to part 2 is {ID}')
    