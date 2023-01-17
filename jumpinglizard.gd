extends Node2D

signal dialogue(index)

var left = false
var right = false

func _ready():
	$"bg-cyclop/AnimationPlayer".play("cyclop")
	$"bg-ghost/AnimationPlayer".play("ghost")
	$"Player/Camera2D".zoom.x = .8
	$"Player/Camera2D".zoom.y = .8

func _on_left_body_entered(body):
	emit_signal("dialogue", "101")
	left = true

func _on_right_body_entered(body):
	emit_signal("dialogue", "104")
	right = true

func _on_showtime_body_entered(body):
	if right == false and left == false:
		emit_signal("dialogue", "100")
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
