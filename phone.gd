extends Control

onready var stats = get_tree().get_root().find_node("Stats", true, false)
var noCount = 0
signal dialogue(index)
var screen

func _ready():
	homescreen()

func intro():
	$OpeningAni.play("Opening")

func homescreen():
	$StartBtn.show()
	$EndingsBtn.show()
	$CreditsBtn.show()
	$SettingsBtmIcon.show()

func homehide():
	$StartBtn.hide()
	$EndingsBtn.hide()
	$CreditsBtn.hide()
	$SettingsBtmIcon.hide()

func _on_StartBtn_pressed():
	homehide() #REPLACE WITH SCENE CHANGER
	$TextboxBG.show()
	$Text.show()
	emit_signal("dialogue", "000")

func _on_EndingsBtn_pressed():
	homehide()
	$back.show()
	for ending in stats.endings:
		self.find_node(ending[0]).show()
		if ending[1] == true:
			self.find_node(ending[0]).set_disabled(false)
		else:
			self.find_node(ending[0]).set_disabled(true)
	screen = "endings"
	
func _on_CreditsBtn_pressed():
	homehide()
	$back.show()
	screen = "credits"


func _on_back_pressed():
	$back.hide()
	if screen == "endings":
		for ending in stats.endings:
			self.find_node(ending[0]).hide()
	elif screen == "credits":
		pass
	homescreen()
