extends Node2D

onready var player_scene: = preload("res://src/actors/Player.tscn")
onready var enemy_scene: = preload("res://src/actors/Enemy.tscn")


var max_enemies: = 5
var enemies: = []
var player: Player


func _ready() -> void:
	randomize()
	
	spawn_player()

	for i in range(max_enemies):
		spawn_enemy()


func request_path(location: Vector2, destination: Vector2) -> PoolVector2Array:
	var path = $Navigation2D.get_simple_path(location, destination, true)
	return path


func spawn_player() -> void:
	player = player_scene.instance()
	player.set_position(get_spawn_point('player'))
	player.connect("died", self, 'on_player_died')
	add_child(player)


func spawn_enemy() -> void:
	var enemy: Enemy = enemy_scene.instance()
	enemy.set_target(player)
	enemy.set_position(get_spawn_point('enemy'))
	enemy.connect("died", self, 'on_enemy_died')
	enemies.append(enemy)
	add_child(enemy)


func get_spawn_point(type: String) -> Vector2:
	var index: = 0
	if type == 'player':
		index = randi() % $PlayerSpawnPoints.get_children().size()
		return $PlayerSpawnPoints.get_children()[index].global_position
	else:
		index = randi() % $EnemySpawnPoints.get_children().size()
		return $EnemySpawnPoints.get_children()[index].global_position


func exclaim_player():
	for enemy in enemies:
		enemy.set_target(player)


func on_player_died(actor: Player) -> void:
	spawn_player()
	exclaim_player()
	

func on_enemy_died(actor: Enemy) -> void:
	var index = enemies.find(actor)
	enemies.remove(index)
	spawn_enemy()
	
