extends CanvasLayer
@export var animation: AnimationPlayer
# @onready var optionsMenu = preload("res://options_menu.tscn")
func _ready():
	animation.play("RESET")

func resume():
	get_tree().paused = false
	animation.play("resume")

func pause():
	get_tree().paused = true
	animation.play("pause")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _process(_delta):
	testEsc()

# func _on_restart_button_pressed() -> void:
# 	resume()
# 	get_tree().reload_current_scene()



func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_menu_button_pressed() -> void:
	resume()
	SceneTransition.change_scene("res://Scenes/title_screen.tscn")


func _on_resume_button_pressed() -> void:
	pass # Replace with function body.
