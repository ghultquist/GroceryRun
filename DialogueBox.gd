extends Control

signal finished
signal ending
signal goto
signal next
signal game
signal timelost

onready var stats = get_tree().get_root().find_node("Stats", true, false)
onready var main = get_tree().get_root().find_node("Main", true, false)

var dialoguePath = "res://dialogue.json"
var dialogueSelectDict = {}
var dialogueDict = {}
var dialogue = []
var choicesDict = {}
var choice1Dict
var choice2Dict
var commandDict = {}
var selection 
var portrait
var type_dialogue

var dialogueIndex = 0
var phraseIndex = 0
var finished = true
var phrasefinished = false
var textSpeed = 0.03 #0.05 is original speed

var makingChoice = false
var choice = 0
var selected = load("res://Assets/textbox_hover.png")

func _ready():
	#self.connect("next", self, "selectDialogue")
	$Timer.wait_time = textSpeed
	loadDialogue(dialoguePath)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if phrasefinished == true:
			setDialogue()
	if makingChoice == true:
		if Input.is_action_just_pressed("ui_up"):
			$choice1.set_normal_texture(selected)
			$choice2.set_normal_texture(null)
			choice = 1
			print("choice 1 selected")
		elif Input.is_action_just_pressed("ui_down"):
			$choice2.set_normal_texture(selected)
			$choice1.set_normal_texture(null)
			choice = 2
			print("choice 2 selected")
		if choice != 0:
			if Input.is_action_just_pressed("ui_accept"):
				$choice1.set_normal_texture(null)
				$choice2.set_normal_texture(null)
				selectingChoice(choice)
		

func loadDialogue(filePath):
	var file = File.new()
	assert(file.file_exists(filePath))
	
	file.open(filePath, file.READ)
	dialogueDict = parse_json(file.get_as_text())

func selectDialogue(dialogueSelection):
	clearVars()
	dialogueSelectDict = dialogueDict[dialogueSelection]
	dialogue = dialogueSelectDict["text"]
	type_dialogue = dialogueSelectDict["type"]
	portrait = "res://Assets/" + dialogueSelectDict["speaker_id"] + "_portrait.png"
	choicesDict = dialogueSelectDict["choices"]
	commandDict = dialogueSelectDict["commands"]
	if len(commandDict) != 0:
		applyEffect()
	if dialogue != []:
		setDialogue()

func applyEffect():
	print("applying effect")
	var type = commandDict["type"]
	var specific = commandDict["specific"]
	commandDict = {}
	
	emit_signal(type, specific)
	
func setChoices():
	choice1Dict = choicesDict["choice1"]
	choice2Dict = choicesDict["choice2"]
	$choice1/choiceText.bbcode_text = choice1Dict["text"]
	$choice2/choiceText.bbcode_text = choice2Dict["text"]
	$choice1.show()
	$choice2.show()
	#$arrow.hide()
	makingChoice = true

func clearVars():
	$choice1.hide()
	$choice2.hide()
	makingChoice = false
	dialogue = []
	dialogueSelectDict = {}
	choicesDict = {}
	choice1Dict = {}
	choice2Dict = {}
	choice = 0
	#$arrow.show()

func selectingChoice(choiceMade):
	phraseIndex = 0
	if choiceMade == 1:
		selectDialogue(choice1Dict["next"])
	elif choiceMade == 2:
		selectDialogue(choice2Dict["next"])
	
func setDialogue():
	if type_dialogue != "dialogue":
		$portrait.hide()
		$x_portrait.hide()
	else:
		if dialogueSelectDict["speaker_id"] == "X":
			$portrait.hide()
			$x_portrait.show()
		elif dialogueSelectDict["speaker_id"] != "dad":
			$x_portrait.hide()
			$portrait.texture = load(portrait)
			$portrait.show()
		else:
			$portrait.hide()
			$x_portrait.hide()
		
	if phraseIndex < dialogue.size():
		phrasefinished = false
		$RichTextLabel.bbcode_text = dialogue[phraseIndex]
		$RichTextLabel.visible_characters = 0
		while $RichTextLabel.visible_characters < len($RichTextLabel.text):
			$RichTextLabel.visible_characters += 1
			$Timer.start()
			yield($Timer, "timeout")
		phraseIndex += 1
		phrasefinished = true
	elif len(choicesDict) != 0:
		$RichTextLabel.bbcode_text = ""
		setChoices()
	else:
		emit_signal("finished")
		clearVars()
		queue_free()
		finished = true
		if len(commandDict) != 0:
			applyEffect()
