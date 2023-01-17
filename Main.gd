extends Node2D

const phoneScene = preload("res://phone.tscn")
const jumpinglizard = preload("res://jumpinglizard.tscn")

onready var dialogueScene = preload("res://dialogue.tscn")
var phone = null
const dialogueBoxScene = preload("res://dialogue.tscn")
var commandReceived = false
var current_scene

func _ready():
	phoneIntro()

func _process(delta):
	pass


func phoneIntro():
	phone = phoneScene.instance()
	self.add_child_below_node($Stats, phone)
	phone.get_child(0).intro()
	phone.get_child(0).connect("dialogue", self, "dialogue")
	current_scene = "phone"

func dialogue(dIndex):
	var d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).connect("ending", self, "ending")
	d.get_child(0).connect("goto", self, "goto")
	if current_scene == "phone":
		d.get_child(0).connect("finished", self, "phoneHome")
	elif current_scene == "jumpinglizard":
		var player = get_tree().get_root().find_node("Player", true, false)
		player.can_move = false
		player.get_child(3).play("Idle")
		d.get_child(0).connect("finished", self, "dialogueEnd")
	d.get_child(0).selectDialogue(dIndex)

func ending(specific):
	commandReceived = true
	if specific == "ending1":
		$end.show()
		$end/AnimationPlayer.play("fade")
		#yield($end/AnimationPlayer, "animation_finished")
		$end/AnimationPlayer.play("slide")
		phone.queue_free()

func goto(scene):
	var sceneLoad
	phone.queue_free()
	if scene == "jumpinglizard":
		sceneLoad = jumpinglizard.instance()
		current_scene = "jumpinglizard"
	self.add_child(sceneLoad)
	sceneLoad.connect("dialogue", self, "dialogue")



func phoneHome():
	if commandReceived == true:
		commandReceived = false
		$end/AnimationPlayer.play_backwards("fade")
		$end.hide()
		phoneIntro()
		
func dialogueEnd():
	get_tree().get_root().find_node("Player", true, false).can_move = true
