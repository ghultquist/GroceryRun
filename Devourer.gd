extends KinematicBody2D

signal attack
signal attack_over
signal damage

const GRAVITY = 20
const FLOOR = Vector2(0, -1)

var velocity = Vector2(0,0)
var speed = 30
var direction = 1
var can_move = true
var escape_success = false
var can_attack = true

func _ready():
	$AnimationPlayer.play("DevIdle")

func _process(delta):
	if can_move == false:
		return
	
	move_character()
	detect_turn_around()
	
func move_character():
		velocity.x = -speed * direction
		$AnimationPlayer.play("DevWalk")
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR) 
	
func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor() or is_on_wall():
		var i = 0
		direction = -direction
		scale.x = -scale.x

#Attack 
func _on_AttackDetector_body_entered(body):
	if can_attack == true:
		grab()

func grab():
	can_attack = false
	can_move = false
	emit_signal("attack")
	$AnimationPlayer.play("DevAttackStart")
	yield($AnimationPlayer, "animation_finished")
	hold()
	
func hold():
	$QTdevourerBar.show()
	$AnimationPlayer.play("DevAttackHold")


func release():
	$QTdevourerBar.hide()
	emit_signal("attack_over")
	$AnimationPlayer.play("DevAttackRetract")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("DevDefeated")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("DevIdle")
	var t = Timer.new()
	t.set_wait_time(5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	can_attack = true
	can_move = true


func _on_QTdevourerBar_timed_click(success):
	if success == true:
		escape_success == true
		release()
	else:
		escape_success == false
		emit_signal("damage")
		
