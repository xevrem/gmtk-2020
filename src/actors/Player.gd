extends Actor
class_name Player

onready var camera: Camera2D = $Camera2D
onready var sprites: Node2D = $Sprites
onready var shooter: Shooter = $Shooter
onready var health: Health = $Health

func _on_Health_no_health():
	print('player died')
	emit_signal("died", self)
	queue_free()


func _on_ProjectileDetector_area_entered(area: Projectile):
	health.take_damage(area.damage)
