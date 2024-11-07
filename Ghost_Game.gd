extends Node2D


var pattern = []
var guess = []

var level = 1
var timelost = 10

const worldScene = "res://world.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	Hud.get_child(0).time_visible(false)
	Hud.get_child(0).guide_text("[right]Press Q to Leave Early[/right]")
	$Timer.wait_time = 3
	forest3()

func forest1():
	pattern = [3,2,1]
	$trees.texture = load("res://Assets/ghost_game/forest1.png")
	$tree1.set_global_position(Vector2(126,0))
	$tree2.set_global_position(Vector2(348,0))
	$tree3.set_global_position(Vector2(504,0))

func forest2():
	pattern = [1,3,2]
	$trees.texture = load("res://Assets/ghost_game/forest2.png")
	$tree1.set_global_position(Vector2(70,0))
	$tree2.set_global_position(Vector2(252,0))
	$tree3.set_global_position(Vector2(457,0))

func forest3():
	pattern = [1,2,3]
	$trees.texture = load("res://Assets/ghost_game/forest3.png")
	$tree1.set_global_position(Vector2(57,0))
	$tree2.set_global_position(Vector2(310,0))
	$tree3.set_global_position(Vector2(468,0))


func _on_tree1_pressed():
	guess.append(1)
	$knocking.bbcode_text = str(guess)

func _on_tree2_pressed():
	guess.append(2)
	$knocking.bbcode_text = str(guess)

func _on_tree3_pressed():
	guess.append(3)
	$knocking.bbcode_text = str(guess)

func _process(delta):
	if Input.is_action_just_pressed("quit"):
		Hud.get_child(0).hide_guide()
		Stats.time -= timelost
		get_tree().change_scene(worldScene)
	if len(guess) >= len(pattern):
		if guess == pattern:
			guess = []
			$knocking.bbcode_text = "Correct!"
			$fade/AnimationPlayer.play("fade")
			yield($fade/AnimationPlayer, "animation_finished")
			level += 1
			print(level)
			if level == 2:
				forest1()
			elif level == 3:
				forest2()
			else:
				$knocking.bbcode_text = "!!!"
				guess = []
				Stats.ghost_success = true
				Hud.get_child(0).hide_guide()
				Stats.time -= timelost
				get_tree().change_scene(worldScene)
			$knocking.bbcode_text = ""
			$fade/AnimationPlayer.play_backwards("fade")
		else:
			guess = []
			$knocking.bbcode_text = "Was that a growl? Laszlo didn't like that I got the pattern wrong... I'm going to give him a bit of space and restart..."
			$Timer.start()
			yield($Timer, "timeout")
			$fade/AnimationPlayer.play("fade")
			yield($fade/AnimationPlayer, "animation_finished")
			level = 1
			forest3()
			$knocking.bbcode_text = ""
			$fade/AnimationPlayer.play_backwards("fade")
