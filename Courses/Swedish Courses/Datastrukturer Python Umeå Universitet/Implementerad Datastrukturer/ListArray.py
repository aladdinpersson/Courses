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

Denna klass implementerar listan med hjälp av en array
"""
class ListArray:

    def __init__(self):
        """
            Syfte: Skapar en tom lista med hjälp av en array
            Returvärde: -
            Kommentarer: I boken heter denna funktion Empty. Vi ser till att
                         First(lista) = Last(lista).
                         Notera att det finns en maxstorlek!
        """
        self._MAX = 20
        self._values = [None for _ in range(self._MAX)]
        self._endpos = 0    # Första tomma platsen i arrayen
        
    def insert(self, position, obj):
        """
            Syfte: Stoppar in ett nytt element med värdet obj i listan före
                        angiven position
            Parametrar: position - En position i listan
                        obj - värdet som ska in i listan
            Returvärde: Positionen för det insatta elemenet
            Kommentarer: Odefinierat vad som händer för en felaktig position
        """        
        if (position < 0) or (position >  self._endpos):
            raise MethodNotDefinedForThisPositionError("Error in insert")         
        if not self.isempty():
            for i in range(self._endpos, position, -1):
                self._values[i] = self._values[i-1]
        
        self._values[position] = obj
        self._endpos = self._endpos + 1
            
        return position

    def isempty(self):
        """
            Syfte: Returnerar sant om listan är tom (saknar element)
            Parametrar: -
            Returvärde: Sant om listan är tom
            Kommentarer:
        """    
        return self._endpos==0

    def inspect(self,position):
        """
            Syfte: Returnerar värdet som finns på angiven position
            Parametrar: position - En position i listan
            Returvärde: Värdet som finns på angiven position
            Kommentarer: Inte definierad för listans sista position
        """    
        if position == self._endpos:
            raise MethodNotDefinedForThisPositionError("Error in inspect")          
        return self._values[position]

    def first(self):
        """
            Syfte: Returnerar listans första position
            Parametrar: -
            Returvärde: Listans första position
            Kommentarer:
        """    
        return 0

    def end(self):
        """
            Syfte: Returnerar listans sista position
            Parametrar: -
            Returvärde: Listans första position
            Kommentarer:
        """    
        return self._endpos

    def next(self,position):
        """
            Syfte: Returnerar position efter den angivna positionen
            Parametrar: position - En position i listan
            Returvärde: Positionen efter den angivna
            Kommentarer: Inte definierad för listans sista position
                        (som saknar element)
        """    
        if position == self._endpos:
            raise MethodNotDefinedForThisPositionError("Error in next")            
        return position + 1

    def previous(self,position):
        """
            Syfte: Returnerar position före den angivna positionen
            Parametrar: position - En position i listan
            Returvärde: Positionen före den angivna
            Kommentarer: Inte definierad för listans första position
        """    
        return position - 1

    def remove(self,position):
        """
            Syfte: Tar bort elementet på den angivna positionen 
            Parametrar: position - En position i listan
            Returvärde: Positionen på elementet direkt efter det som togs bort
            Kommentarer: Är inte definierad för listans sista position
                        (som saknar element)
        """    
        if position == self._endpos:
            raise MethodNotDefinedForThisPositionError("Error in remove")  
        for i in range(position, self._endpos):
            self._values[i] = self._values[i+1]
        
        self._endpos = self._endpos - 1
        return position
    
