extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 400
const ACCEL = 10

var motion = Vector2()
var facing_right = true
var jump_count = 0
var stats = PlayerStats
var can_move = true
var health = 3

func _ready():
	if get_parent().name == "world":
		var devourernode = get_tree().get_root().find_node("Devourer", true, false)
		devourernode.connect("attack", self, "beingattacked")
		devourernode.connect("attack_over", self, "beingreleased")
		devourernode.connect("damage", self, "takendamage")
		stats.connect("no_health", self, "queue_free")
	
	set_sprite()


func _physics_process(delta):
	if can_move == true:
		if facing_right == true:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
		
		#WALKING MOTION
		motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
		
		if Input.is_action_pressed("right"):
			motion.x += ACCEL
			facing_right = true
			$AnimationPlayer.play("Walk")
		elif Input.is_action_pressed("left"):
			motion.x -= ACCEL
			facing_right = false
			$AnimationPlayer.play("Walk")
		else:
			motion.x = lerp(motion.x, 0, 0.2)
			$AnimationPlayer.play("Idle")
	
		#JUMPING & FALLING
		motion.y += GRAVITY
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED
		
		if Input.is_action_just_pressed("jump"):
			if jump_count < 1:
				jump_count +=1
				motion.y = -JUMPFORCE
	
		if is_on_floor():
			jump_count = 0
		else:
			if motion.y < 0:
				$AnimationPlayer.play("Jump")
			elif motion.y > 0:
				$AnimationPlayer.play("fall")
			elif motion.y == 0:
				$AnimationPlayer.play("land")
		
		motion = move_and_slide(motion, UP)

func beingattacked():
	can_move = false
	#self.position.x = 
	$AnimationPlayer.play("attackstart")
	yield($AnimationPlayer, "animation_finished")
	$AnimationPlayer.play("grabbed")


func beingreleased():
	$AnimationPlayer.play("attackend")
	yield($AnimationPlayer, "animation_finished")
	can_move = true
	$AnimationPlayer.play("Idle")

func takendamage():
	print("ouch")
	$AnimationPlayer.play("damagetaken")
	yield($AnimationPlayer, "animation_finished")
	health -= 1
	set_sprite()
	$AnimationPlayer.play("grabbed")


func set_sprite():
	if health == 3:
		$Sprite.texture = load("res://Assets/ProtagSpriteSheet1-0.png")
	elif health == 2:
		$Sprite.texture = load("res://Assets/ProtagSpriteSheet1-1.png")
	elif health == 1:
		$Sprite.texture = load("res://Assets/ProtagSpriteSheet1-2.png")

func _hide(delta):
	if Input.is_action_pressed("hide"):
		self.hide()
		get_node("CollisionShape2D").disabled= true
	else:
		self.show()
		get_node("CollisionShape2D").disabled= false
