extends Node2D

@onready var collision_shape_2d = $CollisionShape2D
@onready var animation_player = $AnimationPlayer


func Hit():
	print("Hit")

func _on_timer_timeout():
	collision_shape_2d.disabled = true
