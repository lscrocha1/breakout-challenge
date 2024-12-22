extends CharacterBody2D

class_name Player

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	velocity.x = direction * 600
	velocity.y = 0

	move_and_slide()
