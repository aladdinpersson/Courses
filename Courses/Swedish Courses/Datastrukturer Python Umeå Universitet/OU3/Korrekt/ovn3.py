# -*- coding: latin-1 -*-

# Edited by Aladdin Persson <aladdin.persson@umu.se>
#   2019-02-06 Corrected an error in the code

import random

dicenames = ["ettor", "tvåor", "treor", "fyror", "femmor", "sexor"]
random.seed()

print("Detta program kastar tärning tills vi fått tre i rad")
unfinished = 1
lastdice = 0
throws = 0
count = 0

while (unfinished):
    # Simulera ett kast
    throws = throws + 1
    dice = random.randint(1, 6)
    print(f"Kast {throws} gav {dice} prickar")

    # Jämför med senaste, första if gäller aldrig första iterationen
    if (dice == lastdice):
        count += 1
    else:
        count = 0

    lastdice = dice
    unfinished = count !=  2

print("Vi fick tre stycken %s efter %d kast" % (dicenames[dice-1], throws))