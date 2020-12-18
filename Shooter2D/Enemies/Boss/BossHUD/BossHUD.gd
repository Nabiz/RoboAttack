extends CanvasLayer

onready var boss_healthbar = $HBoxContainer/VBoxContainer/MarginContainer/ProgressBar

func _on_Boss_update_boss_HUD(health):
	boss_healthbar.set_value(health)
