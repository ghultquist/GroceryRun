extends Node2D

const phoneScene = preload("res://phone.tscn")
var phoneStart

func _ready():
	phoneIntro()

func phoneIntro():
	phoneStart = phoneScene.instance()
	self.add_child(phoneStart)
