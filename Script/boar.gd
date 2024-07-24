extends CharacterBody2D

enum STATE{
	IDLE,
	WALK,
	ATTACK
}

const MIN_X = 90
const MAX_X = 665
const MIN_Y = 80
const MAX_Y = 340
const SPEED = 150.0
var rand = RandomNumberGenerator.new()
var time
var speed
var dead
var curState
var target
var threshold = 0.3

@onready var animation = $AnimatedSprite2D
@onready var shadow = $Shadow
@onready var particles = $Particles
@onready var audio_stream_player = $AudioStreamPlayer

var die_sounds = [preload("res://Assets/SFX/animal_die_1.mp3"), preload("res://Assets/SFX/animal_die_2.mp3")]
var hit_sounds = [preload("res://Assets/SFX/animal_punch_1.mp3")]

func _ready():
	time = 1.0
	speed = SPEED
	#rand.set_seed(Time.get_ticks_msec())

func _physics_process(delta):
	if not dead:
		manageMov(delta)
		time -= delta

func manageMov(delta):
	if time <= 0.0:
		time = rand.randf_range(1.0, 6.0)
		curState = rand.randi_range(0,1) as STATE
		target = find_target()
		
	match curState:
		STATE.WALK:
			move(target, delta)
			change_animation("walk")
			speed = SPEED
		STATE.IDLE:
			change_animation("idle")

func move(target, delta):
	if target.distance_to(global_position) <= threshold:
		curState = STATE.IDLE
	var dir = (target - global_position).normalized()
	velocity = (dir*speed - velocity) * delta * 10
	move_and_slide()

func find_target():
	return Vector2(rand.randf_range(MIN_X, MAX_X), rand.randf_range(MIN_Y, MAX_Y))

func change_animation(new_animation):
	animation.animation = new_animation
	shadow.change_animation(new_animation)

func get_item():
	return null

func _on_timer_timeout():
	queue_free()

func _on_ressources_destroy_signal():
	print("Sheep died")
	audio_stream_player.stream = random_sound(die_sounds)
	audio_stream_player.play()
	particles.emitting = true
	animation.queue_free()
	shadow.queue_free()
	$Timer.start()
	dead = true

func _on_ressources_hit_signal():
	if not dead:
		audio_stream_player.stream = random_sound(hit_sounds)
		audio_stream_player.play()
		curState = STATE.ATTACK
		change_animation("walk")
		time = 1.0

func random_sound(sound_list):
	var i = rand.randi_range(0, sound_list.size()-1)
	return sound_list[i]
