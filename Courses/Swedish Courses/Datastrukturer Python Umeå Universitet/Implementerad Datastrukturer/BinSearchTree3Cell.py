# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

"""
Datatypen Binärt sökträd nästan enligt definitionen på sidan 287 i Lars-Erik 
Janlert, Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7 

Det som skiljer är att insertLeft och insertRight har tagits bort ut ytan och 
satts med en funktion place som placerar in noden på korrekt ställe.

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

Denna klass implementerar ett Binärt sökträd med hjälp av ett 3-cell.
"""
from ThreeCell import ThreeCell 

class BinSearchTree3Cell: 
    
    def __init__(self, val, cmpFcn):
        """
            Syfte: Skapar en tomt binärt sökträd
            Pararmetrar: val - rotens värde
                         cmpFcn - jämförelsefunktionen som används i trädet
            Returvärde: 
            Kommentarer: Ett tomt binärt sökträd består av en rotnod med värdet
                         val(Make)
        """ 
        self._root = ThreeCell()
        self._root.setValue(val)
        self._cmpFcn = cmpFcn
      
    def place(self, val):
        """
            Syfte: Sätter in ett nytt värde val på rätt ställe i trädet.
            Parametrar: val - värdet som ska sättas in
            Returvärde: Returnerar positionen för den nya noden.
            Kommentarer: 
        """
        placed = False
        pos = self._root
        while not placed:
            if self._cmpFcn(pos.inspectValue(), val):
                if self.hasRightChild(pos):
                    pos = self.rightChild(pos)
                else:
                    placed = True
                    newCell = ThreeCell()
                    newCell.setValue(val)
                    newCell.setParent(pos)
                    pos.setRight(newCell)   
            else:
                if self.hasLeftChild(pos):
                    pos = self.leftChild(pos)
                else:
                    placed = True
                    newCell = ThreeCell()
                    newCell.setValue(val)
                    newCell.setParent(pos)
                    pos.setLeft(newCell)                

    def isempty(self):
        """
            Syfte: Testar om det binära trädet är tomt
            Returvärde: Returnerar sant om trädet är tomt, annars falskt
            Kommentarer: Ett tomt träd består av en tom rotnod
        """        
        return self._root.inspectValue == None and self._root.inspectRight == None and self._root.inspectLeft == None and self._root.inspectParent == None
                
    def hasLeftChild(self, pos):
        """
            Syfte: Kontrollerar om det finns ett barn till vänster om positionen pos
            Parametrar: pos - positionen som kontrolleras
            Returvärde: True och det finns ett barn till vänster, annars false
            Kommentarer: 
        """
        return pos.inspectLeft() != None
    
    def hasRightChild(self, pos):
        """
            Syfte: Kontrollerar om det finns ett barn till höger om positionen pos
            Parametrar: pos - positionen som kontrolleras
            Returvärde: True och det finns ett barn till höger, annars false
            Kommentarer: 
        """    
        return pos.inspectRight() != None

    def inspectLabel(self, pos):
        """
            Syfte: Returnerar värdet i noden på positionen pos
            Parametrar: pos - positionen som kontrolleras
            Returvärde: Värdet på positionen pos
            Kommentarer: Odefinierat vad som händer om det inte finns ett värde 
                         på angiven position
        """    
        return pos.inspectValue()

    def root(self):
        """
            Syfte: Returnerar positionen för roten
            Parametrar: 
            Returvärde: Positionen för roten
            Kommentarer: 
        """ 
        return self._root

    def leftChild(self, pos):
        """
            Syfte: Ger positionen till barnet till vänster om positionen pos
            Parametrar: pos - positionen som kontrolleras
            Returvärde: Ger positionen till barnet till vänster om positionen pos
            Kommentarer: Odefinierat vad som händer om det inte finns ett barn till vänster
        """
        return pos.inspectLeft()
    
    def rightChild(self, pos):
        """
            Syfte: Ger positionen till barnet till höger om positionen pos
            Parametrar: pos - positionen som kontrolleras
            Returvärde: Ger positionen till barnet till höger om positionen pos
            Kommentarer: Odefinierat vad som händer om det inte finns ett barn till höger
        """
        return pos.inspectRight()
    
    def _findMin(self, pos):
        """
            Syfte: Letar reda på positionen för det minsta elementet i trädet som 
                har pos som rot.
            Parametrar: pos - roten i delträdet vi ska hitta min i.
            Returvärde: Ger positionen till det minsta elementet
            Kommentarer:
        """        
        min = pos.inspectValue()
        minpos = pos
        while pos.inspectLeft() != None:
            pos = self.leftChild(pos)
            if self._cmpFcn(pos.inspectValue(), min):
                min = minpos.inspectValue()
                minpos = pos
        return minpos
        
    def deleteNode(self, pos):
        """
            Syfte: Tar bort noden på angiven position
            Parametrar: pos - positionen som ska bort
            Returvärde: Ger positionen till föräldern till positionen pos
            Kommentarer: Förutsätts att trädet inte är tomt och att det finns en 
                         nod på angiven position 
        """
        
        # Finns det både ett barn till vänster och ett till höger?
        if pos.inspectLeft() != None and pos.inspectRight() != None:
            # Välj det minsta enligt gällande ordning från höger delträd som 
            #  ersättning. 
            oldPos = pos
            minpos = self._findMin(self.rightChild(pos))
            oldPos.setValue(minpos.inspectValue())
            if minpos.inspectLeft() == None and minpos.inspectRight() == None:
                parent = minpos.inspectParent()
                if parent.inspectRight() == minpos:
                    parent.setRight(None) 
                else:
                    parent.setLeft(None)
            else:
                self.deleteNode(minpos)                
        elif pos.inspectRight() != None:
            # Flytta upp höger delträd ett snäpp
            parent = pos.inspectParent()
            if parent == None:
                # Vi är i roten
                self._root = pos.inspectRight()  
                pos.inspectRight().setParent(None)        
            elif parent.inspectRight() == pos:
                parent.setRight(pos.inspectRight())                
            else:    
                parent.setLeft(pos.inspectRight()) 
            pos.inspectRight().setParent(parent)
        elif pos.inspectLeft() != None:
            # Flytta upp vänster delträd ett snäpp
            parent =pos.inspectParent()
            if parent == None:
                # Vi är i roten
                self._root = pos.inspectLeft() 
                pos.inspectLeft().setParent(None)
            elif parent.inspectRight() == pos:
                parent.setRight(pos.inspectLeft())
            else:    
                parent.setLeft(pos.inspectLeft())   
                
