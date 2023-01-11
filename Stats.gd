extends Node

export(int) var max_health = 1
onready var health = max_health setget set_health


var endings = [
	["ending1", false],
	["ending2", false], 
	["ending3", false],
	["ending4", false]]

signal no_health

func set_health(value):
	health = value
	if health <=0:
		emit_signal("no_health")

func ending1():
	print("ending1 has been received") #NOT CONNECTING TO SCENE B-WORD
