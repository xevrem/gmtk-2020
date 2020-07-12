extends Projectile
class_name Web

var ttl: = 1
var elapsed: = 0.0
var rotation_rate: = 2*PI
var rand_sign: = 1

func _ready() -> void:
	rand_sign = randi() % 3 - 1
	if rand_sign == 0:
		rand_sign = 1

func _physics_process(delta: float) -> void:
	elapsed += delta
	
	if elapsed >= ttl:
		queue_free()
		
	$Sprite.rotation += rand_sign * rotation_rate * delta
	position += velocity * max_speed * delta

func _on_body_entered(body: KinematicBody2D):
#	print('web hit a thing')
	queue_free()
