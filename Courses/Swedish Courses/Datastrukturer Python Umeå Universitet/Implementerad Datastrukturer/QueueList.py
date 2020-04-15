# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

from ListTwoCell import ListTwoCell

class EmptyQueueError(Exception):
    pass

"""
Datatypen Kö enligt definitionen på sidan 155 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

Denna klass implementerar kö med hjälp av en lista (som är implementerad med 
en 2-cell.
"""
class QueueList:

    def __init__(self):
        """
            Syfte: Skapar en tom kö med hjälp av en lista
            Returvärde: -
            Kommentarer: I boken heter denna funktion Empty. 
        """		
        self._list = ListTwoCell()

    def front(self):
        """
            Syfte: Ger värdet av det första elementet i kön
            Returvärde: Värdet först i kön
            Kommentarer: Ej definierad för tom stack
        """	
        if self.isempty():
            raise EmptyQueueError("Error in front")  	
        return self._list.inspect(self._list.first())

    def enqueue(self, obj):
        """
            Syfte: Lägger ett element med värdet obj längst bak i kön
            Returvärde: -
            Kommentarer: 
        """	
        self._list.insert(self._list.end(), obj)

    def dequeue(self):
        """
            Syfte: Tar bort första värdet i kön
            Returvärde: -
            Kommentarer: Ej definierad för tom kö
        """	
        if self.isempty():
            raise EmptyQueueError("Error in dequeue")  
        self._list.remove(self._list.first())

    def isempty(self):
        """
            Syfte: Testar om kön är tom
            Returvärde: Sant om kön är tom, annars falskt
            Kommentarer: 
        """		
        return self._list.isempty()
