extends Node2D

var Spawnable = {
	"Workbench": preload("res://Scene/Workbench.tscn")
}

@onready var player = get_parent().get_node(NodePath("Player"))

func spawn(spawnName:String):
	var spawned = Spawnable[spawnName].instantiate()
	add_child(spawned)
	spawned.position = player.position
