extends VBoxContainer

signal craft_selected(id)
var selected = null

func _ready():
	connect("craft_selected", Callable(self, "_on_craft_selected_signal"))



func select(id):
	craft_selected.emit(id)
