# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

"""
Datatypen 2-Cell enligt definitionen på sidan 77 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7

Implementationen avviker så tillvida att link1 kallas prev och link2 kallas next
eftersom cellen främst ska användas i listor och det underlättar läsandet av koden.

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

"""
class TwoCell:
    def __init__(self):
        """
            Syfte: Skapar en ny cell utan definierat värde eller länkar
            Parametrar: -
            Returvärde: -
            Kommentarer: I definitionen heter denna funktion Create
        """
        self._data = None
        self._prev = None
        self._next = None

    def setValue(self,data):
        """
            Syfte: Sätter cellens värde till data
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        self._data = data

    def setPrev(self,link):
        """
            Syfte: Sätter cellens prev-länk till link
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        self._prev =link

    def setNext(self,link):
        """
            Syfte: Sätter cellens next-länk till link
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        self._next =link

    def inspectValue(self):
        """
            Syfte: Returnerar cellens värde 
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        return self._data

    def inspectPrev(self):
        """
            Syfte: Returnerar cellens prev-länk 
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        return self._prev

    def inspectNext(self):
        """
            Syfte: Returnerar cellens next-länk
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        return self._next
