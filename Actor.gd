extends KinematicBody2D
class_name Actor

export var friction: int = 400
export var max_velocity = 200
export var acceleration: = 500
export var actor_type: String = 'none'

var velocity: = Vector2.ZERO
var rotation_value: float = 0.0

signal died(actor)

