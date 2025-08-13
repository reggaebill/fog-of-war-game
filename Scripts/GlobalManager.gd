extends Node

# GlobalManager: Singleton for managing player and enemies
@onready var player = get_tree().current_scene.get_node_or_null("Player")
var enemies: Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func register_player(p: Node) -> void:
	player = p

func get_player() -> Node:
	return player

func register_enemy(e: Node) -> void:
	if not enemies.has(e):
		enemies.append(e)

func unregister_enemy(e: Node) -> void:
	enemies.erase(e)

func get_enemies() -> Array:
	return enemies
