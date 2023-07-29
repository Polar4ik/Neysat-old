extends Node

@export var init_state: State

var curent_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(state_transition)
	
	if init_state:
		curent_state = init_state
		curent_state.enter()

func _process(delta: float) -> void:
	if curent_state:
		curent_state.update(delta)

func _physics_process(delta: float) -> void:
	if curent_state:
		curent_state.physics_update(delta)

func state_transition(state, new_state_name) -> void:
	if state != curent_state:
		return
	
	var new_states = states.get(new_state_name.to_lower())
	if not new_states:
		return
	
	if curent_state:
		curent_state.exit()
	curent_state = new_states
	
	new_states.enter()
