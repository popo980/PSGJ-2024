extends Area2D

var inZone = []


func _on_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	inZone.append(area)
	print(str(inZone.size()))



func _on_area_shape_exited(_area_rid, area, _area_shape_index, _local_shape_index):
	inZone.remove_at(inZone.find(area))
	print(str(inZone.size()))
