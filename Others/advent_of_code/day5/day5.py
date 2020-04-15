import re
import string

def part1(text):
    pattern = r''

    for upper in string.ascii_uppercase:
        letterPattern = str(upper)+str(upper).lower()
        pattern += letterPattern +'|'+letterPattern[::-1]+'|'

    pattern = pattern[:-1]

    while re.search(pattern, text) != None:
        text = re.sub(pattern, '', text)

    return text

def part2(text):
    shortestPolymer = float('inf')
    text = part1(text)
    for upperLetter in string.ascii_uppercase:
        tempText = text
        pattern = r''.join(upperLetter + '|' + upperLetter.lower())
        tempText = re.sub(pattern, '', tempText)
        tempText = part1(tempText)
        if len(tempText) < shortestPolymer:
            shortestPolymer = len(tempText)

    return(shortestPolymer)

if __name__ == '__main__':
    with open('input.txt') as f:
        text = f.read()

    answerPart1 = part1(text)
    print(f'The result to part 1 is {len(answerPart1)}')


    answerPart2 = part2(text)
    print(f'The result to part 2 is {answerPart2}')