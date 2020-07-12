extends Node
class_name Health

export var life: = 20
export var regen_rate: = 0.0
export var regen_amount: = 0

signal no_health

func take_damage(damage: int) -> void:
	print('doing damage')
	life -= damage
	
	if life <= 0:
		print(owner.name + ' is dead')
		emit_signal('no_health')
