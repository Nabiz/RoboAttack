extends CanvasLayer


func _on_PlayButton_pressed():
	get_tree().change_scene("res://Levels/Level01/Level01.tscn")

func _on_Level2Button_pressed():
	get_tree().change_scene("res://Levels/Level02/Level02.tscn")

func _on_Level3Button_pressed():
	get_tree().change_scene("res://Levels/Level03/Level03.tscn")

func _on_Level4Button_pressed():
	get_tree().change_scene("res://Levels/Level04/Level04.tscn")

func _on_Level5Button_pressed():
	get_tree().change_scene("res://Levels/Level05/Level05.tscn")
