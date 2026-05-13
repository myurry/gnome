class_name GnomeRollState extends GnomeState


var state_name = "GnomeRollState"

var on_ground = false
const SPEED = 150
const JUMP_SPEED = 400
const FRICTION = 0.7



func enter() -> void:
	pass


func exit() -> void:
	pass


func process(delta:float) -> void:
	pass


func physics_process(delta:float) -> void:
	gnome.ground_cast.global_position = Vector2(gnome.position.x, gnome.position.y + 6)
	gnome.ground_cast.global_rotation = 0
	if (gnome.ground_cast.is_colliding()):
		on_ground = true;
		
	gnome.gpu_particles.emitting = true
	gnome.linear_velocity.x = gnome.horizontal_input * SPEED


func get_state_name():
	return state_name
