extends KinematicBody2D

export var speed = 2
export var damage = 10
export var max_constraint = 100
export var min_constraint = -100
var direction = 1
var velocity = Vector2.ZERO


func _physics_process(_delta):
	if direction < 0 and !$Sprite.flip_h:
		$Sprite.flip_h = true
	if direction > 0 and $Sprite.flip_h:
		$Sprite.flip_h = false
	if direction > 0 and position.x >= max_constraint:
		velocity.x = 0
		direction = -1
	if direction < 0 and position.x <= min_constraint:
		velocity.x = 0
		direction = 1

	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if velocity.x != 0:
#			if collision.collider.name == "Platform" or collision.collider.name == "Ground":
			velocity.x = 0
			direction *= -1
		if collision.collider.name == "Player":
			collision.collider.do_damage(damage)

	velocity.x += direction * speed
	move_and_slide(velocity, Vector2.UP)
