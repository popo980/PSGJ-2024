extends CharacterBody2D

@export var health := 25
@export var damage := 10
@export var max_speed :float= 50.0
@export var damaged_speed :float= 2.0
@export var hit_speed :float= 30.0

@onready var anim_sprite = $AnimatedSprite2D
@onready var damaged_timer = $DamagedTimer
@onready var attack_timer = $AttackTimer

var player
var speed :float= max_speed
var playerInHit:bool=false

func _ready():
	player = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func get_hit(damages:int):
	health -= damages
	
	if health<=0: #death
		queue_free()
	else:		#receive attack and survive
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
