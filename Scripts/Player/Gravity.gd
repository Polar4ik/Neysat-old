extends Node

@onready var player: CharacterBody3D = $".."

const GRAVITATION := 9.3

func _physics_process(delta: float) -> void:
	gravity(delta)

func gravity(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity.y -= GRAVITATION * delta
