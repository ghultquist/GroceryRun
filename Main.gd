extends Node2D

const phoneScene = preload("res://phone.tscn")
onready var dialogueScene = preload("res://dialogue.tscn")
var phone = null
var dialogue = null


func _ready():
	phoneIntro()

func _process(delta):
	pass


func phoneIntro():
	phone = phoneScene.instance()
	self.add_child(phone)
	phone.get_child(0).intro()
	phone.get_child(0).connect("ending1", self, "ending1")

func ending1():
	$end.show()
	$end/AnimationPlayer.play("fade")
	$end.hide()
	phoneHome()

func phoneHome():
	phone = phoneScene.instance()
