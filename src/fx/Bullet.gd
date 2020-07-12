extends Projectile
class_name Bullet

onready var sprite: Sprite = $Sprite

var ttl: = 1
var elapsed: = 0.0


func _ready()->void:
	sprite.rotation = velocity.angle()+PI/2


func _physics_process(delta: float)->void:
	elapsed += delta
	
	if elapsed >= ttl:
#		print('killing bullet')
		queue_free()
	
	position += velocity * max_speed * delta
	sprite.rotation = velocity.angle()+PI/2


func _on_body_entered(body: KinematicBody2D):
#	print('bullet hit a thing')
	queue_free()
