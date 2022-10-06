extends Node2D

const dialogueBoxScene = preload("res://dialogue.tscn")
const phoneScene = preload("res://phone.tscn")
var d
var phoneStart

func _ready():
	phoneIntro()

func phoneIntro():
	phoneStart = phoneScene.instance()
	self.add_child(phoneStart)
