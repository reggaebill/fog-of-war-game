extends CharacterBody2D

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


func _on_hurtbox_body_entered() -> void:
	print("Hurtbox body entered")
	health -= 50
	if health <= 0:
		print("Wasp hit by orb")
		queue_free()  # Destroy the wasp if health is zero or below
