extends Area2D
class_name Bullet

export (int) var speed = 10

var direction := Vector2.ZERO

func _physics_process(delta):
	if direction != Vector2.ZERO:
		var velocity = direction * speed
		global_position += velocity
	
func set_direction(direction: Vector2):
	self.direction = direction
	rotation += direction.angle()


func _on_KillTimer_timeout():
	queue_free()


func _on_Bullet_body_entered(body):
	# Known has 'duck typing', instead of checking the body's type/class,
	# check for the body's properties/methods
	if body.has_method("handle_hit"):
		body.handle_hit()
		queue_free()
