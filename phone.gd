extends Control

onready var stats = get_tree().get_root().find_node("Stats", true, false)
var screen

func _ready():
	homescreen()

func intro():
	$OpeningAni.play("Opening")

func homescreen():
	$StartBtn.show()
	$CreditsBtn.show()
	$SettingsBtmIcon.show()

func homehide():
	self.hide()

func _on_StartBtn_pressed():
	homehide()
	get_parent().start_intro()
	
func _on_CreditsBtn_pressed():
	homehide()
	$back.show()
	screen = "credits"


func _on_back_pressed():
	$back.hide()
	if screen == "credits":
		pass
	homescreen()
