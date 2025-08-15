extends Node2D

@export var rest_length = 200.0
@export var stiffness = 15.0
@export var damping = 1.0

@onready var player := get_parent()
@onready var ray := $RayCast2D
@onready var rope := $Line2D

var max_follow_distance = 400.0
var launched = false
var target: Vector2

func _process(delta):
	ray.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("grapple_shoot"):
		launch()
	if Input.is_action_just_released("grapple_shoot"):
		retract()
	
	if launched:
		handle_grapple(delta)

func launch():
	if ray.is_colliding():
		print("Grapple launched at: ", ray.get_collision_point())
		# PlayerSfx.grapple()
		launched = true
		target = ray.get_collision_point()
		rope.show()

func retract():
	launched = false
	rope.hide()


func handle_grapple(delta):
	var target_dir = player.global_position.direction_to(target)
	var target_dist = player.global_position.distance_to(target)
	var displacement = target_dist - rest_length
	
	var force = Vector2.ZERO
	
	if displacement > 0:
		var spring_force_magnitude = stiffness * displacement
		var spring_force = target_dir * spring_force_magnitude
		
		var vel_dot = player.velocity.dot(target_dir)
		var damping = -damping * vel_dot * target_dir
		
		force = spring_force + damping
		if Input.is_action_pressed("grapple_pull"):
			rest_length = lerp(rest_length, 0.0, delta)
		if Input.is_action_just_released("grapple_pull"):
			rest_length = 200.0
	player.velocity += force * delta
	update_rope()



func update_rope():
	rope.set_point_position(1, to_local(target))
