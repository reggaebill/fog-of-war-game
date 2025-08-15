extends Node2D

@onready var muzzle: Marker2D = $"Right Gun2/Muzzle"
@export var rope : Line2D
@export var orb : RigidBody2D
var muzzle_pos = Vector2.ZERO
var orb_pos = Vector2.ZERO

func _ready() -> void:
	queue_redraw()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())

	rotation_degrees = wrap(rotation_degrees, 0 ,360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

	muzzle_pos = muzzle.global_position
	orb_pos = orb.global_position

	# draw_line(muzzle.global_position, orb.global_position, Color.WHITE, 10.0)
	# update_rope()
	queue_redraw()

func _draw() -> void:
	draw_line(muzzle_pos, (muzzle_pos + orb_pos), Color.WHITE, 10.0)
# func update_rope() -> void:
# 	draw_line(muzzle.global_position, muzzle.global_position - orb.global_position, Color(1, 1, 1, 1), 2.0)
# 	rope.set_as_toplevel(true)

	# if rope:
	# 	rope.clear_points()
	# 	rope.add_point(muzzle.global_position)
	# 	var orb_pos = orb.get_global_position()
	# 	rope.add_point(orb_pos)
	# 	rope.set_as_toplevel(true)  # Ensure the rope is drawn correctly
	# else:
	# 	print("Rope not set in right_gun_2.gd")
