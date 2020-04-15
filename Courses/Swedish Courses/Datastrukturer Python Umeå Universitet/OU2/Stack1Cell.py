# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

class EmptyStackError(Exception):
    pass

"""
Datatypen Stack enligt definitionen på sidan 134 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

Denna klass implementerar stacken med hjälp av en 1-cell
"""

from OneCell import OneCell

class Stack1Cell:

    def __init__(self):
        """
            Syfte: Skapar en tom stack med hjälp av en 1Cell
            Returvärde: -
            Kommentarer: I boken heter denna funktion Empty. 
        """	
        self._head = None 

    def top(self):
        """
            Syfte: Ger värdet av det översta elementet på stacken
            Returvärde: Värdet överst på stacken
            Kommentarer: Ej definierad för tom stack
        """	
        if self.isempty():
            raise EmptyStackError("Error in top")        
        return self._head.inspectValue()

    def push(self, obj):
        """
            Syfte: Lägger ett element med värdet v överst på stacken
            Returvärde: -
            Kommentarer: 
        """	
        temp = OneCell()
        temp.setValue(obj)
        temp.setLink(self._head);
        self._head=temp;

    def pop(self):
        """
            Syfte: Tar bort översta värdet från stacken.
            Returvärde: -
            Kommentarer: Ej definierad för tom stack
        """	
        if self.isempty():
            raise EmptyStackError("Error in pop")        
        self._head = self._head.inspectLink()

    def isempty(self):
        """
            Syfte: Testar om stacken är tom
            Returvärde: Sant om stacken är tom, annars falskt
            Kommentarer: 
        """	
        return self._head is None
