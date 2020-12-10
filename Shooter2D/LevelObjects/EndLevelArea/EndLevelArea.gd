extends Area2D

export var next_level = "res://Levels/Level02/Level02.tscn"

func _on_EndLevelArea_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(next_level)
