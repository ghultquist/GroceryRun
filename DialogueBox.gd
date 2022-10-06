extends Control

var dialoguePath = "res://dialogue.json"
var dialogueDict = {}
var dialogue = []
var selection 

var dialogueIndex = 0
var phraseIndex = 0
var finished = false
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
	var dialogueSelectDict : Dictionary = dialogueDict[selection]
	dialogue = dialogueSelectDict["text"]
	setDialogue()

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
	else:
		dialogue = []
		queue_free()
		finished = true
