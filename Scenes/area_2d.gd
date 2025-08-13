extends Area2D


var speed = 400
# Called when the node enters the scene tree for the first time.
var velocity = Vector2.ZERO

func _ready() -> void:
	# Shoot toward the mouse location on screen
	var mouse_pos = get_viewport().get_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	velocity = direction * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Move the bullet
	position += velocity * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()