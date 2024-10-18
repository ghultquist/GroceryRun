extends Node2D

var groceries = ["bean", "peas", "eggs", "feta", "soup", "corn", "pear", "rice", "lime"]
var alphabet = "abcdefghijklmnopqrstuvwxyz"
var animations = ["static4layers","static3layers", "static2layers", "static1layer", "staticoff"]

#tracking guess numbers
var guessnum = 0

#which letter is active
var index = 0

#indexes for letter selections 
var index0 = 0
var index1 = 0
var index2 = 0
var index3 = 0
var indexes = [index0, index1, index2, index3]

#lists of letter options
var letter0_list = []
var letter1_list = []
var letter2_list = []
var letter3_list = []
var letter_lists = [letter0_list, letter1_list, letter2_list, letter3_list]

var item
var labels


func _ready():
	randomize()
	$face.hide()
	labels = [$letter0, $letter1, $letter2, $letter3]
	#Choosing item to guess
	item = groceries[randi() % len(groceries)-1]
	
	#randomizing letter lists
	var list_index = 0
	for letters in letter_lists:
		letters.append(item[list_index])
		while len(letters) < 5:
			var choice = alphabet[randi() % len(alphabet)-1]
			if letters.has(choice) == false:
				letters.append(choice)
		letters.shuffle()
		list_index +=1
	
	#printing for testing
	print(letter_lists)
	print(item)
	
	#displaying first letter
	labels[index].bbcode_text = letter_lists[index][indexes[index] % 5]




func _on_down_pressed():
	indexes[index] -= 1
	labels[index].bbcode_text = letter_lists[index][indexes[index] % 5]


func _on_up_pressed():
	indexes[index] += 1
	labels[index].bbcode_text = letter_lists[index][indexes[index] % 5]


func _on_submit_pressed():
	if index < 4:
		if letter_lists[index][indexes[index] % 5] == item[index]:
			index += 1
			if index < 4:
				labels[index].bbcode_text = letter_lists[index][indexes[index] % 5]
			else:
				print("You got it!")
				$face.show()
				$face/AnimationPlayer.play("bounce")
			$StaticPlayer.play(animations[index])
		else:
			print("Not quite...")
		guessnum +=1
