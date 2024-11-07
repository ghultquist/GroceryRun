extends Node2D

const worldScene = "res://world.tscn"

var light = 6
var points = 0
var lives = 3
var red_lights = []
var can_damage = true
var gameover = false
var animations = ["pattern1", "pattern2", "pattern3", "RESET"]
var placements = [Vector2(87, 83), Vector2(-160, 83), Vector2(160, 83), Vector2(0, 83)]

var timelost = 10

func _ready():
	Hud.get_child(0).time_visible(false)
	red_lights = [$r1, $r2, $r3, $r4, $r5, $r6]
	$Timer.wait_time = 2
	$good/Sprite.hide()
	$Monster.hide()
	Hud.get_child(0).guide_text("[right]Press Q to Leave Early[/right]")
	$Player.global_position = self.global_position + Vector2(-153, 64)
	start_show()


func start_show():
	$Timer.wait_time = 2
	$Timer.start()
	yield($Timer, "timeout")
	$Player.can_move = false
	$instruct.bbcode_text = "[center]Looks like they're almost done getting set up...[/center]"
	$instruct/AnimationPlayer.play("fade")
	yield($instruct/AnimationPlayer, "animation_finished")
	$Player/AnimationPlayer.play("jl_start")
	$Timer.start()
	yield($Timer, "timeout")
	$Timer.wait_time = 1
	$Timer.start()
	$r2/r2.show()
	$Monster.show()
	$"red-hue".show()
	yield($Timer, "timeout")
	$r2/r2.hide()
	$Monster.hide()
	$"red-hue".hide()
	yield($Player/AnimationPlayer, "animation_finished")
	$instruct.bbcode_text = "[center]Ah! God it felt like everyone is looking at me... \nI think I saw something in the light...[/center]"
	$instruct/AnimationPlayer.play("aggro")
	yield($instruct/AnimationPlayer, "animation_finished")
	$instruct.bbcode_text = "[center][/center]"
	$instruct/AnimationPlayer.play("fade")
	yield($instruct/AnimationPlayer, "animation_finished")
	showtime()

#HIDE N SEEK?? Red lights & monster??
#"All I need to do is hype up my bro for one song... I used to do it all the time! What's different now? Tonight's been weird... and I don't know anyone here except Teeth who's on stage...
#2 sets of lights Lincoln suggestion

func showtime():
	$Player/AnimationPlayer.play("Idle")
	$light_animation.play("showstart")
	yield($light_animation, "animation_finished")
	$"band-singer/AnimationPlayer".play("walk")
	yield($"band-singer/AnimationPlayer", "animation_finished")
	$instruct.bbcode_text = "[center]WE'RE PEPPERONI TONY & THE PIZZA PALS![/center]"
	$instruct/AnimationPlayer.play("fade")
	$"band-singer/AnimationPlayer".play("singerrock")
	yield($instruct/AnimationPlayer, "animation_finished")
	$light_animation.play_backwards("showstart")
	$instruct.bbcode_text = "[center][b]DELIVERY![/b][/center]"
	$instruct/AnimationPlayer.play("aggro")
	yield($instruct/AnimationPlayer, "animation_finished")
	$"band-drummer/AnimationPlayer".play("drumrock")
	$"band-guitar/AnimationPlayer".play("guitarrock")
	$Player.can_move = true
	Hud.get_child(0).guide_text("[right]Press Q to Leave Early[/right]")
	game_level()
	

func game_level():
	$light_animation.play("RESET")
	print(points)
	$good/good_CS.set_deferred("disabled", true)
	$good.global_position = self.global_position + placements[points]
	$good/good_CS.set_deferred("disabled", false)
	$good/Sprite.show()
	$light_animation.play(animations[points])

func reset_level():
	Hud.get_child(0).guide_text("[right]Press Q to Leave Early[/right]")
	light = 6
	points = 0
	lives = 3
	red_lights = []
	can_damage = true
	gameover = false
	$Player/AnimationPlayer.play("Idle")
	$Player.global_position = self.global_position + Vector2(-153, 64)
	game_level()
	


func _on_r1_body_entered(body):
	light = 0


func _on_r1_body_exited(body):
	light = 6


func _on_r2_body_entered(body):
	light = 1


func _on_r2_body_exited(body):
	light = 6


func _on_r3_body_entered(body):
	light = 2


func _on_r3_body_exited(body):
	light = 6


func _on_r4_body_entered(body):
	light = 3


func _on_r4_body_exited(body):
	light = 6


func _on_r5_body_entered(body):
	light = 4


func _on_r5_body_exited(body):
	light = 6


func _on_r6_body_entered(body):
	light = 5


func _on_r6_body_exited(body):
	light = 6

func _on_good_body_entered(body):
	points += 1
	$good/Sprite.hide()
	if points >= 3:
		$instruct.bbcode_text = "[center]NICE MOVES![/center]"
		$instruct/AnimationPlayer.play("fade")
		yield($instruct/AnimationPlayer, "animation_finished")
		Stats.teeth_success = true
		Hud.get_child(0).hide_guide()
		Stats.time -= timelost
		get_tree().change_scene(worldScene)
	else:
		$instruct.bbcode_text = "[center]Changing up the tempo![/center]"
		$instruct/AnimationPlayer.play("fade")
		yield($instruct/AnimationPlayer, "animation_finished")
		game_level()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and gameover:
		reset_level()
	if Input.is_action_just_pressed("quit"):
		Stats.time -= timelost
		get_tree().change_scene(worldScene)
		
	if light < red_lights.size() and can_damage:
		if red_lights[light].get_child(0).visible:
			$light_animation.stop()
			can_damage = false
			$"red-hue".show()
			$Monster.show()
			var light_x = red_lights[light].get_child(1).global_position.x
			var light_y = red_lights[light].get_child(1).global_position.y + 30
			$Monster.global_position = Vector2(light_x, light_y)
			lives -= 1
			print("ouch!")
			timelost += 1
			$Player.can_move = false
			if lives <= 0:
				Hud.get_child(0).hide_guide()
				$Monster/AnimationPlayer.play("unravel")
				yield($Monster/AnimationPlayer, "animation_finished")
				$instruct.bbcode_text = "[center]I can't be here right now... I need to step outside for a minute...\n[Press ENTER to take a breath and go back in or Q to call to leave][/center]"
				$AnimationEnd.play("fadeout")
				gameover = true
			else:
				$Timer.start()
				yield($Timer, "timeout")
				$light_animation.play("RESET")
				$Monster.hide()
				$"red-hue".hide()
				$Player.can_move = true
				$Timer.start()
				yield($Timer, "timeout")
				game_level()
	if light == 6:
		can_damage = true
		
		
		

