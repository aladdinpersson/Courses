# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

class EmptyStackError(Exception):
    pass
class FullStackError(Exception):
    pass
"""
Datatypen Stack enligt definitionen på sidan 134 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

Denna klass implementerar stacken med hjälp av en Array
"""
class StackArray:
    def __init__(self, size = 100):
        """
            Syfte: Skapar en tom stack med hjälp av en Array
            Returvärde: -
            Kommentarer: I boken heter denna funktion Empty. 
        """	          
        self._array = [None for i in range(size)]
        self._top = -1 #index fÃ¶r Ã¶versta vÃ¤rdet
        self._size = size #Maxsstorleken

    def top(self):
        """
            Syfte: Ger värdet av det översta elementet på stacken
            Returvärde: Värdet överst på stacken
            Kommentarer: Ej definierad för tom stack
        """     
        if self.isempty():
            raise EmptyStackError("Error in top")
        return self._array[self._top]

    def push(self, obj):
        """
            Syfte: Lägger ett element med värdet v överst på stacken
            Returvärde: -
            Kommentarer: In en arrayimplementation av stacken kan den bli full!            
        """     
        if self._top == self._size-1:
            raise FullStackError("Error in push")        
        self._top = self._top + 1
        self._array[self._top] = obj

    
    def pop(self):
        """
            Syfte: Tar bort översta värdet från stacken.
            Returvärde: -
            Kommentarer: Ej definierad för tom stack
        """	    
        if self._top == -1:
            raise EmptyStackError("Error in pop")
        self._array[self._top] = None #Visar att vÃ¤rdet kan tas bort
        self._top = self._top - 1 #... och minska vÃ¤rdet pÃ¥ top med 1

    def isempty(self):
        """
            Syfte: Testar om stacken är tom
            Returvärde: Sant om stacken är tom, annars falskt
            Kommentarer: 
        """         
        return self._top == -1 
