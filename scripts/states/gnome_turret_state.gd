class_name GnomeTurretState extends GnomeState


static var state_name = "GnomeTurretState"
const SPEED = 75
const FRICTION = 1

const BULLET = preload("res://scenes/bullet/bullet.tscn")
var gun: Node2D

var is_log_enabled: bool = true


func enter() -> void:
	gnome.physics_material_override.friction = FRICTION
	gnome.gravity_scale = 1.5
	gnome.gpu_particles.emitting = false
	gun = gnome.gun
	gun.show()
	gnome.ball_form.set_deferred('disabled', true)
	gnome.gnome_form.set_deferred('disabled', false)
	
	if gnome.linear_velocity.x > 2:
		switch_to_right_hand()
	elif gnome.linear_velocity.x < -2:
		switch_to_left_hand()
		
	

func exit() -> void:
	pass


func process(delta:float) -> void:
	pass


func physics_process(delta:float) -> void:
	gnome.rotation = 0
	
	if gnome.horizontal_input > 0:
		switch_to_right_hand()
		gnome.linear_velocity.x = SPEED
	
	if gnome.horizontal_input < 0:
		switch_to_left_hand()
		gnome.linear_velocity.x = -SPEED
	
	
	if Input.is_action_just_pressed("mode"):
		state_machine.transition(GnomeRollState.state_name)
	
	if Input.is_action_just_pressed("action"):
		if (Input.is_action_pressed("ui_up")):
			shoot("up")
		elif (Input.is_action_pressed("ui_down")):
			shoot("down")
		else:
			shoot("forward")
		
		
func shoot(aim_direction:String) -> void:
	match aim_direction:
		"up":
			gun.rotation = deg_to_rad(-35 * (1 if gun.scale.x == 1 else -1))
		"forward":
			gun.rotation = 0
		"down":
			gun.rotation = deg_to_rad(35 * (1 if gun.scale.x == 1 else -1))
		
		
	var bullet_instance = BULLET.instantiate()
	gnome.get_tree().root.call_deferred("add_child", bullet_instance)
	bullet_instance.global_position = gun.muzzle.global_position
	bullet_instance.rotation = gun.rotation + (deg_to_rad(180) if gun.scale.x == -1 else 0)
	
	audio.stream = state_machine.shoot_sound
	audio.play()
		
		
func switch_to_right_hand() -> void:
	gun.scale.x = 1
	gun.position = Vector2(5, 3)
	
func switch_to_left_hand() -> void:
	gun.scale.x = -1
	gun.position = Vector2(-5, 3)

func get_state_name():
	return state_name
