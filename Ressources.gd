extends Node2D

enum Ressource {TREE, ROCK, BUSH}

@export var ressource : Ressource
@export var pv_max : float
@export var area_radius : float

var pv : float
var can_hit : bool

@onready var area = $Area2D/CollisionShape2D

func _ready():
	pv = pv_max
	area.shape.radius = area_radius

func _on_area_2d_body_entered(body):
	can_hit = body.get_collision_layer() == 2 # player

func hit(damage):
	if can_hit:
		pv -= damage
		if pv <= 0:
			# TODO: give ressource
			pv = 0
		print("pv: ", pv)
