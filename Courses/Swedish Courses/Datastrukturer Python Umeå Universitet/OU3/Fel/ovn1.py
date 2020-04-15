# -*- coding: latin-1 -*-
result = 0
fak = int(input("Detta program beräknar n!\nAnge n : ")) 
while fak > 1:
    result = result * fak 
    fak = fak + 1
print("Svar: %d\n") % result
