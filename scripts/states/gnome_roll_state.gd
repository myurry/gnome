class_name GnomeRollState extends GnomeState


static var state_name = "GnomeRollState"

var on_ground = false
const SPEED = 150

const FRICTION = 0.7



func enter() -> void:

	gnome.angular_velocity = 0
	gnome.gpu_particles.emitting = true
	gnome.physics_material_override.friction = FRICTION
	
	gnome.gun.hide()
	



func exit() -> void:
	pass


func process(delta:float) -> void:
	pass


func physics_process(delta:float) -> void:

	gnome.linear_velocity.x = gnome.horizontal_input * SPEED
	
	if (Input.is_action_just_pressed("action")):
		if gnome.on_ground:
			state_machine.transition(GnomeJumpState.state_name)

	if !gnome.ball_mode:
		state_machine.transition(GnomeTurretState.state_name)


func get_state_name():
	return state_name
