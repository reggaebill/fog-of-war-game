extends CharacterBody2D
class_name Wasp
@export var animatedsprite: AnimatedSprite2D
@export var sprite: Node2D
const SPEED = 150.0
var speed_mult = 1.0
@onready var player = GlobalManager.player
var push_force = 500.0
var _player = null
var enemy = null
var push_vector = Vector2.ZERO
var health = 50
const DASH_SPEED = 800.0
const DASH_TIME = 4.0
const ACCEL = 2000.0
const DECCEL = 400.0
var dash_timer = 0.0
var attack_player = false
var dash_direction = Vector2.ZERO

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if _player:
		look_at(_player.global_position)
		rotation_degrees = wrap(rotation_degrees, 0 ,360)
		if rotation_degrees > 90 and rotation_degrees < 270:
			scale.y = -1
		else:
			scale.y = 1
		if animatedsprite.is_playing():
			Vector2.ZERO
			rotation_degrees = 0.0
		else:
			var to_player = _player.global_position - global_position
			var direction = to_player.normalized()
			velocity = direction * SPEED - push_vector
		
			if dash_timer > 0.0:
				dash_timer -= delta
				velocity = dash_direction * DASH_SPEED
				if dash_timer <= 0.0:
					velocity = Vector2.ZERO

			else:
				var target_velocity = direction * SPEED
				if direction.length() > 0.0:
					velocity = velocity.move_toward(target_velocity, ACCEL * delta)
				else:
					velocity = velocity.move_toward(Vector2.ZERO, DECCEL * delta)

				if attack_player == true:
					dash_timer = DASH_TIME
					dash_direction = direction

			move_and_slide()
		
			
	

		# Optional: Attack if close to player

func _attack_player() -> void:
	# Placeholder for attack logic
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_player = body
		# var to_player = body.global_position - global_position
		# var direction = to_player.normalized()
		# velocity = direction * SPEED
		


func _on_avoidance_body_entered(body: CharacterBody2D) -> void:
	# print("Avoidance body entered: ", body.name)
	if body != self:
		enemy = body
		# print("Applying push force to: ", enemy.name)


func _on_attack_zoom_body_entered(body:Node2D) -> void:
	if body == _player:
		attack_player = true
		
func _on_avoidance_body_exited(body: CharacterBody2D) -> void:
	# print("Avoidance body exited: ", body.name)
	if body != self:
		enemy = null
		push_vector = Vector2.ZERO
		# print("Resetting push vector")


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.name != "Hurtbox": 
		velocity = Vector2.ZERO
		sprite.hide()
		animatedsprite.play("Splat")


func _on_animated_sprite_2d_animation_finished() -> void:
	GlobalManager.enemy_hit.emit()
	queue_free()

func _on_node_2d_visibility_changed() -> void:
	pass
