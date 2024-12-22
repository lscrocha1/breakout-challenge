extends CharacterBody2D

class_name Ball

var ball_speed = 300

signal player_scored

func _ready() -> void:
	velocity.y = ball_speed
	
func flip_ball() -> void:
	velocity.y = -ball_speed

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	
	if !collision_info:
		return
	
	var collider = collision_info.get_collider()
	
	if collider.is_in_group("boundary"):
		velocity.x *= -1;
	else:		
		if velocity.y > 0:
			velocity.y = -ball_speed
		else:
			velocity.y = ball_speed
			
	if collider.is_in_group("shape"):
		collider.queue_free()
		emit_signal("player_scored")
		ball_speed += 40
		return
	
	if !collider is Player:
		return
		
	var shape = collision_info.get_collider_shape()
	
	if shape.is_in_group("left"):
		velocity.x = -300
	else:
		velocity.x = 300
