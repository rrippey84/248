extends RigidBody3D

@export var move_speed: float = 4.0
@export var rotate_speed: float = 1.5
@export var max_force: float = 30.0
@export var charge_rate: float = 20.0
@export var cue_ball: RigidBody3D

var current_force: float = 0.0
var charging := false

func _physics_process(delta):
	handle_movement(delta)
	handle_rotation(delta)
	handle_shooting(delta)


func handle_movement(delta):
	var move = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):
		move.z -= 1
	if Input.is_action_pressed("move_back"):
		move.z += 1
	if Input.is_action_pressed("move_left"):
		move.x -= 1
	if Input.is_action_pressed("move_right"):
		move.x += 1

	if move != Vector3.ZERO:
		global_position += move.normalized() * move_speed * delta


func handle_rotation(delta):
	if Input.is_action_pressed("turn_left"):
		rotate_y(rotate_speed * delta)
	if Input.is_action_pressed("turn_right"):
		rotate_y(-rotate_speed * delta)


func handle_shooting(delta):
	if Input.is_action_just_pressed("shoot"):
		charging = true

	if Input.is_action_pressed("shoot") and charging:
		current_force = clamp(current_force + charge_rate * delta, 0, max_force)

	if Input.is_action_just_released("shoot") and charging:
		charging = false
		fire_shot()
		current_force = 0.0


func fire_shot():
	if cue_ball == null:
		return

	var dir = -global_transform.basis.z.normalized()
	cue_ball.apply_impulse(dir * current_force)
