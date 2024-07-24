extends Area2D

#[Tree,Rock,Bush]
var recipes = {
	"Wood Sword": [1,0,0],
	"Stone Axe": [1,2,0],
	"Bow": [1,0,2],
	"Magic Wand": [3,1,0],
	"Knife": [0,2,1],
	"Enchantment table": [1,0,1]
}

#var Gui

var inZone = []
var nbTree :int= 0
var nbRock :int= 0
var nbBush :int= 0

@onready var workbench_interface = $"../WorkbenchInterface"
var workbench_open = false
var player

func _ready():
	player = get_parent().get_parent().get_parent().get_node("Player")
	#Gui = get_parent().get_parent().get_parent().get_node(NodePath("GUI"))
	workbench_interface.global_position = Vector2.ZERO

func recipes_available():
	var rslt = []
	for i in recipes:
		if is_in_3arg(recipes[i],[nbTree,nbRock,nbBush]):
			rslt.append(i)
	return rslt

func add_ressources(TypeId:int):
	match TypeId:
		0:
			nbTree +=1
		1:
			nbRock +=1
		2:
			nbBush +=1

func sub_ressources(TypeId:int):
	match TypeId:
		0:
			nbTree -=1
		1:
			nbRock -=1
		2:
			nbBush -=1

func _on_area_entered(area):
	inZone.append(area)
	add_ressources(area.get_item_id_type())
	#Gui.UpdateCrafts(recipes_available())
	print(str(recipes_available()))
	print(str(nbTree)+" "+str(nbRock)+" "+str(nbBush))
	workbench_interface.check_all_achievable()


func _on_area_exited(area):
	inZone.remove_at(inZone.find(area))
	sub_ressources(area.get_item_id_type())
	#Gui.UpdateCrafts(recipes_available())
	print(str(inZone.size()))
	workbench_interface.check_all_achievable()
	

func is_in_3arg(lst1,lst2):
	for i in lst1.size():
		if lst2[i]-lst1[i] <0:
			return false
	return true

func useRessources(craftName:String):
	var neededRes = recipes[craftName]
	for i in inZone:
		var id_type = i.get_item_id_type()
		if id_type != -1 && neededRes[id_type]>0:
			neededRes[id_type] -= 1
			i.queue_free()

func get_item_id_type():
	return -1
	
func interact(_player):
	workbench_open = not workbench_open
	workbench_interface.visible = workbench_open
	workbench_interface.global_position = Vector2.ZERO


func _on_body_entered(_body):
	workbench_open = true
	workbench_interface.visible = workbench_open
	workbench_interface.global_position = Vector2.ZERO
	player.workbench_open = true
	if player.enchantment_table_open:
		print("enchantment_table already open")
		workbench_interface.z_index = 11
	else :
		print("enchantment_table not open")
		workbench_interface.z_index = 10

func _on_body_exited(_body):
	workbench_open = false
	workbench_interface.visible = workbench_open
	player.workbench_open = false
