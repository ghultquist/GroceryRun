extends Control

const stats = preload("res://Stats.gd")
const dialogueBoxScene = preload("res://dialogue.tscn")
var d
var noCount = 0

func _ready():
	intro()

func intro():
	$OpeningAni.play("Opening")

func _on_StartBtn_pressed():
	gamestart()

func _on_EndingsBtn_pressed():
	for ending in stats.endings:
		self.get_child(ending).show()
		if ending == self.get_child(ending):
			self.get_child(ending).get_normal_texture()
		else:
			self.get_child(ending).get_disabled_texture()
	
func _on_CreditsBtn_pressed():
	pass # Replace with function body.


func gamestart():
	$StartBtn.hide()
	$EndingsBtn.hide()
	$CreditsBtn.hide()
	$SettingsBtmIcon.hide()
	$TextboxBG.show()
	$Text.show()
	$YesBtn.show()
	$NoBtn.show()


func _on_YesBtn_pressed():
	queue_free()




func _on_NoBtn_pressed():
	if noCount == 0:
		dialogue("001")
		noCount += 1
	elif noCount == 1:
		dialogue("002")
		noCount+= 1
	elif noCount == 2:
		dialogue("003")
		noCount += 1
	else:
		pass

func dialogue(index):
	d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).selectDialogue(index)
