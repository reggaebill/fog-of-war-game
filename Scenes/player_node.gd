extends Node2D

# @export var player: CharacterBody2D
# @onready var line: Line2D = $Line2D
# @onready var rigidbody: RigidBody2D = $OrbRigid
# @onready var staticbody: StaticBody2D = $Gun/StaticBody2D


# func _ready():
# 	line.clear_points()
# 	line.add_point(rigidbody.global_position - self.global_position)
# 	line.add_point(staticbody.global_position - self.global_position)

	


# func _physics_process(_delta):
# 	line.clear_points()
# 	line.add_point(rigidbody.global_position - self.global_position)
# 	line.add_point(staticbody.global_position - self.global_position)
# 	pass



# @onready var joint:= $DampedSpringJoint2D
# var point_1 = Vector2.ZERO
# var point_2 = Vector2.ZERO

# func _ready():
# 	set_process(true)
# 	set_physics_process(false)
# 	queue_redraw()

# func _process(_delta):
# 	point_1 = joint.get_node_a().get_as_property_path("position")
# 	point_2 = joint.get_node_b().get_as_property_path("position")
# 	queue_redraw()

# func _draw():
# 	draw_line(point_1, point_2, Color(1, 1, 1, 1), 2)
