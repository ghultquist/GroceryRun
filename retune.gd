extends Node2D

var groceries = ["bean", "peas", "eggs", "feta", "soup", "corn", "pear", "rice", "lime"]
var alphabet = "abcdefghijklmnopqrstuvwxyz"
var animations = ["static4layers","static3layers", "static2layers", "static1layer", "staticoff"]
const world = "res://world.tscn"

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
var item_image
var labels
var timelost = 3


func _ready():
	randomize()
	$face.hide()
	Hud.get_child(0).guide_text("[right]Click on up and down buttons to change the active letter. \nPress PWR button to submit guess.[/right]")
	labels = [$letter0, $letter1, $letter2, $letter3]
	#Choosing item to guess
	item = groceries[randi() % len(groceries)-1]
	item_image = "res://Assets/retuning/" + item + ".png"
	$good.hide()
	$bad.hide()
	$food.show()
	$food.texture = load(item_image)
	$thoughts.bbcode_text = "Agh, what did I need again..."
	$thoughts/AnimationPlayer.play("bounce")
	
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

#FIX LATER TO USE ARROW KEYS
func _on_submit_pressed():
	if index < 4:
		if letter_lists[index][indexes[index] % 5] == item[index]:
			index += 1
			if index < 4:
				labels[index].bbcode_text = letter_lists[index][indexes[index] % 5]
			else:
				$StaticPlayer.play("staticoff")
				yield($StaticPlayer, "animation_finished")
				$thoughts.bbcode_text = "Oh yeah... I'll add it to the list"
				$thoughts/AnimationPlayer.play("bounce")
				yield($thoughts/AnimationPlayer, "animation_finished")
				Stats.time -= timelost
				get_tree().change_scene(world)
			$StaticPlayer.play("static2layers")
		else:
			timelost += 1
			$thoughts.bbcode_text = "I don't think so..."
			$thoughts/AnimationPlayer.play("bounce")
		guessnum +=1
