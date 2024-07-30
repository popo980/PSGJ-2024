extends Node2D

const PORTAL = preload("res://Scene/portal.tscn")

var Spawnable = {
	"Workbench": preload("res://Scene/Workbench.tscn")
}

@export var curLvl :int
@export var portalEmplacement :Vector2

@onready var restart_timer = $RestartTimer
@onready var player = get_parent().get_node(NodePath("Player"))
@onready var curLvlPath = "res://Scene/levels/Level_"+str(curLvl)+".tscn"
@onready var nxtLvlPath = nxtLvlCalcul()
var restartAsked :bool= false
var nbMonsterSpawner :int

func _process(_delta):
	if Input.is_action_just_pressed("Restart"):
		restartAsked = true
		restart_timer.start()
	if Input.is_action_just_released("Restart"):
		restartAsked = false
		
		
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
	call_deferred("add_child", port)
	port.nextLvl = nxtLvlPath
	port.position = portalEmplacement
	player.zone_active()
	
func restart():
	get_tree().root.call_deferred("add_child",load(curLvlPath).instantiate())
	get_parent().call_deferred("queue_free")

func AddSpawner():
	nbMonsterSpawner+=1

func _on_restart_timer_timeout():
	if restartAsked:
		restart()

func nxtLvlCalcul():
	print("niveau actuel: "+ str(curLvl))
	print("Prochain niveau: "+str(curLvl+1) )
	if curLvl == 7:
		return "res://Scene/levels/Outro.tscn"
	return "res://Scene/levels/Level_"+str(curLvl+1)+".tscn"

