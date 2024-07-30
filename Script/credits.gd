extends Control

const TITLE_SCREEN = "res://Scene/levels/title_screen.tscn"

func _on_play_button_pressed():
	get_tree().change_scene_to_file(TITLE_SCREEN)
