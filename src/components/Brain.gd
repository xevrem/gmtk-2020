extends Node

onready var parent: Enemy = owner

var path: PoolVector2Array = []
var path_index: = 0
var path_elapsed: = 0.0
var path_time_max: = 1.0

var shoot_elapsed: = 0.0
var shoot_rate: = 1.0

func _process(delta: float) -> void:
	if not parent.target: return
	
	stuck_on_path(delta)
	if owner.global_position.distance_to(owner.target.global_position) < 100 and has_LOS():
		shoot_web(delta)
		apply_friction(delta)
		look_towards(delta, parent.target.global_position)
	elif path.size() > 0 and path_index < path.size():
		follow_path(delta)
		look_towards(delta, parent.global_position + parent.velocity.normalized() * 50)
		owner.animation.play('move')
	else:
		get_new_path()
	
	


func apply_friction(delta: float) -> void:
	owner.velocity = owner.velocity.move_toward(Vector2.ZERO, owner.friction * delta)
	
	
func look_towards(delta: float, target: Vector2) -> void:
	var target_angle = owner.global_position.angle_to_point(target)
	owner.sprites.rotation = target_angle - PI/2
	
	
func follow_path(delta: float) -> void:
	var heading = owner.position.direction_to(path[path_index])
	owner.velocity += heading * owner.acceleration * delta
	var distance = owner.position.distance_to(path[path_index])
	if distance <= 32:
		path_index += 1


func get_new_path() -> void:
	path = owner.get_parent().request_path(owner.global_position, owner.target.global_position)
	path_index = 0


func stuck_on_path(delta: float) -> void:
	path_elapsed += delta
	
	if path_elapsed >= path_time_max:
		path_elapsed = 0.05
		get_new_path()
		

func shoot_web(delta: float) -> void:
	shoot_elapsed += delta
	
	if shoot_elapsed >= shoot_rate:
		shoot_elapsed = 0.0
		var target_vector = owner.global_position.direction_to(owner.target.global_position)
		owner.shooter.shoot('web', target_vector)

	
func has_LOS() -> bool:
	var collider = parent.line_of_sight.get_collider()
	if collider and collider.name == parent.target.name:
		return true
	return false
	
	
	
