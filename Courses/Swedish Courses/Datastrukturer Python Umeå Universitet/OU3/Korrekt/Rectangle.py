# -*- coding: latin-1 -*-
class Rectangle:
    def __init__(self, width, height):
        self._width = width
        self._height = height

    def getSize(self):
        return self._width, self._height
    
    def setSize(self, height, width):
        self._width = width
        self._height = height
    
    def area(self):
        return self._width*self._height
    
    def __str__(self):
        return f"Rektangeln har bredden {self._width} och höjden {self._height}"

