extends Node2D

signal dialogue(index)
signal goto

var left = false
var right = false
var next 
var d
var light = 6
var oldlight = 6
var active_light = 6

var points = 0
var lives = 3
var animations
var lit = []
var red_lights = []
var can_damage = true

func _ready():
	red_lights = [$r1, $r2, $r3, $r4, $r5, $r6]
	$good/good_CS.set_deferred("disabled", false)
	$Timer.wait_time = 2
	start_show()
	#get_parent().connect("dialogue_finished", self, "dialogue_finished")
	#$"bg-cyclop/AnimationPlayer".play("cyclop")
	#$"bg-ghost/AnimationPlayer".play("ghost")
	#$Monster.hide()
	#$"Player/Camera2D".zoom.x = .8
	#$"Player/Camera2D".zoom.y = .8


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
	$Player.can_move =true
	game_level()
	

func game_level():
	if points == 0:
		$light_animation.play("pattern1")

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
	yield(get_tree().create_timer(1), "timeout")		
	emit_signal("goto", "world")






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
	print("yum!")
	$good/good_CS.set_deferred("disabled", true)
	$good/Sprite.hide()


func _process(delta):
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
			if lives <= 0:
				$Player.can_move = false
				$Monster/AnimationPlayer.play("unravel")
				yield($Monster/AnimationPlayer, "animation_finished")
			else:
				$Timer.start()
				yield($Timer, "timeout")
				$light_animation.play("RESET")
				$light_animation.play("pattern1")
				$Monster.hide()
				$"red-hue".hide()
				$Player.can_move = true
	if light == 6:
		can_damage = true
		
		

