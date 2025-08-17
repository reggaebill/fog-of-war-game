extends Node2D


# Called when the node enters the scene tree for the first time.
@export var path: Path2D
const WASP_SCENE =  preload("res://Scenes/wasp.tscn")
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
	spawn_timer.queue_free()
	var wasp_instance = WASP_SCENE.instantiate()
	var path_follow = PathFollow2D.new()
	path.add_child(path_follow)
	path_follow.progress_ratio = randf_range(0.0, 1.0)
	wasp_instance.position = path_follow.position
	get_tree().current_scene.add_child(wasp_instance)
	path_follow.queue_free()
	wasp_instance.add_to_group("enemies")
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.autostart = true
	spawn_timer.one_shot = true
	add_child(spawn_timer)
	spawn_timer.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))
	spawn_interval -= 0.1 # Adjust spawn interval based on frame rate
	if spawn_interval <= 0.1:
		spawn_interval = 0.1
