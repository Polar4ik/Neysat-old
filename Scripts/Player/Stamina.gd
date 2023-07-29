extends Node

@onready var timer: Timer = $TimeToRestoreStamina

@export var MAX_STAMINA := 100.0
var stamina := 0.0

var can_renewal := false

func get_stamina() -> float:
	return stamina


func _ready() -> void:
	stamina = MAX_STAMINA
	Events.adrenaline.connect(adreniline)
	Events.renewal_stamina.connect(start_timer)
	Events.use_stamina.connect(use_stamina)

func _process(_delta: float) -> void:
#	print(stamina)
	if can_renewal:
		rewal_stamina()


#-----------stamina-------
func rewal_stamina() -> void:
	if stamina == MAX_STAMINA:
		can_renewal = false
	
	if not timer.is_stopped():
		stop_timer()
	
#	print(stamina)
	stamina += 0.05
	stamina = clampf(stamina, 0.0, MAX_STAMINA)
	update_bar()

func use_stamina() -> void:
	if not timer.is_stopped():
		stop_timer()
	
	can_renewal = false
	
#	print(stamina)
	stamina -= 0.5
	stamina = clampf(stamina, 0.0, MAX_STAMINA)
	update_bar()

func adreniline(value: float) -> void:
	stamina += value
	stamina = clampf(stamina, 0.0, MAX_STAMINA)
	update_bar()
#-------------------------


#----------timer----------
func start_timer() -> void:
	if timer.is_stopped():
		print("START")
		timer.start()

func stop_timer() -> void:
	print("STOP")
	timer.stop()

func _on_time_to_restore_stamina_timeout() -> void:
	if can_renewal == false:
		print("TIMEOUT")
		can_renewal = true
#-------------------------

func update_bar() -> void:
	Events.stamina_bar_update.emit(stamina)
