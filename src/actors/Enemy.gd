extends Actor
class_name Enemy

onready var sprites: Node2D = $Sprites
onready var animation: AnimationPlayer = $AnimationPlayer
onready var shooter: Shooter = $Shooter
onready var health: Health = $Health
onready var line_of_sight: RayCast2D = $Sprites/RayCast2D

var target: Actor

func _ready() -> void:
	health.connect("no_health", self, "on_no_health")


func set_target(actor: Actor) -> void:
	target = actor


func _on_ProjectileDetector_area_entered(area: Projectile) -> void:
	health.take_damage(area.damage)


func on_no_health() -> void:
	emit_signal("died", self)
	queue_free()
