extends CanvasLayer

@onready var animation : AnimationPlayer = $AnimationPlayer

func load_scene(target: String) -> void:
	animation.play("scene_transition")
	await animation.animation_finished
	get_tree().change_scene_to_file(target)
	animation.play_backwards("scene_transition")
