# -*- coding: utf-8 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Ume� University.
#Usage exept those listed above requires permission by the author.

"""
Datatypen 1-Cell enligt definitionen på sidan 77 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

"""
class OneCell:
    def __init__(self):
        """
            Syfte: Skapar en ny cell utan definierat värde eller länk
            Parametrar: -
            Returvärde: -
            Kommentarer: I definitionen heter denna funktion Create
        """
        self._data = None
        self._link = None

    def setValue(self,data):
        """
            Syfte: Sätter cellens värde till data
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        self._data = data

    def setLink(self,link):
        """
            Syfte: Sätter cellens länk till link
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        self._link =link

    def inspectValue(self):
        """
            Syfte: Returnerar cellens värde 
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        return self._data

    def inspectLink(self):
        """
            Syfte: Returnerar cellens länk 
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        return self._link
