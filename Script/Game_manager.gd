extends Node2D

const PORTAL = preload("res://Scene/portal.tscn")

var Spawnable = {
	"Workbench": preload("res://Scene/Workbench.tscn")
}

@export var nbMonsterSpawner :int
@export var nextLvl := "res://Scene/levels/Level_2.tscn"
@export var portalEmplacement :Vector2

@onready var player = get_parent().get_node(NodePath("Player"))

func spawn(spawnName:String):
	var spawned = Spawnable[spawnName].instantiate()
	add_child(spawned)
	spawned.position = player.position

func endSpawner():
	nbMonsterSpawner-=1
	if nbMonsterSpawner<=0:
		endLvl()

func endLvl():
	var port = PORTAL.instantiate()
	port.nextLvl = nextLvl
	get_parent().add_child(port)
	port.position = portalEmplacement
	
