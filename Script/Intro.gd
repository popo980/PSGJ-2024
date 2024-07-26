extends Control

var text = [
	"The King seeks an alchemist...\n\n",
	"This could be my chance...\n\n",
	"After all, what have I got to lose?\n\n",
	"I have to pass a series of tests, and if I'm still alive after 7 days in the arena, I become the King's official alchemist...\n\n",
	".",".",".\n\n",
	"Yes! I'll try!\n\n"
]

var char_speed = 0.08
var sentence_wait = 1
var char
@onready var label = $Label
var rand = RandomNumberGenerator.new()
var min_pitch = 2
var max_pitch = 2.5
@onready var audio_stream_player = $AudioStreamPlayer
var scene = preload("res://Scene/Level_1.tscn").instantiate()

func _ready():
	label.text = ""
	read_text()

func read_text():
	for i in range(text.size()):
		for j in text[i]:
			if j!= ',' && j!='!' && j!='?' && j!='\n':
				if j!='.':
					audio_stream_player.pitch_scale = randf_range(min_pitch, max_pitch)
				audio_stream_player.play()
			label.text += j
			await get_tree().create_timer(char_speed).timeout
		await get_tree().create_timer(sentence_wait).timeout
	get_tree().root.add_child(scene)
	queue_free()
