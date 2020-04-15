# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

from Array import Array

class EmptyQueueError(Exception):
    pass

class FullQueueError(Exception):
    pass

"""
Datatypen Kö enligt definitionen på sidan 155 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

Denna klass implementerar kö med hjälp av en array
"""
class QueueArray:

    def __init__(self):
        """
            Syfte: Skapar en tom kö med hjälp av en Array
            Returvärde: -
            Kommentarer: I boken heter denna funktion Empty. 

        """	        
        self._MAX = 20
        self._array = [ None for i in range(self._MAX)] 
        self._head = 0
        self._tail = self._MAX - 1
        self._count= 0
       

    def front(self):
        """
            Syfte: Ger värdet av det första elementet i kön
            Returvärde: Värdet först i kön
            Kommentarer: Ej definierad för tom stack
        """	        
        if self.isempty():
            raise EmptyQueueError("Error in front")  
        return self._array[self._head]

    def enqueue(self, obj):
        """
            Syfte: Lägger ett element med värdet obj längst bak i kön
            Returvärde: -
            Kommentarer: När kön är implementerad som en array kan den bli full
        """        
        if self._count == self._MAX:
            raise FullQueueError("Error in enqueue")
        self._tail = self._tail + 1
        if self._tail == self._MAX:
            self._tail = 0
        self._array[self._tail] = obj
        self._count += 1

    def dequeue(self):
        """
            Syfte: Tar bort första värdet i kön
            Returvärde: -
            Kommentarer: Ej definierad för tom kö
        """	        
        if self.isempty():
            raise EmptyQueueError("Error in dequeue")  
        result = self._array[self._head]
        self._array[self._head] = None
        self._head = self._head + 1
        if self._head == self._MAX:
            self._head = 0
        self._count -= 1
        return result

    def isempty(self):
        """
            Syfte: Testar om kön är tom
            Returvärde: Sant om kön är tom, annars falskt
            Kommentarer: 
        """        
        return self._count == 0

