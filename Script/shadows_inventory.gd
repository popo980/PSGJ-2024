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
	"Fox": preload("res://Assets/Mob/Animals/shadow_icons/fox_shadow.png")
}

var displays = {
	"Sheep": null,
	"Boar": null,
	"Fox": null
}


var player
signal add_shadow_enchantment(mob_name)
const SHADOW_DISPLAY = preload("res://Scene/shadow_display.tscn")

func _ready():
	connect("add_shadow_enchantment", Callable(self, "on_add_shadow_enchantment_signal"))
	player = get_parent().get_parent().get_parent().get_node("Player")

func add_shadow(mob_name):
	shadows[mob_name] += 1
	if shadows[mob_name] == 1:
		var icon = SHADOW_DISPLAY.instantiate()
		v_box_container.add_child(icon)
		icon.get_node("Sprite2D").texture = icons[mob_name]
		displays[mob_name] = icon
		icon.connect("shadow_selected", Callable(self, "on_shadow_selected_signal"))
	else:
		update_display(mob_name)

func on_shadow_selected_signal(display):
	if not player.can_select_shadows:
		return
	var mob_name = displays.find_key(display)
	if shadows[mob_name] > 0:
		shadows[mob_name] -= 1
		update_display(mob_name)
		emit_signal("add_shadow_enchantment", mob_name)

func update_display(mob_name):
	if shadows[mob_name]>0:
		displays[mob_name].get_node("Label").text = str(shadows[mob_name])
	else : 
		displays[mob_name].get_parent().remove_child(displays[mob_name])
		displays[mob_name].queue_free()
