extends Node2D

onready var player: Player = $Player
onready var bullet_manager = $BulletManager

func _ready():
	GlobalSignals.connect("bullet_fired", bullet_manager, "handle_spawned_bullet")
