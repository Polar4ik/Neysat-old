extends State
class_name Walk

const SPEED := 3.0

var speed := 0.0

@onready var player: CharacterBody3D = $"../.."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func _ready() -> void:
	speed = SPEED
	Events.jump.connect(func(): transition.emit(self, "Jump"))
	Events.sprint.connect(func(): transition.emit(self, "Sprint"))

func enter() -> void:
	speed = SPEED
	animation_player.play("Walk")
	Events.renewal_stamina.emit()

func physics_update(_delta: float) -> void: 
	walk()

func walk() -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "down")
	var direction := (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if not player.is_on_floor():
		transition.emit(self, "Idle")
	
	if direction:
		player.velocity.x = direction.x * speed
		player.velocity.z = direction.z * speed
	else:
		transition.emit(self, "Idle")
