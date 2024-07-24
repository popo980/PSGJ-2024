extends Control

signal shadow_selected(display)
var mouse_in

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("shadow_selected", Callable(self, "on_shadow_selected_signal"))

func _process(_delta):
	if mouse_in && Input.is_action_just_pressed("Hit"):
		print("CLICKCLICKCLICK")
		emit_signal("shadow_selected", self)


func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited():
	mouse_in = false
