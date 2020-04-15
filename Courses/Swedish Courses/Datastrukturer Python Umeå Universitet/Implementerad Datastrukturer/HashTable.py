# -*- coding: latin-1 -*-

#Written by Lena Kallin Westin <kallin@cs.umu.se>.
#May be used in the course Datastrukturer och Algoritmer (Python) at Umeå University.
#Usage exept those listed above requires permission by the author.

"""
Datatypen HashTabell 

Variabler och funktioner som inleds med ett enkelt underscore "_" är privata
för klassen och ska inte användas av de som använder denna klass.

Denna klass implementerar en hashtabell med hjälp av den inbyggda listan
"""
class HashTable: 
    
    def _internalHash(self,key):
        """
            Intern function, ej för externt bruk
        """
        return self._hashFcn(key) % self._size
    

    def _rehash(self):
        """
            Intern function, ej för externt bruk
        """
        temp = self._data
        oldsize = self._size
        self._data = []
        self._size = oldsize*2
        self._numElem = 0
        self._numInsertions=0
        for i in range(oldsize):
            if(temp[i]):
                hashtable_insert(self_table, temp[i])
  
    def __init__(self, size, hashFcn, cmpFcn):
        """
            Syfte: Skapar en tom hashtabell med hjälp av den inbyggda listan
            Pararmetrar: 
                size -    startstorlek på tabellen och ska vara ca 2*uppskattat 
                          antal element som ska stoppas in. Storleken ökar 
                          automatiskt men den operationen är dyr.
                hashFcn - en funktion som beräknar ett hashvärde från en 
                          nyckel. Returvärdet från funktionen ska vara ett 
                          positivt heltal. Värdet kommer internt att omvandlas 
                          till området [0, size]
                cmpFcn -  en funktion som jämför två nycklar. Ska returnera 
                          False för nycklar som inte är lika och annars True
            Returvärde: 
            Kommentarer: 
        """ 
        self._cmpFcn = cmpFcn
        self._hashFcn = hashFcn
        self._size = size
        self._data = [None]*self._size
        self._numelem = 0
        self._numinsertions = 0
      
    def insert(self, key, obj):
        """
            Syfte: utökar eller omdefinierar tabellen så att nyckeln key kopplas 
                   till värdet obj
            Returvärde: -
            Kommentarer: -  
        """
        if(self._numinsertions >= self._size/2):
            self._rehash()
        index = self._internalHash(key)
        while (self._data[index] != None) and (self._data[index] != (None, None) and not self._cmpFcn(self._data[index][0],key)):
            index = (index + 1) % self._size
        if (self._data[index] == None):
            self._numelem = self._numelem + 1
            self._numinsertions = self._numinsertions + 1
        
        self._data[index] = (key, obj)
        
    def isempty(self):
        """
            Syfte: Testar om hashtabellen är tom
            Returvärde: Returnerar sant om tabellen är tom, annars falsk
            Kommentarer: 
        """        
        return self._numelem == 0
        
    def lookup(self, key):
        """
            Syfte: Ser efter om hashtabellen innehåller nyckeln key och returnerar
                   i så fall värdet som är kopplat till nyckeln
            Parametrar: key - nyckeln
            Returvärde: Returnerar en tuppel (True, obj) där obj är värdet som 
                   är kopplat till nyckeln om nyckeln finns och annars (false, None)
            Kommentarer: Om kön är tom returneras (False, None)
        """
        index = self._internalHash(key)
        while (self._data[index] != None) and (self._data[index] != (None, None) and not self._cmpFcn(self._data[index][0],key)):
               index = (index + 1) % self._size
        if self._data[index] != None:
            return (True, self._data[index][1])
        return (False, None)
        
    def remove(self, key):
        """
            Syfte: Tar bort nyckeln key och dess sammankopplade värde.
            Returvärde: -
            Kommentarer: Om nyckeln inte finns så händer inget med tabellen            
        """        
        index =self._internalHash(key)
        while (self._data[index] != None) and (self._data[index] != (None, None) and not self._cmpFcn(self._data[index][0],key)):
            index = (index + 1) % self._size
        if(self._data[index] != None):
            self._data[index] = (None, None)
            self._numelem = self._numelem - 1
    
  
