extends Node2D


# Called when the node enters the scene tree for the first time.

const WASP_SCENE =  preload("res://Scenes/Wasp.tscn")
const SPAWN_AREA = Vector2(1000, 1000)
var spawn_interval = 3.0

var spawn_timer: Timer

func _ready() -> void:
	print('enemies ready')
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.one_shot = true
	add_child(spawn_timer)
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	# Spawn a wasp at a random position in the 1000x1000 area
	var wasp_instance = WASP_SCENE.instantiate()
	var rand_x = randf_range(0, SPAWN_AREA.x)
	var rand_y = randf_range(0, SPAWN_AREA.y)
	wasp_instance.global_position = Vector2(rand_x, rand_y)
	get_tree().current_scene.add_child(wasp_instance)
	wasp_instance.add_to_group("enemies")
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.one_shot = true
	add_child(spawn_timer)
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	spawn_interval -= 0.6 # Adjust spawn interval based on frame rate
