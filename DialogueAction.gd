extends Node

var dialoguePath = "res://dialogue.json"

func interact() -> void:
	var dialogue : Dictionary = loadDialogue(dialoguePath)

func loadDialogue(filePath) -> Dictionary:
	var file = File.new()
	assert(file.file_exists(filePath))
	
	file.open(filePath, file.READ)
	var dialogue = parse_json(file.get_as_text())
	assert(dialogue.size() > 0)
	return dialogue
