# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

class MethodNotDefinedForThisPositionError(Exception):
    pass

"""
Datatypen Array enligt definitionen på sidan 66 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

"""
from OneCell import OneCell

class DirectedList:

    def __init__(self):
        """
            Syfte: Skapar en tom riktad lista med en tom 1-Cell som "huvud" i listan.
            Returvärde: -
            Kommentarer: I boken heter denna funktion Empty.
        """
        self._head= OneCell()

    def insert(self, position, obj):
        """
            Syfte: Stoppar in ett nytt element med värdet obj i listan före angiven position
            Parametrar: position - En position i listan
                        obj - värdet som ska in i listan
            Returvärde: Positionen för det insatta elemenet
            Kommentarer: 
        """        
        tempCell = OneCell()
        tempCell.setValue(obj)
        tempCell.setLink(position.inspectLink())
        position.setLink(tempCell)
        return position

    def isempty(self):
        """
            Syfte: Returnerar sant om listan är tom (saknar element)
            Parametrar: -
            Returvärde: Sant om listan är tom
            Kommentarer:
        """    
        return self._head.inspectLink() is None

    def inspect(self,position):
        """
            Syfte: Returnerar värdet som finns på angiven position
            Parametrar: position - En position i listan
            Returvärde: Värdet som finns på angiven position
            Kommentarer: Inte definierad för listans sista position
        """    
        if self.isEnd(position):
            raise MethodNotDefinedForThisPositionError("Error in inspect") 
        return position.inspectLink().inspectValue()

    def isEnd(self,position):
        """
            Syfte: Returnerar värdet true om den angivna positionen är listans sista
            Parametrar: position - En position i listan
            Returvärde: True om den givna positionen är den sista i listan
            Kommentarer:
        """    
        return position.inspectLink() is None

    def first(self):
        """
            Syfte: Returnerar listans första position
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
        if self.isEnd(position):
            raise MethodNotDefinedForThisPositionError("Error in next")       
        return position.inspectLink()

    def remove(self,position):
        """
            Syfte: Tar bort elementet på den angivna positionen
            Parametrar: position - En position i listan
            Returvärde: Positionen på elementet direkt efter det som togs bort
            Kommentarer: Är inte definierad för listans sista position
                        (som saknar element)
        """    
        if self.isEnd(position):
            raise MethodNotDefinedForThisPositionError("Error in remove")        
        position.setLink(position.inspectLink().inspectLink())
        return position
