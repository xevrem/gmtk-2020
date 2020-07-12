extends Node
class_name PlayerInput


onready var viewport = get_viewport().get_visible_rect()

var fire_rate: = 0.500
var fire_elapsed: = 0.0
var half_view: = Vector2.ZERO

func _ready():
	half_view = Vector2(
		viewport.size.x / 2,
		viewport.size.y / 2
	)

func _process(delta) -> void:
	var mouse_offset = (get_viewport().get_mouse_position() - half_view)
	var mouse_position = owner.camera.global_position + mouse_offset
	var mouse_vector = owner.global_position.direction_to(mouse_position)
	
	fire(delta, mouse_vector)
	
	# calculate friction to slow player down after shot
	owner.velocity = owner.velocity.move_toward(Vector2.ZERO, owner.friction * delta)
	
	# calculate the rotation of the player based on mouse_vector
	owner.sprites.rotation = owner.global_position.angle_to_point(mouse_position) - PI/2

func fire(delta: float, direction: Vector2) -> void:
	fire_elapsed += delta
	if Input.is_action_pressed("fire") and fire_elapsed >= fire_rate:
		fire_elapsed = 0.0
		# fire our bullet
		var impulse = owner.shooter.shoot('bullet', direction)
		
		### now we want to alter the player velocity because of the shot
		var impulse_vector = direction.rotated(PI)
		owner.velocity = impulse_vector * impulse
