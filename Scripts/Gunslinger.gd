extends CharacterBody2D


@export var speed = 120.0
var direction: Vector2 = Vector2.ZERO
var new_direction = Vector2(0, 1)

var rng = RandomNumberGenerator.new()

var timer = 0

@onready var player = $"../Player"
var animation
@onready var animated_sprite = $AnimatedSprite2D
var is_attacking = false

# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready() -> void:
	rng.randomize()


func _physics_process(delta):
	
	var movement = speed * direction * delta
	var collision = move_and_collide(movement)
	
	if collision != null and collision.get_collider().name != "player":
		direction = direction.rotated(rng.randf_range(PI/4, PI/2))
		timer = rng.randf_range(2, 5)
	else:
		timer = 0
		
	if !is_attacking:
		pass
		enemyDirection(direction)





func _on_timer_timeout():
	var player_distance = player.position - position
	
	if player_distance.length() <= 20:
		new_direction = player_distance.normalized()
	elif player_distance.length() <= 100 and timer == 0:
		direction = player_distance.normalized()
	elif timer == 0:
		var random_direction = rng.randf()
		if random_direction < 0.05:
			direction = Vector2.ZERO
		elif random_direction < 0.1:
			direction = Vector2.DOWN.rotated(rng.randf() * 2 * PI)
			
			
	
	
func enemyDirection(direction: Vector2):

	if direction != Vector2.ZERO:
		new_direction = direction
		animation = "walk_" + GSreturnedDirection(new_direction)
		animated_sprite.play(animation)
	else:
		animation = "idle_" + GSreturnedDirection(direction)
		animated_sprite.play(animation)
		



func GSreturnedDirection(direction: Vector2):
	var normalized_direction = direction.normalized()
	var default_return = "down"
	
	if abs(normalized_direction.x) > abs(normalized_direction.y):
		if normalized_direction.x > 0:
			animated_sprite.flip_h = false
			return "side"
		else: 
			animated_sprite.flip_h = true
			return "side"
	if normalized_direction.y > 0:
		return "down"
	elif normalized_direction.y < 0:
		return "up"
			
			
	return default_return
