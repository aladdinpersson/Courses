# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

class IndexOutOFBoundaryError(Exception):
    pass
class IndexesDoNotMatchError(Exception):
    pass

"""
Datatypen Array enligt definitionen på sidan 91 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

"""
class Array(object):
    
    def __init__(self, lo = (0, ), hi = (0, )):
        """
            Syfte: Skapar ett tomt fält med elementen i lo and hi som undre och
            övre gränser på index.
            Parametrar: lo en n-tippel med undre gränser på index
                        hi en n-tippel med övre gränser på index
            Returvärde: -
            Kommentarer: I boken heter denna funktion Create.
                         Om man ska skapa en vector (dvs bara ett värde på
                         hi and lo så kom ihåg att skriva (lo_val, ) resp.
                         (hi_val, ) för att det ska bli tupler...
        """
        self._numDimensions = len(lo)
        if self._numDimensions != len(hi):
            raise IndexesDoNotMatchError
        self._low = lo
        self._high = hi
        self._numOfData = 1
        for i in range(self._numDimensions):
            self._numOfData = self._numOfData * ( hi[i] - lo[i] + 1)        
        # Skapa den interna vektorn
        self._array=[None]*self._numOfData
        # Bygg basen
        self._base = [0 for _ in range(self._numDimensions)]
        self._base[0] = 1    
        for i in range(1, self._numDimensions):
            self._base[i] = self._base[i-1]*(self._high[i-1] - self._low[i-1]+1)        

    def setValue(self, index, value):
        """
            Syfte: Sätter värdet på plats index till värdet value.
            Parametrar: index tuppel som anger platsen i arrayen
                        value värdet som ska in i arrayen
            Returvärde: -
            Kommentarer: Det är odefinierat vad som händer om index ligger
                        utanför tillåtet intervall
        """
        ii = self._getInternalIndex(index)
        self._array[ii] = value

    def _getInternalIndex(self, index):
        """
            Syfte: Omvandlar indexet som ges som en tupel till ett internt index
            Parametrar: index tuppel som anger platsen i arrayen
            Returvärde: index i den interna arrayen
            Kommentarer: Detta är en intern funktion som ej ska användas utanför klassen
        """


        # Skapa index
        internalIndex = 0
        for i in range(self._numDimensions):
            if (index[i] < self._low[i]) or (index[i] > self._high[i]):
                        raise IndexOutOFBoundaryError             
            internalIndex = internalIndex + (index[i]-self._low[i])*self._base[i]            
        return internalIndex 
    
    

    def low(self):
        """
            Syfte: Ger de lägre indexgränserna för arrayen
            Parametrar: 
            Returvärde: En tupel med mingränserna för arrayen
            Kommentarer: 
        """
        return self._low
    
    def high(self):
        """
            Syfte: Ger de högre indexgränserna för arrayen
            Parametrar: 
            Returvärde: En tupel med maxgränserna för arrayen
            Kommentarer: 
        """
        return self._high

    def hasValue(self, index):
        """
            Syfte: Returnerar sant om värdet på plats index i arrayen är satt (med setValue)
            Parametrar: index tuppel som anger platsen i arrayen
            Returvärde: -
            Kommentarer: Det är odefinierat vad som händer om index ligger
                        utanför tillåtet intervall
        """
        return self._array[self._getInternalIndex(index)] != None

    def inspectValue(self, index):
        """
            Syfte: Ger värdet på plats index i arrayen
            Parametrar: index tuppel som anger platsen i arrayen
            Returvärde: värdet på angiven plats
            Kommentarer: Det är odefinierat vad som händer om index ligger
                        utanför tillåtet intervall
        """
        return self._array[self._getInternalIndex(index)]
