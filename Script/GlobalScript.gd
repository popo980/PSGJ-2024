extends Node2D

var prochNum
var nextLvl
var curLvl


func change_scene():
	curLvl.queue_free()
	
	var temp = load(nextLvl)
	curLvl = temp.instantiate()
	add_child(curLvl)
	curLvl.name = "level"+prochNum
