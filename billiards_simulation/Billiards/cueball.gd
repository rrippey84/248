extends RigidBody3D

@onready var cueBall: RigidBody3D = $"."
@onready var spawn_marker: Marker3D = $"../../CueBallSpawn"


func _on_area_entered(area: Area3D) -> void:
	if area.name == "PocketArea":
		respawn()

func respawn() -> void:
	global_position = spawn_marker.global_position
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
