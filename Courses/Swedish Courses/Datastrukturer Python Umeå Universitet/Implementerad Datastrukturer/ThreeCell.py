# -*- coding: latin-1 -*-
class ThreeCell:
    """
        Datatypen 3-Cell enligt definitionen på sidan 77 i Lars-Erik Janlert,
        Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
        Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7
    
        Implementationen avviker så tillvida att link1 kallas parent, link2 
        kallas left och link3 kallas right eftersom cellen främst ska användas 
        i träd och det underlättar läsandet av koden.
    
        Variabler och funktioner som inleds med ett enkelt underscore "_" är 
        privata för klassen och ska inte användas av de som använder denna klass.
    
    """
    def __init__(self):
        """
            Syfte: Skapar en ny cell utan definierat värde eller länkar
            Parametrar: -
            Returvärde: -
            Kommentarer: I definitionen heter denna funktion Create
        """
        self._data = None
        self._parent = None
        self._left = None
        self._right = None
    
    def setValue(self,data):
        """
            Syfte: Sätter cellens värde till data
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        self._data = data

    def setParent(self,link):
        """
            Syfte: Sätter cellens parent-länk till link
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        self._parent =link

    def setLeft(self,link):
        """
            Syfte: Sätter cellens left-länk till link
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        self._left =link

    def setRight(self,link):
        """
            Syfte: Sätter cellens right-länk till link
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        self._right =link

    def inspectValue(self):
        """
            Syfte: Returnerar cellens värde 
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        return self._data

    def inspectParent(self):
        """
            Syfte: Returnerar cellens parent-länk 
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        return self._parent

    def inspectLeft(self):
        """
            Syfte: Returnerar cellens left-länk
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        return self._left
    
    def inspectRight(self):
        """
            Syfte: Returnerar cellens right-länk
            Parametrar:
            Returvärde:
            Kommentarer:
        """
        return self._right    