extends KinematicBody2D
class_name Player

export var speed = 100

onready var health_stat = $Health
onready var weapon = $Weapon

func _physics_process(delta):
	# This is a form of static typing
	# Source: 
	# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html#inferred-types
	var direction := Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
		
	if Input.is_action_pressed("move_down"):
		direction.y += 1
		
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Applies force to kinematicbody
	move_and_slide(direction * speed)
	
	look_at(get_global_mouse_position())


func _unhandled_input(event):
	if event.is_action_released("shoot"):
#		print("player has shot")
		weapon.shoot()
		

func handle_hit():
	health_stat.health -= 10
	print("player hit!", health_stat.health)
