from StackArray import StackArray


stack = StackArray()
print(stack.isempty())

def char_range(c1,c2):
    s = ''

    for c in range(ord(c1), ord(c2) + 1):
        s = s + chr(c)

    return s

str1 = char_range('a','b')
str2 = char_range('c','f')

#print(str1)
#print(str2)

stack.push(str1)
print(stack.top())
stack.push(str2)
print(stack.top())


def depth(stack):
    num = 0
    s = []

    while not stack.isempty():
        s.append(stack.top())
        stack.pop()
        num = num + 1

    for i in range(len(s) -1, -1, -1):
        stack.push(s[i])

    return num

def printStack(stack, txt='stacken'):
    print(txt)

    while not stack.isempty():
        print("   ", stack.top())
        s.push(stack.top())
        stack.pop()

    while not s.isempty():
        stack.push(s.top())
        s.pop()


printStack(stack)