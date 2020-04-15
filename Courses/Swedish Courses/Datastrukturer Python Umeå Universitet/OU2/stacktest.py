# This program tests an implementation of a stack.
# If any test was not passed then you will get an error message!

# Programmed by 2019-02-06 <aladdin.persson@umu.se>

from Stack1Cell import Stack1Cell

import random
import string
import copy

# Test: Check if stack is empty when created
def test_isempty():
    stack = Stack1Cell()

    if not stack.isempty():
        raise("Stack was created but wasn't empty!")

# Test: Check if stack is no longer empty after added element
def test_addelement():
    stack = Stack1Cell()
    stack.push('not_empty_now')

    if stack.isempty():
        raise("Element was added but stack is empty!")

# Test: Check if push followed by deletion results in the original stack
def test_poppush():
    stack = Stack1Cell()
    
    # Original stack
    stack.push('test')
    copy_stack = copy.copy(stack)

    # Do operations that give back original in the end
    random_character = random.choice(string.ascii_letters)
    stack.push(random_character)
    stack.pop()

    if stack.top() != copy_stack.top():
        raise("We added and deleted element, so it should be equal to original!")

# Test: Check if element added is put at the top of the stack
def test_toppush():
    stack = Stack1Cell()
    element_to_add = random.choice(string.ascii_uppercase)

    stack.push(element_to_add)

    if element_to_add != stack.top():
        raise("Element addded isn't equal the top of stack")

# Test: Check if push element that was popped results in original stack
def test_push_toppop():
    # We assume the stack isn't empty. If we pop the top element of a stack and put back the element
    # we popped then we should receive the original stack back.

    stack = Stack1Cell()
    stack.push(random.choice(string.ascii_uppercase))

    element_we_removed = stack.top()
    stack_copy = copy.copy(stack)

    stack.pop()
    stack.push(element_we_removed)

    if stack_copy.top() != stack.top():
        raise("We added the element we removed but it doesnt equal the original")

# The following tests are supplementary/more advanced than the previous ones. If it has passed all tests above
# then we know it at least satisfies axioms from stacks.

# Test: Check if we can pop an empty stack (should result in error!)
def test_popempty():
    s = Stack1Cell()

    try:
        s.pop()
        raise("We was able to pop an empty stack. This should not be possible!")
    except:
        pass

# Test: Check if we can look at top element of empty stack
def test_topempty():
    s = Stack1Cell()

    try:
        s.top()
        raise("We tried to look at top element of an empty stack. This should not be possible!")
    except:
        pass

# Test: Check if added a bunch of elements is then put in the correct order in the stack.
def test_addelements(tot_elements=10):
    # Generate random list
    L = [random.choice(string.ascii_letters + string.digits) for i in range(tot_elements)]

    stack = Stack1Cell()

    for each in L:
        stack.push(each)

    for i in range(len(L)-1,-1,-1):
        if stack.top() != L[i]:
            raise("Wrong order of stack!")
        stack.pop()


# Run all tests
def test():
    test_isempty()
    test_addelement()
    test_addelement()
    test_poppush()
    test_toppush()
    test_push_toppop()

    # If nothing has been raised at this point then we know it has passed all 'axiom' tests
    #print("--------------- All Axiom tests OK! ---------------")

    test_popempty()
    test_topempty()
    test_addelements(tot_elements=100)

    # If nothing has been raised here then it has passed all 'supplementary' tests and our testing is complete.
    #print("--------------- All Supplementary tests OK! ---------------")
    #print()
    #print("This implementation seems to be correct from the tests performed!")

if __name__ == "__main__":
    test()