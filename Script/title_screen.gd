extends Control

var scene = preload("res://Scene/intro.tscn").instantiate()
var play_pressed
var started
var opacity = 1.0
var mult = 1
@onready var elements = $Elements
@onready var timer = $Timer



func _on_play_button_pressed():
	play_pressed = true

func _process(delta):
	if play_pressed && opacity > 0:
		print(opacity)
		opacity -= delta*mult
		elements.modulate.a = opacity
	elif opacity <= 0 && not started:
		timer.start()
		started = true


func _on_timer_timeout():
	get_tree().root.add_child(scene)
	queue_free()