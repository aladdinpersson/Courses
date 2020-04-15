# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

class MethodNotDefinedForThisPositionError(Exception):
    pass
"""
Datatypen Lista enligt definitionen på sidan 44 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

Denna klass implementerar listan med hjälp av en 2-Cell
"""
from TwoCell import TwoCell

class ListTwoCell:

    def __init__(self):
        """
            Syfte: Skapar en tom lista med en tom 2-Cell som "huvud" i listan.
            Returvärde: -
            Kommentarer: I boken heter denna funktion Empty. Vi ser till att
                         First(lista) = Last(lista)
        """
        self._head= TwoCell()
        self._head.setPrev(self._head)
        self._head.setNext(self._head)

    def insert(self, position, obj):
        """
            Syfte: Stoppar in ett nytt element med värdet obj i listan före
                        angiven position
            Parametrar: position - En position i listan
                        obj - värdet som ska in i listan
            Returvärde: Positionen för det insatta elemenet
            Kommentarer: 
        """        
        newCell = TwoCell()
        newCell.setValue(obj)
        if self.isempty():
            newCell.setPrev(self._head)
            newCell.setNext(self._head)
            self._head.setPrev(newCell)
            self._head.setNext(newCell)
        else:
            newCell.setPrev(position.inspectPrev())
            newCell.setNext(position)
            position.setPrev(newCell)
            newCell.inspectPrev().setNext(newCell)            
        return newCell

    def isempty(self):
        """
            Syfte: Returnerar sant om listan är tom (saknar element)
            Parametrar: -
            Returvärde: Sant om listan är tom
            Kommentarer:
        """    
        return (self._head.inspectPrev()== self._head) and (self._head.inspectNext() == self._head)

    def inspect(self,position):
        """
            Syfte: Returnerar värdet som finns på angiven position
            Parametrar: position - En position i listan
            Returvärde: Värdet som finns på angiven position
            Kommentarer: Inte definierad för listans sista position
        """    
        if position == self.end():
            raise MethodNotDefinedForThisPositionError("Error in inspect")          
        return position.inspectValue();

    def first(self):
        """
            Syfte: Returnerar listans första position
            Parametrar: -
            Returvärde: Listans första position
            Kommentarer:
        """    
        return self._head.inspectNext()

    def end(self):
        """
            Syfte: Returnerar listans sista position
            Parametrar: -
            Returvärde: Listans första position
            Kommentarer:
        """    
        return self._head

    def next(self,position):
        """
            Syfte: Returnerar position efter den angivna positionen
            Parametrar: position - En position i listan
            Returvärde: Positionen efter den angivna
            Kommentarer: Inte definierad för listans sista position
                        (som saknar element)
        """    
        if position == self.end():
                    raise MethodNotDefinedForThisPositionError("Error in next")                 
        return position.inspectNext()

    def previous(self,position):
        """
            Syfte: Returnerar position före den angivna positionen
            Parametrar: position - En position i listan
            Returvärde: Positionen före den angivna
            Kommentarer: Inte definierad för listans första position
        """    
        if position == self.first():
                    raise MethodNotDefinedForThisPositionError("Error in previous")                 
        return position.inspectPrev()

    def remove(self,position):
        """
            Syfte: Tar bort elementet på den angivna positionen 
            Parametrar: position - En position i listan
            Returvärde: Positionen på elementet direkt efter det som togs bort
            Kommentarer: Är inte definierad för listans sista position
                        (som saknar element)
        """    
        if position == self.end():
                    raise MethodNotDefinedForThisPositionError("Error in remove")                 
        position.inspectPrev().setNext(position.inspectNext())
        position.inspectNext().setPrev(position.inspectPrev())
        
        return position.inspectNext()
