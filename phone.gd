extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$OpeningAni.play("Opening")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartBtn_pressed():
	intro()

func intro():
	$StartBtn.hide()
	$EndingsBtn.hide()
	$CreditsBtn.hide()
	$SettingsBtmIcon.hide()
	$TextboxBG.show()
	$Text.show()
	$YesBtn.show()
	$NoBtn.show()


func _on_YesBtn_pressed():
	self.hide()
