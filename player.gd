extends CharacterBody2D

var speed = 300.0
var new_direction: Vector2
@onready var animated_sprite = $animated_sprite2d
var animation

func _physics_process(delta):
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()

	var movement = direction * speed * delta
	move_and_collide(movement)
	playerDirection(direction)

func playerDirection(direction: Vector2):
	if direction != Vector2.ZERO:
		new_direction = direction
		animation = "walk_" + returnedDirection(new_direction)
		animated_sprite.play(animation)
	else:
		animation = "idle_" + returnedDirection(new_direction)
		animated_sprite.play(animation)

func returnedDirection(direction: Vector2) -> String:
	var normalized_direction = direction.normalized()
	var default_return = "down"

	if normalized_direction.y > 0:
		return "down"
	elif normalized_direction.y < 0:
		return "up"
	elif normalized_direction.x > 0:
		animated_sprite.flip_h = false
		return "right"
	elif normalized_direction.x < 0:
		animated_sprite.flip_h = true
		return "right"  # left
	return default_return
