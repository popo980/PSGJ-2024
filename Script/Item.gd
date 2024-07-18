extends Node2D

var is_holded : bool
var player_holding : CharacterBody2D
@export var offset : Vector2
@export var obj : Area2D

func _ready():
	is_holded = false

func _process(delta):
	if is_holded:
		obj.position = player_holding.position + offset

func use():
	queue_free()

func hold(player):
	is_holded = true

func drop():
	is_holded = false

