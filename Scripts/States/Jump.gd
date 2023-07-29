extends State
class_name Jump

const JUMP_VELOCITY := 4.0

@onready var player: CharacterBody3D = $"../.."

func enter() -> void:
	Events.renewal_stamina.emit()

func physics_update(_delta: float) -> void:
	jump()

func jump() -> void:
	if player.is_on_floor():
		player.velocity.y = JUMP_VELOCITY
	else:
		transition.emit(self, "Idle")
