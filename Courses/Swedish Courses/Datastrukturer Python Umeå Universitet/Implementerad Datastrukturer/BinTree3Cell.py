# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

"""
Datatypen Binärt träd enligt definitionen på sidan 225 i Lars-Erik Janlert,
Torbjörn Wiberg Datatyper och algoritmer 2., [rev.] uppl.,Lund,
Studentlitteratur, 2000, x, 387 s. ISBN 91-44-01364-7 

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

Denna klass implementerar ett Binärt träd med hjälp av ett 3-cell.
"""
from ThreeCell import ThreeCell 

class BinTree3Cell: 
    
    def __init__(self):
        """
            Syfte: Skapar en tomt binärt träd
            Pararmetrar: 
            Returvärde: 
            Kommentarer: Ett tomt binärt träd består av en tom rotnod (Create)
        """ 
        self._root = ThreeCell()
      
    def insertLeft(self, pos):
        """
            Syfte: Sätter in en ny nod som vänster barn till noden i position pos.
            Parametrar: pos - positionen som ska få ett vänsterbarn
            Returvärde: Returnerar positionen för den nya noden.
            Kommentarer: Det förutsätts att det inte finns ett barn där redan.
        """
        node = ThreeCell()
        pos.setLeft(node)    
        node.setParent(pos)
        return node
    
    def insertRight(self, pos):
        """
            Syfte: Sätter in en ny nod som höger barn till noden i position pos.
            Parametrar: pos - positionen som ska få ett högerbarn
            Returvärde: Returnerar positionen för den nya noden.
            Kommentarer: Det förutsätts att det inte finns ett barn där redan.
        """
        node = ThreeCell()
        pos.setRight(node)        
        node.setParent(pos)
        return node       
    
    def setLabel(self, val, pos):
        """
            Syfte: Ändrar värdet på noden på position pos till val.
            Parametrar: pos - positionen som ska få ett värde
                        val - värdet som ska sättas in
            Returvärde: Returnerar positionen för den nya noden.
            Kommentarer: 
        """     
        pos.setValue(val)

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
        
    def hasLabel(self, pos):
        """
            Syfte: Kontrollerar om det finns ett värde i noden på positionen pos
            Parametrar: pos - positionen som kontrolleras
            Returvärde: True och det finns ett värde, annars false
            Kommentarer: 
        """    
        return pos.inspectValue() != None

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
        
    def parent(self, pos):
        """
            Syfte: Ger positionen till förälderna till positionen pos
            Parametrar: pos - positionen som kontrolleras
            Returvärde: Ger positionen till föräldern till positionen pos
            Kommentarer: Odefinierat om angiven pos är rot
        """
        return pos.inspectParent()
        
    def deleteNode(self, pos):
        """
            Syfte: Tar bort noden på angiven position
            Parametrar: pos - positionen som ska bort
            Returvärde: Ger positionen till föräldern till positionen pos
            Kommentarer: Förutsätts att trädet inte är tomt, att det finns en 
                         nod på angiven position och att den noden är ett löv.
                         Annars raderas alla noder under pos också...
        """
        
        parent =self.parent(pos)
        if parent.inspectRight() == pos:
            parent.setRight(None)
        else:    
            parent.setLeft(None)
        if pos.inspectLeft() != None:
            self.deleteNode(pos.inspectLeft())
        if pos.inspectRight() != None:
            self.deleteNode(pos.inspectRight())
        
