class_name State


func enter() -> void:
	pass
	
	
func exit() -> void:
	pass
	
	
func process(delta:float) -> void:
	pass
	
	
func physics_process(delta:float) -> void:
	pass


func get_state_name():
	push_error("Ты забыл добавить get_state_name(), пидорас")
	return ""
