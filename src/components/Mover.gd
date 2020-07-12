extends Node
class_name Mover


func _physics_process(delta):
	owner.velocity = owner.move_and_slide(owner.velocity.clamped(owner.max_velocity))
