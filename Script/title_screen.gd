extends Control

var scene = preload("res://Scene/Level_1.tscn").instantiate()

func _on_play_button_pressed():
	get_tree().root.add_child(scene)
	queue_free()
