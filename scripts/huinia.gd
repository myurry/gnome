extends Node2D

const SPEED = 20
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right_wall: RayCast2D = $RayCastRightWall
@onready var ray_cast_left_wall: RayCast2D = $RayCastLeftWall

var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_right_wall.is_colliding() or !ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	elif ray_cast_left_wall.is_colliding() or !ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

	
	position.x += direction * SPEED * delta
