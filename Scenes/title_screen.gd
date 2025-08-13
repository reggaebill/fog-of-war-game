extends Control



func _on_start_button_pressed() -> void:
	SceneTransition.load_scene("Scenes/main.tscn")
	
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()
