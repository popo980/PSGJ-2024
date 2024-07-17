extends Node2D

enum Ressource {TREE, ROCK, BUSH}

@export var ressource : Ressource
@export var pv_max : float
@export var area_radius : float
@export var sprite : Node2D
@export var obj : StaticBody2D
@export var particle : CPUParticles2D

var pv : float
var can_hit : bool
var destroyed : bool

@onready var area = $Area2D/CollisionShape2D
@onready var timer = $Timer

func _ready():
	pv = pv_max
	area.shape.radius = area_radius

func _on_area_2d_body_entered(body):
	can_hit = body.get_collision_layer() == 2 # player

func hit(damage):
	if can_hit:
		pv -= damage
		if pv <= 0 && !destroyed:
			# TODO: give ressource
			destroyed = true
			sprite.queue_free()
			particle.emitting = true
			timer.start()
			pv = 0
		print("pv: ", pv)



func _on_timer_timeout():
	obj.queue_free()
