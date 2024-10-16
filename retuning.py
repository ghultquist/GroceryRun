import random

groceries = ["bean", "peas", "eggs", "feta", "soup", "corn", "pear", "rice", "lime"]

item = random.choice(groceries)

guess = ""

index = 0
guessnum = 0

while guess != item:
    print(guess + ((len(item)-index) * "_ "))
    letter = input("Letter:").lower()
    if letter == item[index]:
        guess += letter
        index += 1
    guessnum += 1

print(item)
print(guessnum)
