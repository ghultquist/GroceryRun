extends Node2D

const phoneScene = preload("res://phone.tscn")
onready var dialogueScene = preload("res://dialogue.tscn")
var phone = null
var dialogue = null
const dialogueBoxScene = preload("res://dialogue.tscn")

func _ready():
	phoneIntro()

func _process(delta):
	pass


func phoneIntro():
	phone = phoneScene.instance()
	self.add_child(phone)
	phone.get_child(0).intro()
	phone.get_child(0).connect("dialogue", self, "dialogue")

func dialogue(dIndex):
	var d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).connect("ending1", self, "ending1")
	d.get_child(0).connect("ending2", self, "ending2")
	d.get_child(0).connect("ending3", self, "ending3")
	d.get_child(0).connect("ending4", self, "ending4")
	d.get_child(0).selectDialogue(dIndex)

func ending1():
	print("ending1 received on main")
	phone.queue_free()
	$end.show() #Fix ending1, maybe bring dialogue handling into Main to reduce repetition
	$end/AnimationPlayer.play("fade")
	$end.hide()
	phoneHome()

func ending2():
	pass
func ending3():
	pass
func ending4():
	pass

func phoneHome():
	phone = phoneScene.instance()
