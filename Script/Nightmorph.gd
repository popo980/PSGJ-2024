extends CharacterBody2D

@export var speed := 100.0
@export var health := 25

var player

func _ready():
	player = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

