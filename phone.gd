extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func intro():
	$OpeningAni.play("Opening")

func _on_StartBtn_pressed():
	gamestart()

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
	self.hide()
