extends Area2D

var nextLvl = "res://Scene/levels/Level_2.tscn"

func interact(_player):
	get_tree().root.add_child(load(nextLvl).instantiate())
	get_parent().queue_free()
	
func get_item_id_type():
	return -1
