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

var ghost_active = true
var dadcall_active = true
var teeth_active = true
var circus_active = true

var current_time = 90
var gameover = false

func _ready():
	var spawnposition
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
	
	$Laszlo.hide()
	$Ghost.hide()


func dialogue(dIndex):
	print("received")
	$Player.can_move = false
	$Player/AnimationPlayer.play("Idle")
	d = dialogueBoxScene.instance()
	self.add_child(d)
	d.get_child(0).connect("ending", self, "ending")
	d.get_child(0).connect("goto", self, "goto")
	d.get_child(0).connect("next", self, "nextdialogue")
	d.get_child(0).connect("finished", self, "dialogueEnd")
	d.get_child(0).connect("game", self, "playgame")
	d.get_child(0).selectDialogue(dIndex)

func goto(scene):
	get_tree().change_scene(scene)

func dialogueEnd():
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
	if Stats.ghost_success and ghost_active:
		ghost_active = false
		dialogue("ghost_400")
		$Laszlo.show()


func _on_Ghost_Area2D_body_exited(body):
	ghost_entered = false
	if not Stats.ghost_success and $Ghost.visible:
		ghost_active = false
		$Ghost/AnimationPlayer.play_backwards("fade")
		yield($Ghost/AnimationPlayer, "animation_finished")
		$Ghost.visible = false
	$Player/Camera2D/Press_Enter.hide()



func _on_Dad_Area_body_entered(body):
	dadcall_entered = true
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
	if not Stats.teeth_encountered:
		Stats.teeth_encountered = true
		dialogue("teeth_100")

func _on_Teeth_Area_body_exited(body):
	teeth_entered = false
	if Stats.teeth_encountered and not Stats.teeth_success:
		$Teeth/AnimationPlayer.play("fade")



func _on_Circus_Area_body_entered(body):
	circus_entered = true
	if not Stats.circus_encountered:
		Stats.circus_encountered = true
		dialogue("circus_000")


func _on_Circus_Area_body_exited(body):
	circus_entered = false
	$Player/Camera2D/Press_Enter.hide()





func _on_demo_end_body_entered(body):
	$Player.can_move = false
	$Player/Game_Over/gameover.bbcode_text = "[center]TO BE CONTINUED (very soon...)[/center]"
	$Player/Game_Over/AnimationPlayer.play("gameover")
	gameover = true




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
			Stats.current_location = "dadcallspawn"
		elif teeth_entered:
			Stats.current_location = "teethspawn"
		elif circus_entered:
			Stats.current_location = "circusspawn"
		elif gameover:
			reset()
	if Stats.time != current_time:
		current_time = Stats.time
		print("Time: " + str(current_time))
	if current_time < 0:
		$Player.can_move = false
		$Player/Game_Over/AnimationPlayer.play("gameover")
		gameover = true
	

