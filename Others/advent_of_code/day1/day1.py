# First day of advent of code!

import re

def part1(data):
    # For fun to learn some regex
    return sum(map(float, re.findall(r'[+|-][0-9]+', data)))

def part2(data):
    freqDict = {0:1}
    totFreq = 0

    while 1:
        for freq in map(float, re.findall(r'[+|-][0-9]+', data)):
            totFreq += freq
            freqDict[totFreq] = freqDict[totFreq] + 1 if totFreq in freqDict else 1
            if 2 == freqDict[totFreq]: return totFreq

def main():
    with open('input.txt') as f:
        data = f.read()

    part1Ans = part1(data)
    print(f'Answer to part1 is {part1Ans}')

    part2Ans = part2(data)
    print(f'Answer to part2 is {part2Ans}')

if __name__ == '__main__':
    main()