extends CanvasLayer

@onready var animation : AnimationPlayer = $AnimationPlayer

func load_scene(target: String) -> void:
	animation.play("scene_transition")
	await animation.animation_finished
	get_tree().change_scene_to_file(target)
	animation.play_backwards("scene_transition")

func game_over() -> void:
	animation.play("game over")
	await animation.animation_finished
	load_scene("res://Scenes/title_screen.tscn")
	GlobalManager.enemies_killed = 0

func enter_game() -> void:
	animation.play("enter game")
	await animation.animation_finished
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	animation.play_backwards("scene_transition")