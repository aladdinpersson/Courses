# -*- coding: latin-1 -*-

# Edited 2019-02-06 by Aladdin Persson <aladdin.persson@umu.se>
# Reason: result started at 0 and faktorial was added 1 not subtracted one each iteration of the while-loop.

result = 1
fak = int(input("Detta program beräknar n!\nAnge n : "))
while fak > 1:
    result = result * fak 
    fak = fak - 1
print(f"Svar: {result}")
