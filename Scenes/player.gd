class_name Player
extends CharacterBody2D


	# Player class for handling player-specific logic
	# This class can be extended with more player-related functionality

@onready var animation_player: AnimationPlayer = $Node2D/Init
@onready var run_animation: AnimationPlayer = $Node2D/Arms

var original_scale_x := 1.0
const SPEED = 300.0
const ACCEL = 2000.0
const DECCEL = 1500.0
const DASH_SPEED = 800.0
const DASH_TIME = 0.15
const BULLET = preload("orb.tscn")
var dash_timer = 0.0
var dash_direction = Vector2.ZERO



func _ready() -> void:
	original_scale_x = scale.x

func _physics_process(delta: float) -> void:
	_flip_sprite()
	var player_pos = global_position
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("right"):
		input_vector.x += 1
	if Input.is_action_pressed("left"):
		input_vector.x -= 1
	if Input.is_action_pressed("down"):
		input_vector.y += 1
	if Input.is_action_pressed("up"):
		input_vector.y -= 1
	input_vector = input_vector.normalized()

	if dash_timer > 0.0:
		dash_timer -= delta
		velocity = dash_direction * DASH_SPEED
		if dash_timer <= 0.0:
			velocity = Vector2.ZERO

	else:
		var target_velocity = input_vector * SPEED
		if input_vector.length() > 0.0:
			velocity = velocity.move_toward(target_velocity, ACCEL * delta)
		else:
			velocity = velocity.move_toward(Vector2.ZERO, DECCEL * delta)

		if Input.is_action_just_pressed("dash") and input_vector != Vector2.ZERO:
			dash_timer = DASH_TIME
			dash_direction = input_vector


	move_and_slide()

func _flip_sprite() -> void:
	# Flip the sprite based on input direction, not velocity
	if (Input.is_action_just_pressed("right") and (velocity.x <= 0.0)):
		scale.x = -abs(original_scale_x)
	elif (Input.is_action_just_pressed("left") and (velocity.x > 0.0)):
		scale.x = -abs(original_scale_x)

func animations() -> void:
		if velocity.length() > 0.0:
			animation_player.play("gun_run_ready")
			await animation_player.animation_finished
			run_animation.play("gun_run")
		else:
			animation_player.play("idle")
