extends Node2D

const phoneScene = preload("res://phone.tscn")
onready var dialogueScene = preload("res://dialogue.tscn")
var phone = null
const dialogueBoxScene = preload("res://dialogue.tscn")
var commandReceived = false

func _ready():
	phoneIntro()

func _process(delta):
	pass


func phoneIntro():
	phone = phoneScene.instance()
	self.add_child(phone)
	self.move_child(phone, 0)
	phone.get_child(0).intro()
	phone.get_child(0).connect("dialogue", self, "dialogue")

func dialogue(dIndex):
	var d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).connect("finished", self, "returnHome")
	d.get_child(0).connect("ending1", self, "ending1")
	d.get_child(0).connect("ending2", self, "ending2")
	d.get_child(0).connect("ending3", self, "ending3")
	d.get_child(0).connect("ending4", self, "ending4")
	d.get_child(0).selectDialogue(dIndex)

func ending1():
	commandReceived = true
	$end.show()
	$end/AnimationPlayer.play("fade")
	#yield($end/AnimationPlayer, "animation_finished")
	$end/AnimationPlayer.play("slide")
	phone.queue_free()

func ending2():
	pass
func ending3():
	pass
func ending4():
	pass

func returnHome():
	if commandReceived == true:
		commandReceived = false
		$end.hide()
		phoneIntro()
		
