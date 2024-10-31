extends CharacterBody2D

@export var speed = 100
@onready var animated_sprite = $AnimatedSprite2D
var new_direction: Vector2 = Vector2.ZERO
var animation: String
var is_attacking = false
var is_running = false
var base_speed = 100
var base_animation_speed = 1.0  # Default animation speed
var run_animation_speed = 2.0   # Animation speed while running

func _physics_process(delta):
	var direction: Vector2 = Vector2.ZERO
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	
	if abs(direction.x) == 1 and abs(direction.y) == 1:
		direction = direction.normalized()
	
	var movement = direction * speed * delta
	if not is_attacking:
		move_and_collide(movement)
		playerDirection(direction)

func playerDirection(direction: Vector2):
	if direction != Vector2.ZERO:
		new_direction = direction
		animation = "walk_" + returnedDirection(new_direction)
		animated_sprite.play(animation)
	else:
		animation = "idle_" + returnedDirection(direction)
		animated_sprite.play(animation)

func returnedDirection(direction: Vector2):
	var normalized_direction = direction.normalized()
	var default_return = "down"
	
	if normalized_direction.y > 0:
		return "down"
	elif normalized_direction.y < 0:
		return "up"
	elif normalized_direction.x > 0:
		animated_sprite.flip_h = false
		return "side"
	elif normalized_direction.x < 0:
		animated_sprite.flip_h = true
		return "side"
	
	return default_return

func _input(event):
	if event.is_action_pressed("shoot"):
		is_attacking = true
		animation = "attack_" + returnedDirection(new_direction)
		animated_sprite.play(animation)
	elif event.is_action_pressed("sprint"):
		run()
	elif event.is_action_released("sprint"):
		stop_running()

func _on_animated_sprite_2d_animation_finished():
	is_attacking = false

func run():
	if not is_running:
		is_running = true
		speed = base_speed * 2
		animated_sprite.speed_scale = run_animation_speed

func stop_running():
	if is_running:
		is_running = false
		speed = base_speed
		animated_sprite.speed_scale = base_animation_speed


