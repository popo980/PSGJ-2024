extends CharacterBody2D

enum{
	IDLE,
	WALK,
	BE_HIT
}

const MIN_X = -230
const MAX_X = 290
const MIN_Y = -100
const MAX_Y = 120
const SPEED = 2500.0
const HIT_SPEED = 9000.0
var speed 
var vel : Vector2
var rand = RandomNumberGenerator.new()
var time : float
var state = IDLE
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

func manageMov(delta):
	if time <= 0.0:
		time = rand.randf_range(1.0, 6.0)
		state = rand.randi_range(0,1)
		target = find_target()
		print("state: ", state)
		
	match state:
		WALK:
			move(target, delta)
			animation.animation = "walk"
			speed = SPEED
		IDLE:
			animation.animation = "idle"
		BE_HIT:
			speed = HIT_SPEED
			move(target, delta)
	time -= delta

func move(target, delta):
	if target.distance_to(global_position) <= threshold:
		print("STOP")
		state = IDLE
	var dir = (target - global_position).normalized()
	velocity = (dir*speed - velocity) * delta
	move_and_slide()

func find_target():
	return Vector2(rand.randf_range(MIN_X, MAX_X), randf_range(MIN_Y, MAX_Y))


func _on_zone_contact_body_entered(body):
	print("CONTACT")
	state = WALK

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
		state = BE_HIT
		animation.animation = "walk"
		time = 1.0
		target = -target
