extends Node2D

const BULLET = preload("orb.tscn")
@onready var shoot_timer : Timer = $Shoot_timer

@onready var muzzle: Marker2D = $"Right Gun2/Muzzle"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())

	rotation_degrees = wrap(rotation_degrees, 0 ,360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	if shoot_timer.is_stopped():
		if Input.is_action_just_pressed("fire"):
			var bullet_instance = BULLET.instantiate()
			bullet_instance.global_position = muzzle.global_position
			# bullet_instance.rotation = rotation
			get_tree().current_scene.add_child(bullet_instance)
			shoot_timer.start()

# func _on_shoot_timer_timeout() -> void:
# 	print("time to shoot")
# 	if Input.is_action_just_pressed("fire"):
# 		var bullet_instance = BULLET.instantiate()
# 		bullet_instance.global_position = muzzle.global_position
# 		# bullet_instance.rotation = rotation
# 		get_tree().current_scene.add_child(bullet_instance)
# 		shoot_timer.start()
