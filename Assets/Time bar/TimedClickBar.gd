extends Button

export(bool) var pointer_is_over_target

func _on_TimedClickBar_pressed():
	print("callback")
	if pointer_is_over_target:
		print("Yes!")
	else:
		print("No")
