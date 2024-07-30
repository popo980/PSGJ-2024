extends Marker2D


enum ListMonster {
	NIGHTMORPH,
	NIGHTGIANT,
	NIGHTSQUID
}
var Monsters = {
	ListMonster.NIGHTMORPH : preload("res://Scene/nightmorph.tscn"),
	ListMonster.NIGHTGIANT : preload("res://Scene/nightgiant.tscn"),
	ListMonster.NIGHTSQUID : preload("res://Scene/nightsquid.tscn")
}

var game_manager
var gui
@onready var spawn_timer = $SpawnTimer
@export var choosenMonster :ListMonster= ListMonster.NIGHTMORPH
@export var spawnCooldown :float= 1
@export var qttSpawned :int = 1
var mobsSpawned :int=0

func _ready():
	game_manager = get_parent().get_parent().get_node("GameManager")
	gui = get_parent().get_parent().get_node("GUI")
	spawn_timer.wait_time = spawnCooldown
	game_manager.AddSpawner()
	gui.night_signal.connect(_on_gui_night_signal)

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

