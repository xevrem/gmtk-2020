extends Node
class_name Shooter

onready var bullet_scene = preload("res://src/fx/Bullet.tscn")
onready var web_scene = preload("res://src/fx/Web.tscn")

func shoot(type: String, firing_vector: Vector2) -> int:
	var projectile = get_type(type)
	# fire 20 units away from us along the firing vector
	projectile.fire(owner.global_position + 5 * firing_vector, firing_vector)
	# add bullet to world
	owner.get_parent().add_child(projectile)
	
	return projectile.impulse


func get_type(type: String) -> Resource:
	if type == 'web':
		return web_scene.instance()
	elif type == 'bullet':
		return bullet_scene.instance()
	else:
		return bullet_scene.instance()
