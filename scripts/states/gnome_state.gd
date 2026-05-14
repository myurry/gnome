class_name GnomeState extends State


var gnome: RigidBody2D
var state_machine: StateMachine
var audio: AudioStreamPlayer


func _init(gnome_rigidbody: RigidBody2D) -> void:
	gnome = gnome_rigidbody
	state_machine = gnome.state_machine
	audio = gnome.audio
	
