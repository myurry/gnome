class_name GnomeRollState extends GnomeState


<<<<<<< Updated upstream
var state_name = "GnomeRollState"

var on_ground = false
const SPEED = 150
const JUMP_SPEED = 400
=======
static var state_name = "GnomeRollState"

var on_ground = false
const SPEED = 150
>>>>>>> Stashed changes
const FRICTION = 0.7



func enter() -> void:
<<<<<<< Updated upstream
	pass
=======
	gnome.angular_velocity = 0
	gnome.gpu_particles.emitting = true
	gnome.physics_material_override.friction = FRICTION
	
	gnome.gun.hide()
	
>>>>>>> Stashed changes


func exit() -> void:
	pass


func process(delta:float) -> void:
	pass


func physics_process(delta:float) -> void:
<<<<<<< Updated upstream
	gnome.ground_cast.global_position = Vector2(gnome.position.x, gnome.position.y + 6)
	gnome.ground_cast.global_rotation = 0
	if (gnome.ground_cast.is_colliding()):
		on_ground = true;
		
	gnome.gpu_particles.emitting = true
	gnome.linear_velocity.x = gnome.horizontal_input * SPEED

=======
	gnome.linear_velocity.x = gnome.horizontal_input * SPEED
	
	if (Input.is_action_just_pressed("action")):
		if gnome.on_ground:
			state_machine.transition(GnomeJumpState.state_name)

	if !gnome.ball_mode:
		state_machine.transition(GnomeTurretState.state_name)
>>>>>>> Stashed changes

func get_state_name():
	return state_name
