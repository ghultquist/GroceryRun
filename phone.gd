extends Control

onready var stats = get_tree().get_root().find_node("Stats", true, false)
var noCount = 0
signal dialogue(index)

func _ready():
	$StartBtn.show()
	$EndingsBtn.show()
	$CreditsBtn.show()
	$SettingsBtmIcon.show()

func intro():
	$OpeningAni.play("Opening")

func homescreen():
	for i in range(0, 9):
		$OpeningAni.get_child(i).hide()
		


func _on_StartBtn_pressed():
	gamestart()

func _on_EndingsBtn_pressed():
	for ending in stats.endings:
		self.find_node(ending[0]).show()
		if ending[1] == true:
			self.find_node(ending[0]).set_disabled(false)
		else:
			self.find_node(ending[0]).set_disabled(true)
	
func _on_CreditsBtn_pressed():
	pass # Replace with function body.


func gamestart():
	$StartBtn.hide()
	$EndingsBtn.hide()
	$CreditsBtn.hide()
	$SettingsBtmIcon.hide()
	$TextboxBG.show()
	$Text.show()
	emit_signal("dialogue", "000")
