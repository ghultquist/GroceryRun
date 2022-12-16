extends Control

signal finished

var dialoguePath = "res://dialogue.json"
var dialogueSelectDict = {}
var dialogueDict = {}
var dialogue = []
var choicesDict = {}
var choice1Dict
var choice2Dict
var selection 

var dialogueIndex = 0
var phraseIndex = 0
var finished = true
var phrasefinished = false
var textSpeed = 0.05

func _ready():
	$Timer.wait_time = textSpeed
	loadDialogue(dialoguePath)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if phrasefinished == true:
			setDialogue()

func loadDialogue(filePath):
	var file = File.new()
	assert(file.file_exists(filePath))
	
	file.open(filePath, file.READ)
	dialogueDict = parse_json(file.get_as_text())

func selectDialogue(selection):
	dialogueSelectDict = dialogueDict[selection]
	dialogue = dialogueSelectDict["text"]
	choicesDict = dialogueSelectDict["choices"]
	if dialogue != []:
		setDialogue()
	elif choicesDict != {}:
		setChoices()

func setChoices():
	choice1Dict = choicesDict["choice1"]
	choice2Dict = choicesDict["choice2"]
	$choice1/choiceText.bbcode_text = choice1Dict["text"]
	$choice2/choiceText.bbcode_text = choice2Dict["text"]
	$choice1.show()
	$choice2.show()

func _on_choice1_pressed():
	selectDialogue(choice1Dict["next"])
func _on_choice2_pressed():
	selectDialogue(choice2Dict["next"])
	
func setDialogue():
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
		dialogue = []
		dialogueSelectDict = {}
		choicesDict = {}
		choice1Dict = {}
		choice2Dict = {}
		queue_free()
		finished = true







