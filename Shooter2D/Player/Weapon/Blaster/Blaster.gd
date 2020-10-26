extends Node2D

export (PackedScene) var BlasterBullet

var ammo = 10
var max_ammo = 100
export (Texture) var texture

func detect_shot():
	return Input.is_action_just_pressed("ui_shot")

func shot():
	if ammo > 0:
		var bullet = BlasterBullet.instance()
		get_tree().root.add_child(bullet)
		bullet.rotation = get_parent().get_parent().rotation
		bullet.position = global_position
		ammo-=1

func get_ammo_text():
	return String(ammo) + "/" + String(max_ammo)

func get_texture():
	return texture
