extends Node2D

func handle_spawned_bullet(bullet: Bullet, team: int, position: Vector2, direction: Vector2):
	add_child(bullet)
	bullet.team = team
	bullet.global_position = position
	bullet.set_direction(direction) 
