extends Node2D


@onready var player : CharacterBody2D = load("res://Scenes/player.tscn").instantiate()
var muzzle := player.get_node("Right Gun2/Muzzle")
var orb := player.get_node("OrbRigid")
var muzzle_pos = Vector2.ZERO
var orb_pos = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	queue_redraw() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	muzzle_pos = muzzle.global_position
	orb_pos = orb.global_position
	queue_redraw()

func _draw() -> void:
	draw_line(muzzle_pos, (muzzle_pos + orb_pos), Color.WHITE, 10.0)
