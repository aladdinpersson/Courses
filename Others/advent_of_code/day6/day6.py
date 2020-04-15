# Advent of code day 6

import re
from operator import itemgetter

def getNearestNeighbor(node, dictOfNodes):
    nearestNeighbor = (None, float('inf'))

    for cord in dictOfNodes:
        mhDistance = abs(node[0] - cord[0]) + abs(node[1] - cord[1])
        if(mhDistance < nearestNeighbor[1]):
            nearestNeighbor = (cord, mhDistance)
        elif(mhDistance == nearestNeighbor[1]):
            nearestNeighbor = (None, nearestNeighbor[1])

    return(nearestNeighbor[0])
        
def part1(dictOfNodes):
    minX, maxX = min(dictOfNodes)[0], max(dictOfNodes)[0]
    minY, maxY = min(dictOfNodes,key=itemgetter(1))[1], max(dictOfNodes,key=itemgetter(1))[1]
    for x in range(minX, maxX + 1):
        for y in range(minY, maxY + 1):
            nearestNeighbor = getNearestNeighbor((x, y), dictOfNodes)
            if(nearestNeighbor != None):
                if(x == minX or x == maxX or y == maxY or y == minY):
                    dictOfNodes[nearestNeighbor] = -float('inf')
                else:
                    dictOfNodes[nearestNeighbor] += 1

    return(max(dictOfNodes.values()))


def sumOfAllDistances(node, dictOfNodes):
    distance = 0

    for cord in dictOfNodes:
        mhDistance = abs(node[0] - cord[0]) + abs(node[1] - cord[1])
        distance += mhDistance

    return distance


def part2(dictOfNodes, region_req):
    minX, maxX = min(dictOfNodes)[0], max(dictOfNodes)[0]
    minY, maxY = min(dictOfNodes, key=itemgetter(1))[1], max(dictOfNodes, key=itemgetter(1))[1]

    pointsSatisfyingReq = 0

    for x in range(minX, maxX + 1):
        for y in range(minY, maxY + 1):
            dist = sumOfAllDistances((x,y),dictOfNodes)
            if dist < region_req:
                pointsSatisfyingReq+=1

    return pointsSatisfyingReq

def main():
    with open('input.txt') as f:
        data = f.read()

    data = re.findall('\d+, \d+', data)
    coordinates = {cord : 0 for cord in tuple(map(eval, data))}

    mostArea = part1(coordinates)
    print(f'The answer to part 1 is {mostArea}')

    pointsSatisfyingReq = part2(coordinates, 10000)
    print(f'The answer to part 2 is {pointsSatisfyingReq}')

if __name__ == '__main__':
    main()