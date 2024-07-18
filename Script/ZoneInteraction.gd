extends Area2D

#[Tree,Rock,Bush
var recipes = {
	"Workbench": [2,0,0]
}

var inZone = []
var nbTree :int= 0
var nbRock :int= 0
var nbBush :int= 0

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
	print(str(recipes_available()))
	print(str(nbTree)+" "+str(nbRock)+" "+str(nbBush))


func _on_area_exited(area):
	inZone.remove_at(inZone.find(area))
	sub_ressources(area.get_item_id_type())
	print(str(inZone.size()))

func is_in_3arg(lst1,lst2):
	for i in lst1.size():
		if lst2[i]-lst1[i] <0:
			return false
	return true
