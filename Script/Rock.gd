extends StaticBody2D

const ROCK_ITEM = preload("res://Scene/RockItem.tscn")
@onready var collision_shape_2d_2 = $CollisionShape2D2
@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite = $Sprite
@onready var particles = $Particles
@onready var audio_stream_player = $AudioStreamPlayer

const ROCK_HIT = preload("res://Assets/SFX/rock_hit.mp3")
const ROCK_BREAK = preload("res://Assets/SFX/rock_break.mp3")

func get_item():
	return ROCK_ITEM


func _on_ressources_destroy_signal():
	print("Rock destroyed")
	audio_stream_player.stream = ROCK_BREAK
	audio_stream_player.play()
	collision_shape_2d.queue_free()
	collision_shape_2d_2.queue_free()
	sprite.queue_free()
	particles.emitting = true


func _on_ressources_hit_signal():
	audio_stream_player.stream = ROCK_HIT
	audio_stream_player.play()
