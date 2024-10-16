extends Node2D

var groceries = ["bean", "peas", "eggs", "feta", "soup", "corn", "pear", "rice", "lime"]
var labels = [$letter0, $letter1, $letter2, $letter3]
var alphabet = "abcdefghijklmnopqrstuvwxyz"


func _ready():
	randomize()
	var groceries = ["bean", "peas", "eggs", "feta", "soup", "corn", "pear", "rice", "lime"]
	var labels = [$letter0, $letter1, $letter2, $letter3]
	var alphabet = "abcdefghijklmnopqrstuvwxyz"
	var item = groceries[randi() % len(groceries)-1]
	var guess = ""
	var guessnum = 0
	
	var labelindex = 0
	var label0index = 0
	var label1index = 0
	var label2index = 0
	var label3index = 0
	
	var letter0_list = []
	var letter1_list = []
	var letter2_list = []
	var letter3_list = []
	var letter_lists = [letter0_list, letter1_list, letter2_list, letter3_list]
	
	var list_index = 0
	for letters in letter_lists:
		letters.append(item[list_index])
		while len(letters) < 5:
			var choice = alphabet[randi() % len(alphabet)-1]
			if letters.has(choice) == false:
				letters.append(choice)
		letters.shuffle()
		list_index +=1
	
	print(letter_lists)
	print(item)
	labels[0].bbcode_text = letter_lists[0][0]




func _on_down_pressed():
	labels[0].bbcode_text = letter_lists[0][0]


func _on_up_pressed():
	pass # Replace with function body.


func _on_submit_pressed():
	pass # Replace with function body.
