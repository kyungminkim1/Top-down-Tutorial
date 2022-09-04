extends KinematicBody2D

onready var health_stat = $Health
onready var ai = $AI
onready var weapon = $Weapon


func _ready():
	ai.initialize(self, weapon)

func rotate_toward(location: Vector2):
	rotation = lerp(rotation, global_position.direction_to(location).angle(), 0.1)

func handle_hit():
	health_stat.health -= 20
	if health_stat.health <= 0:
		queue_free()
	
