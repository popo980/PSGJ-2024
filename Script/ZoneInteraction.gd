extends Area2D

var inZone = []



func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	inZone.append(area)
	print(str(inZone.size()))



func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	inZone.remove_at(inZone.find(area))
	print(str(inZone.size()))
