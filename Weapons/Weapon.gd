extends Node2D
class_name Weapon

export (PackedScene) var Bullet

var team: int = -1

onready var end_of_gun = $EndOfGun
onready var gun_direction = $GunDirection
onready var shoot_cooldown = $ShootCooldown
onready var muzzle_flash_anim = $MuzzleFlashAnim

func initialize(team: int):
	self.team = team

func shoot():
	if shoot_cooldown.is_stopped() and Bullet != null:
		var bullet_instance = Bullet.instance()
		var direction = end_of_gun.global_position.\
				direction_to(gun_direction.global_position).normalized()
		GlobalSignals.emit_signal("bullet_fired", bullet_instance, team,
				end_of_gun.global_position, direction)
		shoot_cooldown.start()
		muzzle_flash_anim.play("muzzle_flash")
