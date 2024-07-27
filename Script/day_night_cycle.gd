extends Control

var emited = false
@onready var progress_bar = $ProgressBar
@onready var animated_sprite_2d = $AnimatedSprite2D

var timeEnd = 200
var timeStart = 0

func _process(delta):
	if emited:
		return
	
	timeStart+=delta
	progress_bar.value = (timeStart*100)/timeEnd
	if progress_bar.value >= 100 and not emited:
		setNight()


func _on_button_pressed():
	setNight()

func setNight():
		get_parent().Night()
		progress_bar.value=100
		animated_sprite_2d.animation = "night_transition"
		animated_sprite_2d.play()
		emited = true
