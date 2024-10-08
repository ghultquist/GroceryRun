extends Node

const phoneScene = preload("res://phone.tscn")
const jumpinglizard = preload("res://jumpinglizard.tscn")
const world = preload("res://world.tscn")

onready var dialogueScene = preload("res://dialogue.tscn")
var phone = null
const dialogueBoxScene = preload("res://dialogue.tscn")
var commandReceived = false
var current_scene
var d

signal dialogue_finished

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
	d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).connect("ending", self, "ending")
	d.get_child(0).connect("goto", self, "goto")
	#d.get_child(0).connect("next", self, "dialogue")
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
	$end/AnimationPlayer.play("fade")#currently not fading in correctly check animation
	if d.get_child(0):
		yield(d.get_child(0), "finished")
	$end/AnimationPlayer.play_backwards("fade")
	if current_scene == "phone":
		phone.queue_free()
	if scene == "phone":
		sceneLoad = phone.instance()
	elif scene == "jumpinglizard":
		sceneLoad = jumpinglizard.instance()
	elif scene == "world":
		sceneLoad = world.instance()
	current_scene = scene
	self.add_child_below_node($Stats, sceneLoad)
	sceneLoad.connect("dialogue", self, "dialogue")
	sceneLoad.connect("goto", self, "goto")



func phoneHome():
	if commandReceived == true:
		commandReceived = false
		$end/AnimationPlayer.play_backwards("fade")
		$end.hide()
		phoneIntro()
		
func dialogueEnd():
	get_tree().get_root().find_node("Player", true, false).can_move = true
	emit_signal("dialogue_finished")
