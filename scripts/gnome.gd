extends RigidBody2D

var ball_mode = false
const BALL_SPEED = 500
const SPEED = 200
const ANGULAR_SPEED = 10
const FRICTION = 1
const GRAVITY = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.physics_material_override.friction = FRICTION

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	state.add_constant_central_force(Vector2(0, GRAVITY))
	if !ball_mode:
		self.rotation = 0
	if (Input.is_action_just_released("mode")):
		self.angular_velocity = 0
		self.linear_velocity = Vector2.ZERO
		ball_mode = !ball_mode
		
	if (Input.is_action_pressed("right")):
		if !ball_mode:
			self.linear_velocity.x = SPEED
		else:
		
			self.linear_velocity.x = BALL_SPEED
		
	if (Input.is_action_pressed("left")):
		if !ball_mode:
			self.linear_velocity.x = -SPEED
		else:
			self.linear_velocity.x = -BALL_SPEED
		
