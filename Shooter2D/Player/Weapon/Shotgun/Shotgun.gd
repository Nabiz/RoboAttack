extends Node2D

export (PackedScene) var ShotgunBullet

var ammo = 5
var max_ammo = 30
export (Texture) var texture

func detect_shot():
	return Input.is_action_just_pressed("ui_shot")

func shot():
	if ammo > 0:
		var bullet = ShotgunBullet.instance()
		get_tree().root.add_child(bullet)
		bullet.rotation = get_parent().get_parent().rotation
		bullet.position = global_position
		ammo-=1

func get_ammo_text():
	return String(ammo) + "/" + String(max_ammo)

func get_texture():
	return texture
