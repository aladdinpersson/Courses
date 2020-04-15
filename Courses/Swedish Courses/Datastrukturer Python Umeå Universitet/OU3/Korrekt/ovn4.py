# -*- coding: latin-1 -*-

# Edited by Aladdin Persson <aladdin.persson@umu.se>
#   2019-02-06 Corrected a few errors in the code

from Rectangle import Rectangle

print("Nu skapar jag en rektangel med bredd 3 och höjd 4")
r = Rectangle(width=3, height=4)
print(r)

print("Nu ändrar jag storleken till bredd 2 och höjd 7")
r.setSize(width=2, height=7)
print(r)