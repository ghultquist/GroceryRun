extends Node2D

var all_tentacles = []

func _ready():
	all_tentacles = [$tentacles, $tentacles2, $tentacles3, $tentacles4, $tentacles5]
	for t in all_tentacles:
		t.get_child(0).play("writhe")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
