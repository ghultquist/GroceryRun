extends TextureButton


signal timed_click(success)

export(bool) var pointer_is_over_target

func _ready():
	$AnimationPlayer.play("ArrowMove") 

func _on_QTdevourerBar_pressed():
	emit_signal("timed_click", pointer_is_over_target)
