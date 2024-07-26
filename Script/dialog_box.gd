extends Control

@export var text : Array
@onready var audio_stream_player = $AudioStreamPlayer
@onready var label = $DialogBox/Label

var char_speed = 0.05
var rand = RandomNumberGenerator.new()
var min_pitch = 2
var max_pitch = 2.5
signal action_pressed
var can_press = false


# Called when the node enters the scene tree for the first time.
func _ready():
	label.text = ""
	connect("action_pressed", Callable(self, "_on_action_pressed"))
	await get_tree().create_timer(0.5).timeout
	read_text()

func _input(event):
	if event.is_action_pressed("Hit") && can_press:
		emit_signal("action_pressed")


func read_text():
	for i in range(text.size()):
		for j in text[i]:
			if j!= ',' && j!='!' && j!='?' && j!='\n':
				if j!='.':
					audio_stream_player.pitch_scale = randf_range(min_pitch, max_pitch)
				audio_stream_player.play()
			label.text += j
			await get_tree().create_timer(char_speed).timeout
		#TODO : afficher visuellement qu'on peut appuyer
		can_press = true
		await action_pressed
		can_press = false
		label.text = ""
	queue_free()
