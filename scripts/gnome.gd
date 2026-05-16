extends RigidBody2D


var horizontal_input: float = 0.0
var on_ground = false
var on_wall = false
var on_left_wall = false
var on_right_wall = false

### DEPRECATED ###
#const BALL_SPEED = 150
#const JUMP_SPEED = 400
#const BALL_FRICTION = 0.7
#var ball_mode = false
#const SPEED = 75
#const FRICTION = 1



@onready var state_machine: StateMachine = $StateMachine

@onready var gpu_particles: GPUParticles2D = $GPUParticles2D
@onready var ground_cast: ShapeCast2D = $GroundCast

@onready var ball_form: CollisionShape2D = $ball_form
@onready var gnome_form: CollisionShape2D = $gnome_form

@onready var wall_cast_left: RayCast2D = $WallCastLeft
@onready var wall_cast_right: RayCast2D = $WallCastRight


@onready var audio = $AudioStreamPlayer

@onready var gun: Node2D = $Gun

 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.gravity_scale = 1.5

	var states: Array[State] = [GnomeTurretState.new(self), GnomeRollState.new(self), GnomeJumpState.new(self), GnomeSlideState.new(self)]

	state_machine.initialize_self(states)


# Calledx every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _physics_process(delta: float) -> void:
	horizontal_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	$GroundCast.global_position = Vector2(position.x, position.y + 6)
	$GroundCast.global_rotation = 0
	if (!$GroundCast.is_colliding() && $GroundTimer.is_stopped()):
		$GroundTimer.start()
	elif ($GroundCast.is_colliding()):
		on_ground = true
		
	on_right_wall = wall_cast_right.is_colliding()
	on_left_wall = wall_cast_left.is_colliding()
	on_wall = on_left_wall or on_right_wall
	
	
func _on_ground_timer_timeout() -> void:
	on_ground = false;
	
### DEPRECATED ###
#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#
	#$GroundCast.global_position = Vector2(position.x, position.y + 6)
	#$GroundCast.global_rotation = 0
	#if (!$GroundCast.is_colliding() && $GroundTimer.is_stopped()):
		#$GroundTimer.start();
	#elif ($GroundCast.is_colliding()):
		#on_ground = true;
	#if ball_mode:
		#gun.hide()
		#
			#
	#if !ball_mode:
		#gun.show()
		#self.rotation = 0
		#gpu_particles.emitting = false
		#
	#if (Input.is_action_just_pressed("mode")):
		#self.angular_velocity = 0
		#ball_mode = !ball_mode
		#if ball_mode:
			#self.physics_material_override.friction = BALL_FRICTION
			#ball_form.set_deferred('disabled', false)
			#gnome_form.set_deferred('disabled', true)
		#else:
			#self.physics_material_override.friction = FRICTION
			#ball_form.set_deferred('disabled', true)
			#gnome_form.set_deferred('disabled', false)
		#
	#if (Input.is_action_pressed("right")):
		#switch_to_right_hand()
		#if !ball_mode:
			#self.linear_velocity.x = SPEED
		#else:
			#gpu_particles.emitting = true
			#self.linear_velocity.x = BALL_SPEED
			#
	#if (Input.is_action_pressed("left")):
		#switch_to_left_hand()
		#if !ball_mode:
			#self.linear_velocity.x = -SPEED
		#else:
			#self.linear_velocity.x = -BALL_SPEED
	#
	#if (Input.is_action_just_pressed("action")):
		#if ball_mode && on_ground:
			#jump()
		#elif !ball_mode:
			#if (Input.is_action_pressed("ui_up")):
				#shoot("up")
			#elif (Input.is_action_pressed("ui_down")):
				#shoot("down")
			#else:
				#shoot("forward")
		#
		#



	
	
### DEPRECATED ###
#func shoot(aim_direction:String) -> void:
	#match aim_direction:
		#"up":
			#gun.rotation = deg_to_rad(-35 * (1 if gun.scale.x == 1 else -1))
		#"forward":
			#gun.rotation = 0
		#"down":
			#gun.rotation = deg_to_rad(35 * (1 if gun.scale.x == 1 else -1))
		#
		#
	#var bullet_instance = BULLET.instantiate()
	#get_tree().root.call_deferred("add_child", bullet_instance)
	#bullet_instance.global_position = gun.muzzle.global_position
	#bullet_instance.rotation = gun.rotation + (deg_to_rad(180) if gun.scale.x == -1 else 0)
#
#
	#audio.stream = shoot_sound
	#audio.play()
	


	
### DEPRECATED ###
#func jump() -> void:
	#audio.stream = jump_sound
	#audio.play()
	#self.linear_velocity.y = -JUMP_SPEED
