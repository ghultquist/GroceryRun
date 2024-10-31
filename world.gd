extends Node2D

#DIALOGUE VARS
const dialogueBoxScene = preload("res://dialogue.tscn")
const introScene = preload("res://intro.tscn")
const retuneScene = "res://retune.tscn"
signal dialogue
signal dialogue_finished
var d
var commandReceived = false

#LOCATION VARS
var ghost_entered = false
var dadcall_entered = false
var teeth_entered = false
var circus_entered = false

func _ready():
	var spawnposition
	if Stats.current_location == "firstspawn":
		var i = introScene.instance()
		self.add_child(i)
		i.get_child(0).connect("dialogue_sent", self, "dialogue")
		i.get_child(0).start_intro()
		spawnposition = $Start.global_position
	elif Stats.current_location == "ghostspawn":
		spawnposition = $Ghost.global_position 
	elif Stats.current_location == "teethspawn":
		spawnposition = $Teeth.global_position
	elif Stats.current_location == "circusspawn":
		spawnposition = $Start.global_position
	spawnposition.x -= 30
	$Player.global_position = spawnposition


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
		print("retuning")
		get_tree().change_scene(retuneScene)

func nextdialogue(dname):
	if d.get_child(0):
		yield(d.get_child(0), "finished")
	dialogue(dname)

func _on_Ghost_Area2D_body_entered(body):
	ghost_entered = true
	Stats.current_location = "ghostspawn"
	if not Stats.ghost_encountered:
		Stats.ghost_encountered = true
		Stats.ghost_success = true
		$Ghost/AnimationPlayer.play("fade")
		yield($Ghost/AnimationPlayer, "animation_finished")
		$Ghost/AnimationPlayer.play("float")
		dialogue("ghost_100")
	if Stats.ghost_encountered and Stats.ghost_success:
		$Player/Camera2D/Press_Enter.show()


func _on_Ghost_Area2D_body_exited(body):
	ghost_entered = false
	if not Stats.ghost_success and $Ghost.visible:
		$Ghost/AnimationPlayer.play_backwards("fade")
		yield($Ghost/AnimationPlayer, "animation_finished")
		$Ghost.visible = false
	$Player/Camera2D/Press_Enter.hide()
		

func _on_Dad_Area_body_entered(body):
	dadcall_entered = true
	$Player/Camera2D/Press_Enter.show()


func _on_Dad_Area_body_exited(body):
	dadcall_entered = false
	$Player/Camera2D/Press_Enter.hide()


func _on_Teeth_Area_body_entered(body):
	teeth_entered = true
	$Player/Camera2D/Press_Enter.show()


func _on_Teeth_Area_body_exited(body):
	teeth_entered = false
	$Player/Camera2D/Press_Enter.hide()


func _on_Circus_Area_body_entered(body):
	circus_entered = true
	$Player/Camera2D/Press_Enter.show()


func _on_Circus_Area_body_exited(body):
	circus_entered = false
	$Player/Camera2D/Press_Enter.hide()

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		if ghost_entered and Stats.ghost_encountered and Stats.ghost_success:
			dialogue("ghost_500")
		elif dadcall_entered:
			Stats.current_location = "dadcallspawn"
		elif teeth_entered:
			Stats.current_location = "teethspawn"
		elif circus_entered:
			Stats.current_location = "circusspawn"

