class_name GnomeJumpState extends GnomeState


static var state_name = "GnomeJumpState"

const JUMP_SPEED = 400

func enter() -> void:
	gnome.linear_velocity.y = -JUMP_SPEED


func exit() -> void:
	pass


func process(delta:float) -> void:
	pass


func physics_process(delta:float) -> void:
	if gnome.on_ground:
		state_machine.transition(GnomeRollState.state_name)


func get_state_name():
	return state_name
