extends Node2D

onready var enemies = $Enemies
var end = false

func _process(delta):
	if end == false and enemies.get_child_count() == 0:
		end = true
		$Player/WinCanvasLayer/WinAcceptDialog.popup()


func _on_WinAcceptDialog_confirmed():
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_WinAcceptDialog_mouse_entered():
	$Player.set_process(false)


func _on_WinAcceptDialog_mouse_exited():
	$Player.set_process(true)


func _on_WinAcceptDialog_modal_closed():
	get_tree().change_scene("res://Menu/Menu.tscn")
