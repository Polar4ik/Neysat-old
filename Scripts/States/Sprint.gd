extends Walk

const SPRINT_SPEED := 5.0
@onready var stamina_node: Node = %Stamina

func enter() -> void:
	if stamina_node.get_stamina() != 0:
		speed = SPRINT_SPEED
		Events.walk.connect(func(): transition.emit(self, "Walk"))
	else:
		transition.emit(self, "Walk")

func update(_delta: float) -> void:
	if stamina_node.get_stamina() == 0:
		transition.emit(self, "Walk")
	else:
		Events.use_stamina.emit()
