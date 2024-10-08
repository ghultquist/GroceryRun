extends Node2D

#DIALOGUE VARS
const dialogueBoxScene = preload("res://dialogue.tscn")
signal dialogue
#signal dialogue_finished
var d
var commandReceived = false

#LOCATION VARS
var ghost_entered = false
var teeth_entered = false
var circus_entered = false

func _ready():
	pass


func dialogue(dIndex):
	$Player.can_move = false
	d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).connect("ending", self, "ending")
	d.get_child(0).connect("goto", self, "goto")
	#d.get_child(0).connect("next", self, "dialogue")
	d.get_child(0).connect("finished", self, "dialogueEnd")
	d.get_child(0).selectDialogue(dIndex)

func goto(scene):
	get_tree().change_scene(scene)

func dialogueEnd():
	$Player.can_move = true
	#emit_signal("dialogue_finished")

func _on_Ghost_Area2D_body_entered(body):
	ghost_entered = true
	$Player/Camera2D/Press_Enter.show()


func _on_Ghost_Area2D_body_exited(body):
	ghost_entered = false
	$Player/Camera2D/Press_Enter.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		if ghost_entered:
			dialogue("000")
		elif teeth_entered:
			pass
		elif circus_entered:
			pass
		
