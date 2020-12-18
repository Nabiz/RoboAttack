extends Node2D

onready var enemies = $Enemies
var end = false

func _process(delta):
	if end == false and enemies.get_child_count() == 0:
		end = true
		yield(get_tree().create_timer(3), "timeout")
		$Player/WinCanvasLayer/WinAcceptDialog.popup()
		$Player.set_process(false)


func _on_Button_pressed():
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_WinAcceptDialog_modal_closed():
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_WinAcceptDialog_mouse_entered():
	$Player.weapon.set_process(false)


func _on_WinAcceptDialog_mouse_exited():
	$Player.weapon.set_process(true)
