extends Control

signal ending1

onready var stats = get_tree().get_root().find_node("Stats", true, false)
const dialogueBoxScene = preload("res://dialogue.tscn")
var d
var noCount = 0

func _ready():
	$StartBtn.show()
	$EndingsBtn.show()
	$CreditsBtn.show()
	$SettingsBtmIcon.show()

func intro():
	$OpeningAni.play("Opening")

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
	dialogue("000")


func dialogue(index):
	d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).connect("ending1", self, "ending1")
	d.get_child(0).selectDialogue(index)
	

func ending1():
	emit_signal("ending1")
