extends Area2D

func interact(player):
	get_node("Item").hold(player)

func drop():
	print("drop2")
	get_node("Item").drop()
	
func set_parent(parent):
	get_node("Item").parent = parent
