class_name GnomeRollState extends GnomeState


static var state_name = "GnomeRollState"


const SPEED = 150
const FRICTION = 0.7


func enter() -> void:
	gnome.gpu_particles.emitting = true
	gnome.physics_material_override.friction = FRICTION
	
	gnome.ball_form.set_deferred('disabled', false)
	gnome.gnome_form.set_deferred('disabled', true)
	
	gnome.gun.hide()


func exit() -> void:
	pass


func process(delta:float) -> void:
	pass


func physics_process(delta:float) -> void:
	if gnome.horizontal_input > 0:
		gnome.linear_velocity.x = SPEED
	
	if gnome.horizontal_input < 0:
		gnome.linear_velocity.x = -SPEED
	
	if (Input.is_action_just_pressed("action")):
		if gnome.on_ground:
			state_machine.transition(GnomeJumpState.state_name)

	if Input.is_action_just_pressed("mode"):
		state_machine.transition(GnomeTurretState.state_name)


func get_state_name():
	return state_name
