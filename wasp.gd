extends CharacterBody2D

const SPEED = 120.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Player:
		var to_player = Player.global_position - global_position
		var direction = to_player.normalized()
		velocity = direction * SPEED
		move_and_slide()

		# Optional: Attack if close to player
		if to_player.length() < 32:
			_attack_player()

func _attack_player() -> void:
	# Placeholder for attack logic
	pass
