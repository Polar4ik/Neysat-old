extends State
class_name Idle

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var player: CharacterBody3D = $"../.."

func _ready() -> void:
	Events.walk.connect(func(): transition.emit(self, "Walk"))
	Events.jump.connect(func(): transition.emit(self, "Jump"))
	Events.sprint.connect(func(): transition.emit(self, "Sprint"))

func enter() -> void:
	animation_player.play("Idle")
	Events.renewal_stamina.emit()

func physics_update(delta: float) -> void:
	if abs(player.velocity.z) != 0.0 or abs(player.velocity.x) != 0.0:
		stop(delta)

func stop(delta: float) -> void:
	player.velocity.x = lerpf(player.velocity.x, 0.0, 9.0 * delta)
	player.velocity.z = lerpf(player.velocity.z, 0.0, 9.0 * delta)
