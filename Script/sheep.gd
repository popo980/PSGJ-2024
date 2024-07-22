extends CharacterBody2D

enum STATE{
	IDLE,
	WALK,
	BE_HIT
}

const MIN_X = -230
const MAX_X = 290
const MIN_Y = -100
const MAX_Y = 120
const SPEED = 200.0
const HIT_SPEED = 900.0
var speed 
var vel : Vector2
var rand = RandomNumberGenerator.new()
var time : float
var curState = STATE.IDLE
var target : Vector2
var threshold = 0.3
var dead : bool
@onready var animation = $Sprite
@onready var particles = $Particles

func _ready():
	time = 1.0
	speed = SPEED

func _physics_process(delta):
	if not dead:
		manageMov(delta)
		time -= delta

func manageMov(delta):
	if time <= 0.0:
		time = rand.randf_range(1.0, 6.0)
		curState = rand.randi_range(0,1)
		target = find_target()
		print("state: ", curState)
		
	match curState:
		STATE.WALK:
			move(target, delta)
			animation.animation = "walk"
			speed = SPEED
		STATE.IDLE:
			animation.animation = "idle"
		STATE.BE_HIT:
			speed = HIT_SPEED
			move(target, delta)

func move(_target, delta):
	if target.distance_to(global_position) <= threshold:
		print("STOP")
		curState = STATE.IDLE
	var dir = (target - global_position).normalized()
	velocity = (dir*speed - velocity) * delta * 10
	move_and_slide()

func find_target():
	return Vector2(rand.randf_range(MIN_X, MAX_X), randf_range(MIN_Y, MAX_Y))


func _on_zone_contact_body_entered(_body):
	print("CONTACT")
	curState = STATE.WALK

func get_item():
	return null

func _on_timer_timeout():
	queue_free()

func _on_ressources_destroy_signal():
	print("Sheep died")
	particles.emitting = true
	animation.queue_free()
	$Timer.start()
	dead = true

func _on_ressources_hit_signal():
	if not dead:
		curState = STATE.BE_HIT
		animation.animation = "walk"
		time = 1.0
		target = -target
