extends Control

var text = [
	"You get out of the last portal.\n\n",
	"The king is in front of you, you can see the respect in his eyes\n\n",
	"After all those test you are the only one that survived...\n\n",
	"You are now the best shadow alchemist of the kingdom !\n\n",
	"Wait no...\n\n",
	"THE BEST ALCHEMIST OF THE WORLD !!!\n\n"
]

var char_speed = 0.08
var sentence_wait = 1
@onready var label = $Label
var rand = RandomNumberGenerator.new()
var min_pitch = 2
var max_pitch = 2.5
@onready var audio_stream_player = $AudioStreamPlayer
var scene = "res://Scene/levels/title_screen.tscn"
@onready var timer = $Timer

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
	timer.start()


func _on_timer_timeout():
	get_tree().change_scene_to_file(scene)
