extends Node2D
@export var title_animation: AnimatedSprite2D

func _on_animated_sprite_2d_animation_finished() -> void:
	title_animation.queue_free()
