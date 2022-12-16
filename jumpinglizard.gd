extends Node2D
const dialogueBoxScene = preload("res://dialogue.tscn")
var d
var left = false
var right = false

func _ready():
	$"bg-cyclop/AnimationPlayer".play("cyclop")
	$"bg-ghost/AnimationPlayer".play("ghost")
	$"Player/Camera2D".zoom.x = .8
	$"Player/Camera2D".zoom.y = .8
	dialogue("100")

func _on_left_body_entered(body):
	dialogue("101")
	left = true

func _on_right_body_entered(body):
	dialogue("104")
	right = true

func dialogue(index):
	$Player.can_move = false
	$Player/AnimationPlayer.play("Idle")	
	d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).selectDialogue(index)
	d.get_child(0).connect("finished", self, "dialogueEnd")

func dialogueEnd():
	$Player.can_move = true


func _on_showtime_body_entered(body):
	if right == true and left == true:
		showtime()

func showtime():
	if $Player.facing_right == false:
		$Player.facing_right = true
		$Player/Sprite.flip_h = false
	$Player.can_move = false
	$Player/AnimationPlayer.play("Idle")
	$"band-singer/AnimationPlayer".play("walk")
	
	$Monster.show()
