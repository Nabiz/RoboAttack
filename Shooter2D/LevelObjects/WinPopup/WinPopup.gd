extends CanvasLayer


func _ready():
	$ConfirmationDialog.popup()

func _on_ConfirmationDialog_confirmed():
	get_tree().change_scene("res://Menu/Menu.tscn")
