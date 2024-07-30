extends CharacterBody2D

@export var health := 100
@export var damage := 30
@export var max_speed :float= 50.0
@export var damaged_speed :float= 30.0
@export var hit_speed :float= 20.0

@onready var anim_sprite = $AnimatedSprite2D
@onready var damaged_timer = $DamagedTimer
@onready var attack_timer = $AttackTimer
@onready var hit_zone = $HitZone
@onready var particles = $Particles
@onready var death_timer = $DeathTimer
@onready var collision_shape_2d = $CollisionShape2D
@onready var audio_stream_player = $AudioStreamPlayer

var die_sounds = [preload("res://Assets/SFX/animal_die_1.mp3"), preload("res://Assets/SFX/animal_die_2.mp3")]
var hit_sounds = [preload("res://Assets/SFX/animal_punch_1.mp3")]
var rand = RandomNumberGenerator.new()

var player
var speed :float= max_speed
var playerInHit:bool=false

func _ready():
	player = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(_delta):
	if health>0:
		var direction = global_position.direction_to(player.global_position)
		hit_zone.look_at(player.global_position)
		if player.global_position.x > global_position.x:
			anim_sprite.flip_h = true
		else:
			anim_sprite.flip_h = false
		velocity = direction * speed
		move_and_slide()

func get_hit(damages:int):
	health -= damages
	
	if health<=0: #death
		audio_stream_player.stream = random_sound(die_sounds)
		audio_stream_player.play()
		particles.emitting = true
		anim_sprite.queue_free()
		collision_shape_2d.queue_free()
		hit_zone.queue_free()
		death_timer.start()
		get_parent().mobDeath()
	else:		#receive attack and survive
		audio_stream_player.stream = random_sound(hit_sounds)
		audio_stream_player.play()
		anim_sprite.play("Damaged")
		speed = damaged_speed
		damaged_timer.start()


func _on_damaged_timer_timeout():
	speed = max_speed



func _on_hit_zone_body_entered(_body):
	playerInHit = true
	speed = hit_speed
	anim_sprite.play("Hit")
	attack_timer.start()


func _on_attack_timer_timeout():
	speed = max_speed
	if playerInHit:
		player.get_hit(damage)


func _on_animated_sprite_2d_animation_finished():
	anim_sprite.play("Walk")


func _on_hit_zone_body_exited(_body):
	playerInHit = true
	attack_timer.stop()


func _on_death_timer_timeout():
	queue_free()

func random_sound(sound_list):
	var i = rand.randi_range(0, sound_list.size()-1)
	return sound_list[i]
