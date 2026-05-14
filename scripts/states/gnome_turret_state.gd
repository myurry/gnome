class_name GnomeTurretState extends GnomeState


static var state_name = "GnomeTurretState"
const SPEED = 75
const FRICTION = 1

func enter() -> void:
	gnome.physics_material_override.friction = FRICTION
	gnome.gpu_particles.emitting = false
	gnome.gun.show()

func exit() -> void:
	pass


func process(delta:float) -> void:
	pass


func physics_process(delta:float) -> void:
	gnome.linear_velocity.x = gnome.horizontal_input * SPEED
	gnome.rotation = 0
	
	if gnome.ball_mode:
		state_machine.transition(GnomeRollState.state_name)


func get_state_name():
	return state_name
