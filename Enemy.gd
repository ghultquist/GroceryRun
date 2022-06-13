extends KinematicBody2D

const GRAVITY = 20
const FLOOR = Vector2(0, -1)

var velocity = Vector2(0,0)
var speed = 30
var direction = 1

func _ready():
	$AnimationPlayer.play("Enemy-Idle")

func _process(delta):
	move_character()
	
func move_character():
	velocity.x = -speed * direction
	
	if direction == 1:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR) 
	
	if is_on_wall():
		direction = direction *-1
		
