extends Node2D
const dialogueBoxScene = preload("res://dialogue.tscn")
var d


func _ready():
	$"bg-cyclop/AnimationPlayer".play("cyclop")
	$"bg-ghost/AnimationPlayer".play("ghost")
	$"Player/Camera2D".zoom.x = .8
	$"Player/Camera2D".zoom.y = .8

func _on_left_body_entered(body):
	dialogue("001")

func _on_right_body_entered(body):
	dialogue("002")

func dialogue(index):
	d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).selectDialogue(index)
