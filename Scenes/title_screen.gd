extends Control
@export var hover_sound : AudioStreamPlayer
@export var unhover_sound : AudioStreamPlayer
@export var pc : Node2D

func _ready() -> void:
	GlobalManager.enemies_killed = 0
	pc.visible = true

func _on_start_button_pressed() -> void:
	pc.visible = false
	SceneTransition.enter_game()
	
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()



func _on_quit_button_mouse_exited() -> void:
	unhover_sound.play()


func _on_quit_button_mouse_entered() -> void:
	hover_sound.play()


func _on_start_button_mouse_exited() -> void:
	unhover_sound.play()

func _on_start_button_mouse_entered() -> void:
	hover_sound.play()
