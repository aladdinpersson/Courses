# -*- coding: latin-1 -*-

# PURPOSE: See if random seed generates the same random numbers up to 10000 values after seed being reset.

# Edited by Aladdin Persson <aladdin.persson@umu.se>
#  2019-02-06 - Edited some errors (made 100 numbers but loop only made 10 random out of 100), also tested += 1
#               only if they where different numbers. But should add always after comparison.

import random

seed = int(input("Skriv in ett random seed (heltal t.ex. mellan 0-1000): "))
random.seed(seed)

# Skapa en buffert för alla slumptal
mybuffer = [[10] * 100 for i in range(100)]

# Fyll mitt allokerade minne med slumptal 
for i in range(100):
   for j in range(100):
      mybuffer[i][j] = random.random()    
        
# Nu kan vi prova att se om vi får samma slumptal 
# genom att se samma randseed en gång till 
random.seed(seed)

failed = 0 
tested = 0

for i in range(100):
   for j in range(100):
      if (mybuffer[i][j] != random.random()):
         print("Olika slumptal!!! (fel?)\n")
         failed = 1

      # Oavsett om den var rätt eller inte har vi åtminstonde testat ett element!
      tested += 1

   
   # Kolla om allt gick som det skulle
   if (failed):
      print("Det här blev nog fel kanske.. \n") 
   else:
      print(f"Kollade {tested} tal och alla var korrekta hittils! \n")