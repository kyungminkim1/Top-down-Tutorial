extends Node2D
class_name Weapon

signal weapon_out_of_ammo

export (PackedScene) var Bullet

var team: int = -1

var max_ammo: int = 5
var current_ammo: int = max_ammo

onready var end_of_gun = $EndOfGun
onready var gun_direction = $GunDirection
onready var shoot_cooldown = $ShootCooldown
onready var animation_player = $AnimationPlayer

func initialize(team: int):
	self.team = team

func shoot():
	if current_ammo != 0 and shoot_cooldown.is_stopped() and Bullet != null:
		var bullet_instance = Bullet.instance()
		var direction = end_of_gun.global_position.\
				direction_to(gun_direction.global_position).normalized()
		GlobalSignals.emit_signal("bullet_fired", bullet_instance, team,
				end_of_gun.global_position, direction)
		shoot_cooldown.start()
		animation_player.play("muzzle_flash")
		current_ammo -= 1
		if current_ammo == 0:
			emit_signal("weapon_out_of_ammo")

func start_reload():
	animation_player.play("reload")

# Adding '_' in front of a method signifies this method shouldn't
# be called outside of the script i.e. a private method
func _stop_reload():
	current_ammo = max_ammo
