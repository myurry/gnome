extends RigidBody2D

var ball_mode = false
const BALL_SPEED = 300
const SPEED = 50
const FRICTION = 1
const BALL_FRICTION = 0.7
const JUMP_SPEED = 700

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.physics_material_override.friction = FRICTION
	self.gravity_scale = 3.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if ball_mode:
		if self.linear_velocity.length() > 10:
			get_node("GPUParticles2D").emitting = true
		else:
			get_node("GPUParticles2D").emitting = false
			
	if !ball_mode:
		self.rotation = 0
		get_node("GPUParticles2D").emitting = false
		
	if (Input.is_action_just_pressed("mode")):
		self.angular_velocity = 0
		ball_mode = !ball_mode
		if ball_mode:
			self.physics_material_override.friction = BALL_FRICTION
		else:
			self.physics_material_override.friction = FRICTION
		
	if (Input.is_action_pressed("right")):
		if !ball_mode:
			self.linear_velocity.x = SPEED
		else:
			get_node("GPUParticles2D").emitting = true
			self.linear_velocity.x = BALL_SPEED
			
	if (Input.is_action_pressed("left")):
		if !ball_mode:
			self.linear_velocity.x = -SPEED
		else:
			self.linear_velocity.x = -BALL_SPEED
			
	if (Input.is_action_just_pressed("action")):
		if ball_mode:
			self.linear_velocity.y = -JUMP_SPEED
		
