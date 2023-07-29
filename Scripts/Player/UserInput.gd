@icon("res://icon.svg")
extends Node

var sensity := 0.1

@onready var head := $"../Body/Head"
@onready var player := $".."

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		player.rotation_degrees.y += -event.relative.x * sensity
		head.rotation_degrees.x += -event.relative.y * sensity
		head.rotation_degrees.x = clamp(head.rotation_degrees.x, -90.0, 90.0)
	
	if Input.is_action_just_pressed("jump"):
		Events.jump.emit()

func _process(_delta: float) -> void:
	if Input.get_vector("left", "right", "forward", "down") and not Input.is_action_pressed("sprint"):
		Events.walk.emit()
	if Input.is_action_pressed("sprint") and Input.is_action_pressed("forward"):
		Events.sprint.emit()
