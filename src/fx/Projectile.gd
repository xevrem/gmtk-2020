extends Area2D
class_name Projectile

export var impulse: = 300
export var max_speed: = 500
export var damage: int = 5

var velocity: = Vector2.ZERO


func fire(firing_position: Vector2, direction: Vector2):
	position = firing_position
	velocity = direction.normalized()

