extends CanvasLayer

var health_bar

func _ready():
	health_bar = $ProgressBar

func _on_Player_damage_taken(health):
	health_bar.set_value(health)
