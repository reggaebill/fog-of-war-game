extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # No need to call update() here for Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Draw a circle around the perimeter of this area
# func _draw():
# 	# Draw only the perimeter (outline) of the circle
# 	var center : Vector2 = Vector2.ZERO # Center at the node's origin
# 	var radius : float = 535 # Set your desired radius
# 	var color : Color = Color(1, 1, 1, 1) # White
# 	var width : float = 2.0 # Outline thickness
# 	var points : int = 128 # Smoothness of the arc
# 	draw_arc(center, radius, 0, TAU, points, color, width)

