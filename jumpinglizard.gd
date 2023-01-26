extends Node2D

signal dialogue(index)
signal goto

var left = false
var right = false
var next 

func _ready():
	get_parent().connect("dialogue_finished", self, "dialogue_finished")
	$"bg-cyclop/AnimationPlayer".play("cyclop")
	$"bg-ghost/AnimationPlayer".play("ghost")
	$Monster.hide()
	$"Player/Camera2D".zoom.x = .8
	$"Player/Camera2D".zoom.y = .8

func _on_left_body_entered(body):
	emit_signal("dialogue", "101")
	yield(get_parent(), "dialogue_finished")
	emit_signal("dialogue", "102")
	yield(get_parent(), "dialogue_finished")
	emit_signal("dialogue", "103")	
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
	emit_signal("dialogue", "105")
	yield(get_parent(), "dialogue_finished")
	if $Player.facing_right == false:
		$Player.facing_right = true
		$Player/Sprite.flip_h = false
	$Player.can_move = false
	$Player/AnimationPlayer.play("Idle")
	$"band-singer/AnimationPlayer".play("walk")
	yield($"band-singer/AnimationPlayer", "animation_finished")
	emit_signal("dialogue", "106")
	$"band-singer/AnimationPlayer".play("singerrock")
	yield(get_parent(), "dialogue_finished")
	showstart()

func showstart():
	$"band-drummer/AnimationPlayer".play("drumrock")
	$"band-guitar/AnimationPlayer".play("guitarrock")
	$"lights-y".hide()
	$"lights-r".show()
	yield(get_tree().create_timer(3), "timeout")
	$GO.show()
	yield(get_tree().create_timer(2), "timeout")	
	$GO.hide()
	$Monster.show()
	yield(get_tree().create_timer(2), "timeout")
	$HOME.show()
	yield(get_tree().create_timer(2), "timeout")
	$HOME.hide()
	$Monster/AnimationPlayer.play("unravel")
	yield($Monster/AnimationPlayer, "animation_finished")
	emit_signal("goto", "world")

func dialogue_finished():
	pass
