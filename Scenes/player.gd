class_name Player
extends CharacterBody2D

@export var sprite : AnimatedSprite2D
@export var animations: AnimationPlayer
@export var player = self
@onready var line: Line2D = $Line2D
@onready var rigidbody: RigidBody2D = $Node2D/OrbRigid
@onready var staticbody: StaticBody2D = $Node2D/Gun/StaticBody2D

var health = 50.0
var original_scale_x := 1.0
const SPEED = 300.0
const ACCEL = 2000.0
const DECCEL = 1500.0
const DASH_SPEED = 2000.0
const DASH_TIME = 0.15
var dash_timer = 0.0
var dash_direction = Vector2.ZERO
var player_pos = null


func _ready() -> void:
	original_scale_x = scale.x

func _physics_process(delta: float) -> void:
	#do line stuff
	line.clear_points()
	line.add_point(rigidbody.global_position - self.global_position)
	line.add_point(staticbody.global_position - self.global_position)
	pass


	player_pos = global_position
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





func _on_area_2d_area_entered(area:Area2D) -> void:
	if health > 10:
		health -= 10
		animations.play("hurt")
	if health <= 10:
		# Handle player death
		velocity = Vector2.ZERO
		sprite.play("death")
		await sprite.animation_finished
		queue_free()
		SceneTransition.game_over()  # Assuming you have a SceneTransitions script to handle game over
