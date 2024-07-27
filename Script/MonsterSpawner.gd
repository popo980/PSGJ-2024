extends Marker2D


enum ListMonster {
	NIGHTMORPH
}
var Monsters = {
	ListMonster.NIGHTMORPH : preload("res://Scene/nightmorph.tscn")
}

var game_manager
@onready var spawn_timer = $SpawnTimer
@export var choosenMonster :ListMonster= ListMonster.NIGHTMORPH
@export var spawnCooldown :float= 1
@export var qttSpawned :int = 1
var mobsSpawned :int=0

func _ready():
	game_manager = get_parent().get_parent().get_node("GameManager")
	spawn_timer.wait_time = spawnCooldown

func AtNight():
	spawn_timer.start()

func mobDeath():
	mobsSpawned-=1
	if qttSpawned<=0 && mobsSpawned <=0:
		game_manager.endSpawner()

func _on_spawn_timer_timeout():
	if qttSpawned <=1:
		spawn_timer.stop()
	qttSpawned -=1
	mobsSpawned +=1
	var spawned = Monsters[choosenMonster].instantiate()
	add_child(spawned)


func _on_gui_night_signal():
	AtNight()

