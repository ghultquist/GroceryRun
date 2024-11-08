extends Node2D

#DIALOGUE VARS
const dialogueBoxScene = preload("res://dialogue.tscn")
const introScene = preload("res://intro.tscn")
const dadCallScene = preload("res://dad_call.tscn")
const retuneScene = "res://retune.tscn"
const jumpinglizardScene = "res://jumpinglizard.tscn"
const forestScene = "res://Ghost_Game.tscn"
const circusScene = "res://circus.tscn"
signal dialogue
signal dialogue_finished
var d
var commandReceived = false

#LOCATION VARS
var ghost_entered = false
var dadcall_entered = false
var teeth_entered = false
var circus_entered = false

var current_time = 90
var gameover = false

func _ready():
	Hud.get_child(0).time_visible(true)
	var spawnposition
	print(Stats.current_location)
	if Stats.current_location == "firstspawn":
		var i = introScene.instance()
		self.add_child(i)
		i.get_child(0).connect("dialogue_sent", self, "dialogue")
		spawnposition = $Start.global_position
	elif Stats.current_location == "ghostspawn":
		spawnposition = $Ghost.global_position 
	elif Stats.current_location == "dadspawn":
		spawnposition = $Dad.global_position	
	elif Stats.current_location == "teethspawn":
		spawnposition = $Teeth.global_position
	elif Stats.current_location == "circusspawn":
		spawnposition = $Circus.global_position
	spawnposition.x -= 30
	$Player.global_position = spawnposition
	
	Hud.get_child(0).hide_guide()
	$Laszlo.hide()


func dialogue(dIndex):
	print("received")
	$Player.can_move = false
	$Player/AnimationPlayer.play("Idle")
	Hud.get_child(0).guide_text("[right]Press enter to continue/select[/right]")
	d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).connect("ending", self, "ending")
	d.get_child(0).connect("goto", self, "goto")
	d.get_child(0).connect("next", self, "nextdialogue")
	d.get_child(0).connect("finished", self, "dialogueEnd")
	d.get_child(0).connect("game", self, "playgame")
	d.get_child(0).connect("timelost", self, "timeloss")
	d.get_child(0).selectDialogue(dIndex)

func timeloss(t):
	if d.get_child(0):
		yield(d.get_child(0), "finished")
	Stats.time -= t

func goto(scene):
	get_tree().change_scene(scene)

func dialogueEnd():
	Hud.get_child(0).hide_guide()
	$Player.can_move = true
	emit_signal("dialogue_finished")

func playgame(g):
	print("got signal")
	if d.get_child(0):
		yield(d.get_child(0), "finished")
	if g == "retune":
		retune_minigame()
	if g == "ghostgame":
		print("spooooky")
		get_tree().change_scene(forestScene)
	if g == "dadcall":
		print("answering call...")
		dad_answered()
	if g == "teethgame":
		print("rocking out...")
		get_tree().change_scene(jumpinglizardScene)
	if g == "circusgame":
		print("pokadot pokadot...")
		get_tree().change_scene(circusScene)

func nextdialogue(dname):
	if d.get_child(0):
		yield(d.get_child(0), "finished")
	dialogue(dname)

func retune_minigame():
	print("retuning")
	get_tree().change_scene(retuneScene)

func _on_Ghost_Area2D_body_entered(body):
	ghost_entered = true
	Stats.current_location = "ghostspawn"
	if not Stats.ghost_encountered:
		Stats.ghost_encountered = true
		$Ghost/AnimationPlayer.play("fade")
		yield($Ghost/AnimationPlayer, "animation_finished")
		$Ghost/AnimationPlayer.play("float")
		dialogue("ghost_100")
	if Stats.ghost_success and Stats.ghost_active:
		$Ghost.visible = true
		Stats.ghost_active = false
		dialogue("ghost_400")
		$Laszlo.show()


func _on_Ghost_Area2D_body_exited(body):
	ghost_entered = false
	if not Stats.ghost_success and $Ghost.visible:
		$Ghost/AnimationPlayer.play_backwards("fade")
		yield($Ghost/AnimationPlayer, "animation_finished")
		$Ghost.visible = false



func _on_Dad_Area_body_entered(body):
	dadcall_entered = true
	Stats.current_location = "dadspawn"
	if not Stats.dad_encountered:
		Stats.dad_encountered = true
		dialogue("dad_000")

func dad_answered():
	$Player.global_position = $Call_Answered.global_position
	if $Player.facing_right == true:
		$Player.facing_right = false
		$Player/Sprite.flip_h = true
	$Player.facing_right = false
	$Player/AnimationPlayer.play("Idle")
	$Player.can_move = false
	var i = dadCallScene.instance()
	self.add_child(i)
	i.get_child(0).connect("dialogue_sent", self, "dialogue")
	i.get_child(0).connect("retune", self, "retune_minigame")

func _on_Dad_Area_body_exited(body):
	dadcall_entered = false


func _on_Teeth_Area_body_entered(body):
	teeth_entered = true
	Stats.current_location = "teethspawn"
	if not Stats.teeth_encountered:
		Stats.teeth_encountered = true
		dialogue("teeth_100")
	else:
		$Teeth.hide()

func _on_Teeth_Area_body_exited(body):
	teeth_entered = false
	if Stats.teeth_encountered and not Stats.teeth_success:
		$Teeth/AnimationPlayer.play("fade")



func _on_Circus_Area_body_entered(body):
	Stats.current_location = "circusspawn"
	circus_entered = true
	if not Stats.circus_encountered:
		Stats.circus_encountered = true
		dialogue("circus_000")


func _on_Circus_Area_body_exited(body):
	circus_entered = false


func _on_grocery_body_entered(body):
	Hud.get_child(0).gameover_screen()
	dialogue("end_000")
	if d.get_child(0):
		yield(d.get_child(0), "finished")
	Hud.get_child(0).gameover_text("[center]GROCERY RUN[/center]", "[center][rainbow freq=1.0 sat=0.8 val=0.8]Have a nice night![/rainbow][/center]")
	dialogue("end_005")
	if d.get_child(0):
		yield(d.get_child(0), "finished")
	if Stats.teeth_success and Stats.ghost_success:
		dialogue("end_001")
	


func reset():
	ghost_entered = false
	dadcall_entered = false
	teeth_entered = false
	circus_entered = false
	current_time = 90
	Stats.reset()
	gameover = false
	_ready()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if ghost_entered and Stats.ghost_encountered and Stats.ghost_success:
			Stats.current_location = "ghostspawn"
		elif dadcall_entered:
			Stats.current_location = "dadspawn"
		elif teeth_entered:
			Stats.current_location = "teethspawn"
		elif circus_entered:
			Stats.current_location = "circusspawn"
		elif gameover:
			reset()
	if Stats.time <= 0 and not gameover:
		$Player.can_move = false
		Hud.get_child(0).gameover_screen()
		Hud.get_child(0).gameover_text("[center]Out of Time...[/center]", "")
		Stats.time = 1
		gameover = true
	

