extends Control


func _ready():
	intro()

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
	queue_free()
