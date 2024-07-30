extends Area2D

@onready var audio_stream_player = $AudioStreamPlayer

var speed := 300.0
var shooting_range := 240
var travelled_dist = 0

func _ready():
	audio_stream_player.stream = load("res://Assets/SFX/transitional-swipe-211688.mp3")
	audio_stream_player.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	travelled_dist += speed*delta
	
	if travelled_dist>shooting_range:
		queue_free()



func _on_area_2d_body_entered(_body):
	queue_free()


func _on_body_entered(_body):
	queue_free()
