extends Node2D


var pattern = []
var guess = []

var level = 1

const worldScene = "res://world.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	Stats.time -= 10
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

func end_game():
	get_tree().change_scene(worldScene)

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		end_game()
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
				end_game()
			$knocking.bbcode_text = ""
			$fade/AnimationPlayer.play_backwards("fade")
		else:
			$knocking.bbcode_text = "Not quite..."
			guess = []
