# -*- coding: utf-8 -*-

# Purpose of this code is to implement the abstract datatype table using
# datatype array.

# Programmed by Aladdin Persson <aladdin.persson@umu.se>
#    2019-02-13 Initial programming

from Array import Array

class ArrayTable:

    def __init__(self, highval=1000):
        """
            Syfte: Skapar en tom tabell med hjälp av en array
            Returvärde: -
            Kommentarer: -
        """

        # Sätt alltid undre index till 0. Övregräns kan ändras.
        self._table = Array(lo = (0, ), hi = (highval, ))
        self.lastpos = -1

    def insert(self, key, obj):
        """
            Syfte: utökar eller omdefinierar tabellen så att nyckeln key kopplas
                   till värdet obj
            Returvärde: -
            Kommentarer: -
        """

        # Försök alltid ta bort key:n först och sedan lägg in. Vill ej ha flera
        # element med samma key!
        self.remove(key)
        
        self._table.setValue((self.lastpos + 1, ), (key, obj))
        self.lastpos += 1

    def isempty(self):
        """
            Syfte: Testar om tabellen är tom
            Returvärde: Returnerar sant om tabellen är tom, annars falsk
            Kommentarer:
        """
        return self.lastpos == -1

    def lookup(self, key):
        """
            Syfte: Ser efter om tabellen innehåller nyckeln key och returnerar
                   i så fall värdet som är kopplat till nyckeln
            Returvärde: Returnerar en tuppel (True, obj) där obj är värdet som
                   är kopplat till nyckeln om nyckeln finns och annars (False, None)
            Kommentarer: -
        """
        i = 0
        found = False

        while found != True and i <= self.lastpos:
            val = self._table.inspectValue((i,))

            # First runs first part of if statement, if its not None then tuple
            if val != None and val[0] == key:
                (newKey, newValue) = val
                return (True, newValue)

            i += 1

        return (False, None)

    def remove(self, key):
        """
            Syfte: Tar bort nyckeln key och dess sammankopplade värde.
            Returvärde: -
            Kommentarer: Om nyckeln inte finns så händer inget med tabellen
        """
        i = 0
        found = False
        
    
        while found != True and i <= self.lastpos:
            val = self._table.inspectValue((i,))

            # First runs first part of if statement, if its not None then tuple
            if val != None and val[0] == key:
                last_tuple = self._table.inspectValue((self.lastpos,))
                self._table.setValue( (i,), last_tuple)
                self.lastpos -= 1

            i += 1