extends Control

var current_time = 90


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func time_visible(v):
	if v == true:
		$time.show()
	if v == false:
		$time.hide()

func hide_guide():
	$guide.hide()

func guide_text(t):
	$guide.bbcode_text = t
	$guide.show()
	
func gameover_screen():
	$Game_Over/AnimationPlayer.play("gameover")

func gameover_text(t1,t2):
	$Game_Over/try_again.bbcode_text = t1
	$Game_Over/gameover.bbcode_text = t2
	$Game_Over/try_again.show()
	$Game_Over/gameover.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Stats.time != current_time:
		var difference = current_time - Stats.time
		$time_warning.bbcode_text = "- " + str(difference)
		$time_warning/AnimationPlayer.play("warn")
		current_time = Stats.time
		$time.bbcode_text = "Time: " + str(current_time)
