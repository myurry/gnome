class_name StateMachine extends Node


var current_state: State
var states: Dictionary = {}

@export var is_log_enabled: bool = false



func initialize_self(init_states: Array[State]) -> void:
	if is_log_enabled:
		print("Запускаем шарманку...")
	
	
	for state in init_states:
		if is_log_enabled:
			if !state:
				push_error("Бля, в машину пустой стейт пришел")
		
		states[state.get_state_name()] = state
		
	current_state = init_states[0]
		
	if is_log_enabled:
		print("[%s]: Entering state \" %s \"" % [get_parent().get_class(), current_state.get_state_name()])
		
		
	current_state.enter()
	

func _process(delta: float) -> void:
	current_state.process(delta)
	

func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)
	
	
func transition(new_state_name: String) -> void:
	var new_state: State = states.get(new_state_name)
	var current_state_name = current_state.get_state_name()
	
	if new_state == null:
		push_error("Стейт машина пытается словить дзен...  (%s)" % new_state_name)
	elif new_state != current_state:
		current_state.exit()
		if is_log_enabled:
			print("[%s]: Exiting state \"%s\"" % [get_parent().get_class(), current_state.get_state_name()])
		
		current_state = states[new_state.get_state_name()]
		
		if is_log_enabled:
			print("[%s]: Entering state \"%s\"" % [get_parent().get_class(), current_state.get_state_name()])
	
		current_state.enter()
	else:
		push_warning("Стейт машина крутит (%s) без надобности" % new_state_name)
	
func get_active_state_name() -> String:
	return current_state.get_state_name()
	
