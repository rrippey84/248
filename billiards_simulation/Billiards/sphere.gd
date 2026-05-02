extends Node3D

@export var move_speed: float = 3.0
@export var rotation_speed: float = 1.5
@export var shot_power: float = 8.0
@onready var cue_ball: Node3D = $"../../../cueBall"

func _process(delta: float) -> void:
	var move_input := Vector3.ZERO
	var rot_input := 0.0

	# Inverted movement directions
	if Input.is_action_pressed("move_forwards"):
		move_input -= transform.basis.z
	if Input.is_action_pressed("move_backwards"):
		move_input += transform.basis.z
	if Input.is_action_pressed("move_left"):
		move_input += transform.basis.x
	if Input.is_action_pressed("move_right"):
		move_input -= transform.basis.x

	# Rotation
	if Input.is_action_pressed("turn_left"):
		rot_input += 1.0
	if Input.is_action_pressed("turn_right"):
		rot_input -= 1.0

	rotation.y += rot_input * rotation_speed * delta

	# Shooting
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	var dir: Vector3 = (cue_ball.global_position - global_position).normalized()
	cue_ball.apply_impulse(dir * shot_power)
