# Day 2 in Advent of Code

def part1(data):
    sum2, sum3 = 0, 0

    for line in data:
        D = {}

        for letter in line:
            D[letter] = D[letter] + 1 if letter in D else 1

        sum2 += 1 if 2 in D.values() else 0
        sum3 += 1 if 3 in D.values() else 0

    return sum2,sum3

def part2(data):
    save = []

    for string1 in data:
        for string2 in data:
            commonChars = [''.join(char1) if char1 == char2 else '' for char1, char2 in zip(string1, string2)]

            if commonChars.count('') == 1:
                myWord = ''.join(char for char in commonChars if (char != '' and char != '\n'))
                save.append((string1, string2, myWord))

    if len(save) > 2:
        raise ("There are multiple words that has this property!")

    return save[0][2]

def main():
    with open('input.txt', 'r') as f:
        data = f.readlines()

    sum2, sum3 = part1(data)
    print(f'The answer to part1: {sum2*sum3}')

    part2Ans = part2(data)
    print(f'The word whose characters are equal is: {part2Ans}')

if __name__ == '__main__':
    main()

