extends Control

signal night_signal
var time_speed = 1
var emited = false
@onready var progress_bar = $ProgressBar
@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	connect("night_signal", Callable(self, "on_night_signal"))



func _process(delta):
	progress_bar.value += time_speed * delta
	if progress_bar.value >= 100 and not emited:
		emit_signal("night_signal")
		animated_sprite_2d.animation = "night_transition"
		animated_sprite_2d.play()
		emited = true


func _on_button_pressed():
	progress_bar.value = 100
