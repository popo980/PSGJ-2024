extends Control


@onready var v_box_container = $VBoxContainer
var shadows = {
	"Sheep": 0,
	"Boar": 0,
	"Fox": 0
}

var icons = {
	"Sheep": preload("res://Assets/Mob/Animals/shadow_icons/sheep_shadow_icon.png"),
	"Boar": preload("res://Assets/Mob/Animals/shadow_icons/boar_shadow_icon.png"),
	"Fox": null
}

var displays = {
	"Sheep": null,
	"Boar": null,
	"Fox": null
}

const SHADOW_DISPLAY = preload("res://Scene/shadow_display.tscn")

func add_shadow(mob_name):
	shadows[mob_name] += 1
	if shadows[mob_name] == 1:
		var icon = SHADOW_DISPLAY.instantiate()
		v_box_container.add_child(icon)
		icon.get_node("Sprite2D").texture = icons[mob_name]
		displays[mob_name] = icon
	else:
		displays[mob_name].get_node("Label").text = str(int(displays[mob_name].get_node("Label").text) + 1) 

