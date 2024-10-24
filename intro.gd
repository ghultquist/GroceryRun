extends Control

signal dialogue_sent(index)

var day = 1

func _ready():
	get_parent().get_parent().connect("dialogue_finished", self, "next")

func start_intro():
	emit_signal("dialogue_sent", "103")

func next():
	day +=1
	if day < 6:
		$Days.text = "Day " + str(day)
	if day == 2:
		emit_signal("dialogue_sent", "103")
	elif day == 3:
		emit_signal("dialogue_sent", "103")
	elif day == 4:
		emit_signal("dialogue_sent", "103")
	elif day == 5:
		emit_signal("dialogue_sent", "103")
	elif day == 6:
		end_intro()

func end_intro():
	print("ending")
	$AnimationPlayer.play("fadeout")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
