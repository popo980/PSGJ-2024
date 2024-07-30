extends Area2D

var nextLvl = "res://Scene/levels/Level_2.tscn"

func interact(_player):
	get_tree().change_scene_to_file(nextLvl)
	
func get_item_id_type():
	return -1
