extends Marker2D

enum ListMonster {
	NIGHTMORPH
}
var Monsters = {
	ListMonster.NIGHTMORPH : preload("res://Scene/nightmorph.tscn")
}

@onready var spawn_timer = $SpawnTimer
@export var choosenMonster :ListMonster= ListMonster.NIGHTMORPH
@export var spawnCooldown :float= 1
@export var qttSpawned :int = 1


func _ready():
	spawn_timer.wait_time = spawnCooldown
	

func AtNight():
	spawn_timer.start()


func _on_spawn_timer_timeout():
	if qttSpawned <=1:
		spawn_timer.stop()
	qttSpawned -=1
	var spawned = Monsters[choosenMonster].instantiate()
	add_child(spawned)


func _on_gui_night_signal():
	AtNight()
