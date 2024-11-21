extends Node2D

@onready var health_bar_value = $%ProgressBarHP
@onready var stamina_bar_value = $%ProgressBarStam
@onready var player = $Player



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_health_upd(health, max_health):
	health_bar_value.value = 100 * health / max_health
	
func _on_player_stamina_upd(stamina, max_stamina):
	print("stam change :", player.stamina)
	stamina_bar_value.value = 100 * stamina / max_stamina
