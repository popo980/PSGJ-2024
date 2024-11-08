extends Area2D

#[Tree,Rock,Bush
var recipes = {
	"Workbench": [2,0,0]
}
@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $Sprite2D

var Gui

var inZone = []
var nbTree :int= 0
var nbRock :int= 0
var nbBush :int= 0

func _ready():
	Gui = get_parent().get_parent().get_node(NodePath("GUI"))

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
	Gui.UpdateCrafts(recipes_available())


func _on_area_exited(area):
	inZone.remove_at(inZone.find(area))
	sub_ressources(area.get_item_id_type())
	Gui.UpdateCrafts(recipes_available())

func is_in_3arg(lst1,lst2):
	for i in lst1.size():
		if lst2[i]-lst1[i] <0:
			return false
	return true

func useRessources(craftName:String):
	var neededRes = []
	for i in recipes[craftName]:
		neededRes.append(i)
	for i in inZone:
		var id_type = i.get_item_id_type()
		if neededRes[id_type]>0:
			i.queue_free()
			neededRes[id_type] -= 1
			

func get_item_id_type():
	return -1

func disappear():
	collision_shape_2d.disabled = true
	sprite_2d.queue_free()

func reappear():
	collision_shape_2d.disabled = false
