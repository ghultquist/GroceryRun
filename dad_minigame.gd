extends Control

signal dialogue_sent(index)
signal retune

var question
var success = false

func _ready():
	Hud.get_child(0).time_visible(false)
	get_parent().get_parent().connect("dialogue_finished", self, "next")
	Hud.get_child(0).guide_text("[right]Click on the timebar and release on the right response[/right]")
	Stats.time -= 5
	q1()

func q1():
	question = 1
	$dad_dialogue.bbcode_text = "[center]That's better! So, how's it going, Honey?[/center]"
	$thoughts.bbcode_text = "[center](Not great, but it could be worse...)[/center]"
	$honest.bbcode_text = "[center]Terrible[/center]"
	$lie.bbcode_text = "[center]Pretty Good[/center]"
	$AnimationPlayer.play("intro")

func q2():
	question = 2
	self.hide()
	$dad_dialogue.bbcode_text = "[center]How's the job hunt going?[/center]"
	$thoughts.bbcode_text = "[center](Embarrassingly fruitless, but I should try to stay positive.)[/center]"
	$honest.bbcode_text = "[center]Exhausting[/center]"
	$lie.bbcode_text = "[center]Looking Promising[/center]"
	self.show()
	$AnimationPlayer.play("intro")

func q3():
	question = 3
	self.hide()
	$dad_dialogue.bbcode_text = "[center]Is [REDACTED] treating you right? Are you guys going to visit soon?[/center]"
	$thoughts.bbcode_text = "[center](...)[/center]"
	$honest.bbcode_text = "[center]Cry[/center]"
	$lie.bbcode_text = "[center]Lie[/center]"
	self.show()
	$AnimationPlayer.play("intro")


func _on_QTdevourerBar_timed_click(success):
	if success == true:
		if question == 1:
			q2()
		elif question == 2:
			q3()
		else:
			print("call ended")
			$AnimationPlayer.play("fadeout")
			yield($AnimationPlayer, "animation_finished")
			emit_signal("dialogue_sent", "dad_301")
			queue_free()
			
	else:
		Stats.dad_success = true
		print("call ended")
		$AnimationPlayer.play("fadeout")
		yield($AnimationPlayer, "animation_finished")
		if question == 1:
			Stats.time -= 20
			emit_signal("dialogue_sent", "dad_303")
		elif question == 2:
			Stats.time -= 10
			emit_signal("dialogue_sent", "dad_303")
		elif question == 3:
			Stats.time -= 5
			emit_signal("dialogue_sent", "dad_302")
		queue_free()
			
func next():
	Hud.get_child(0).time_visible(false)
	Hud.get_child(0).hide_guide()
	emit_signal("retune")
