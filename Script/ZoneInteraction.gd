extends Area2D

var inZone = []



func _on_area_entered(area):
	inZone.append(area)
	print(str(inZone.size()))


func _on_area_exited(area):
	inZone.remove_at(inZone.find(area))
	print(str(inZone.size()))
