extends Control

const ARE_YOU_SOMEONE__DAY_ = preload("res://Assets/Musics/are you someone (Day).mp3")
const WEIRD_SLINT_THING__NIGHT_ = preload("res://Assets/Musics/weird slint thing (Night).mp3")

var emited = false
@onready var progress_bar = $TextureProgressBar
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player = $AudioStreamPlayer
@onready var button = $Button

var timeEnd
var timeStart = 0

func _ready():
	audio_stream_player.stream = ARE_YOU_SOMEONE__DAY_
	audio_stream_player.play()
	
func _process(delta):
	if emited:
		return
	
	timeStart+=delta
	progress_bar.value = (timeStart*200)/timeEnd
	if progress_bar.value >= 200 and not emited:
		setNight()
	if Input.is_action_just_pressed("SkipDay"):
		setNight()


func _on_button_pressed():
	setNight()

func setNight():
		get_parent().Night()
		audio_stream_player.stream = WEIRD_SLINT_THING__NIGHT_
		audio_stream_player.play()
		audio_stream_player.volume_db = 0
		progress_bar.value=200
		animated_sprite_2d.animation = "night_transition"
		animated_sprite_2d.play()
		button.hide()
		emited = true
