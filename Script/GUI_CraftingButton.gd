extends Button

var craftName

func setCraftAttribute(newName:String):
	craftName = newName
	match newName:
		"Workbench":
			icon = load("res://Assets/Temporaire/workbench.png")
		_:
			print("ERREUR CRAFT INCONNU")

func _on_pressed():
	var gui = get_parent().get_parent()
	gui.ButtonPressed(craftName)
