extends Area2D


#variables#

@onready var tilemap = get_tree().root.get_node("main/TileMap")
var direction : Vector2
var speed = 80
var damage = 30

@onready var animated_sprite = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position + speed * delta * direction





func _on_body_entered(body):
	print()
	if body.name == "player":
		return
	if body.name == "TileMap":
		if tilemap.get_layer_name("+1"):
			return
		if tilemap.get_layer_name("-1"):
			return
	if body.is_in_group("enemies"):
		pass
		
		
	direction = Vector2.ZERO
	animated_sprite.play("Flash")





func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "Flash":
		get_tree().queue_delete(self)
		




func _on_timer_timeout():
	animated_sprite.play("Flash")
