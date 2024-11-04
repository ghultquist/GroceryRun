extends Control

signal dialogue_sent(index)
signal startgame

var day = 0


func _ready():
	get_parent().get_parent().connect("dialogue_finished", self, "next")
	$phone.intro()

func start_intro():
	$Days.text = ""
	emit_signal("dialogue_sent", "intro_000")

func next():
	day +=1
	if day < 6:
		$Days.bbcode_text = "[center]Day " + str(day) + "[/center]"
	if day == 1:
		$frame2/eggs.hide()
		emit_signal("dialogue_sent", "intro_001")
	elif day == 2:
		$frame5/corn.hide()
		emit_signal("dialogue_sent", "intro_002")
	elif day == 3:
		$frame3/soap.hide()
		emit_signal("dialogue_sent", "intro_003")
	elif day == 4:
		$frame1/pear.hide()
		emit_signal("dialogue_sent", "intro_004")
	elif day == 5:
		$frame4/tp.hide()
		emit_signal("dialogue_sent", "intro_005")
	elif day == 6:
		$frame1.hide()
		$frame2.hide()
		$frame3.hide()
		$frame4.hide()
		$frame5.hide()
		$Days.bbcode_text = "[center]GROCERY RUN[/center]"
		end_intro()

func end_intro():
	print("ending")
	$AnimationPlayer.play("fadeout")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
	emit_signal("dialogue_sent", "intro_100")
