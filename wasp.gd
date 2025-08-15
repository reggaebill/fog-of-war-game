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
		push_vector = (enemy.global_position - self.global_position).normalized() * push_force
		enemy.velocity += push_vector
		
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
	queue_free()
