extends Node2D

signal state_changed(new_state)

enum State {
	PATROL,
	ENGAGE
}

onready var player_detection_zone = $PlayerDetectionZone

var current_state: int = State.PATROL setget set_state
var actor = null
var player: Player = null
var weapon: Weapon = null

func _process(delta):
	match current_state:
		State.PATROL:
			pass
		State.ENGAGE:
			if player != null and weapon != null:
				var angle_to_player = actor.global_position.direction_to(player.global_position).angle()
				actor.rotation = lerp(actor.rotation, angle_to_player, 0.1)
				if abs(actor.rotation - angle_to_player) < 0.1:
					weapon.shoot()
			else:
				print("Error: Enemy in engage state but no player/weapon found")
		_:
			print("Error: Enemy has entered state that doesn't exist")

# This programming technique is known as 'dependency injection'
# It allows a node to communicate with its 'sibling' (in this case Weapon)
# Note how signals are not utilised, instead references are passed

func initialize(actor, weapon: Weapon):
	self.actor = actor
	self.weapon = weapon

func set_state(new_state: int):
	if new_state == current_state:
		return
	
	current_state = new_state
	emit_signal("state_changed", current_state)


func _on_PlayerDetectionZone_body_entered(body):
	if body.is_in_group("player"):
		set_state(State.ENGAGE)
		player = body
		print("enemy found player!")


func _on_PlayerDetectionZone_body_exited(body):
	if player and body == player:
		set_state(State.PATROL)
		player = null
