extends RigidBody2D

var ball_mode = false
var on_ground = false
const BALL_SPEED = 150
const SPEED = 75
const FRICTION = 1
const BALL_FRICTION = 0.7
const JUMP_SPEED = 400
const BULLET = preload("res://scenes/bullet/bullet.tscn")

@export var jump_sound: AudioStream
@export var shoot_sound: AudioStream
@onready var audio = $AudioStreamPlayer

@onready var gun: Node2D = $Gun
@onready var shoot_timer: Timer = $ShootTimer

 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.physics_material_override.friction = FRICTION
	self.gravity_scale = 1.5
	gun.hide()

# Calledx every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	$GroundCast.global_position = Vector2(position.x, position.y + 6)
	$GroundCast.global_rotation = 0
	if (!$GroundCast.is_colliding() && $GroundTimer.is_stopped()):
		$GroundTimer.start();
	elif ($GroundCast.is_colliding()):
		on_ground = true;
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
			get_node("ball_form").set_deferred('disabled', false)
			get_node("gnome_form").set_deferred('disabled', true)
		else:
			self.physics_material_override.friction = FRICTION
			get_node("ball_form").set_deferred('disabled', true)
			get_node("gnome_form").set_deferred('disabled', false)
		
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
	
	if (Input.is_action_just_pressed("action") && on_ground):
		if ball_mode:
			jump()
		else:
			if (Input.is_action_pressed("ui_up")):
				shoot("up", "right")
			elif (Input.is_action_pressed("ui_down")):
				shoot("down", "right")
			else:
				shoot("forward", "right")
		
func _on_ground_timer_timeout() -> void:
	on_ground = false;
	
func shoot(direction:String, side:String) -> void:
	gun.show()
	
	match direction:
		"up":
			gun.rotation = -0.610865238
		"forward":
			gun.rotation = 0
		"down":
			gun.rotation = 0.610865238
		
	var bullet_instance = BULLET.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = gun.fire_location.global_position
	bullet_instance.rotation = gun.rotation
	
	audio.stream = shoot_sound
	audio.play()
	
	shoot_timer.start()
	
	
	
func jump() -> void:
	audio.stream = jump_sound
	audio.play()
	self.linear_velocity.y = -JUMP_SPEED


func _on_shoot_timer_timeout() -> void:
	gun.hide()
