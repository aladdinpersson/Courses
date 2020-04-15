# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>. Modified by Johan Eliasson
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

"""
Datatypen Prioritetskö enligt definitionen på sidan 293 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7 

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

Denna klass implementerar en prioritetskö med hjälp av DirectedList
"""
from DirectedList import DirectedList

class PrioQueueDirectedList:
    def __init__(self, cmpFcn):
        """
            Syfte: Skapar en tom prioritetskö
            Pararmetrar: cmpFcn - en jämförelsefunktion som returnerar True/False
            Returvärde: 
            Kommentarer: Ett tom prioritetskö, funktionen heter Empty i specifikationen
        """   
        self._cmpFcn = cmpFcn
        self._queue = DirectedList()
        
    def insert(self, val):
        """
            Syfte: Stoppar in ett element med värde val i prioritetskön
            Pararmetrar: val - värdet som ska in i prioritetskön
            Returvärde: 
            Kommentarer: 
        """      
        if self._queue.isempty():
            self._queue.insert(self._queue.first(), val)
        else:
            placed = False
            pos = self._queue.first()
            while not placed and not self._queue.isEnd(pos):
                if self._cmpFcn(val, self._queue.inspect(pos)):
                    placed = True;
                    self._queue.insert(pos, val)
                pos = self._queue.next(pos)   
            if not placed:
                self._queue.insert(pos, val)

    def isEmpty(self):
        """
            Syfte: Kollar om prioritetskön är tom
            Pararmetrar: 
            Returvärde: True om prioritetskön är tom, annars False
            Kommentarer: 
        """  
        return self._queue.isempty()
    
    def inspectFirst(self):
        """
            Syfte: Ger värdet av första elementet i prioritetskön
            Pararmetrar: 
            Returvärde: Värdet som är först i kön
            Kommentarer: 
        """  
        if not self._queue.isempty():
            return self._queue.inspect(self._queue.first())
        return None

    def deleteFirst(self):
        """
            Syfte: Tar bort första elementet ur prioritetskön
            Pararmetrar: 
            Returvärde: 
            Kommentarer: 
        """  
        if not self._queue.isempty():
            self._queue.remove(self._queue.first())

    def update(self, val, newVal):
        """
            Syfte: Uppdaterar värdet val som antas finnas i prioritetskön till newwal
            Pararmetrar: val - det värde som ska få ny prioritet
                         newVal - det nya värdet med ny prioritet
            Returvärde: 
            Kommentarer: Odefinierat vad som händer om inte val finns i kön. 
                         Förutsätter att värdena i kön kan jämföras med ==
        """         
        found = False
        pos = self._queue.first()
        while not found:
            if self._queue.inspect(pos) == val:
                self._queue.remove(pos)
                self.insert(newVal)
                found = True 
            pos = self._queue.next(pos)
                
