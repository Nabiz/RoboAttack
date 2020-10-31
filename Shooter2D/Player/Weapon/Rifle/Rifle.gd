extends Node2D

export (PackedScene) var BlasterBullet

var ammo = 100
var max_ammo = 100
export (Texture) var texture

var cooldown = false
onready var cooldown_timer = $CooldownTimer

func detect_shot():
	if not cooldown:
		return Input.is_action_pressed("ui_shot")

func _on_CooldownTimer_timeout():
	cooldown = false

func shot():
	if ammo > 0:
		cooldown = true
		cooldown_timer.start()
		var bullet = BlasterBullet.instance()
		get_tree().root.add_child(bullet)
		bullet.rotation = get_parent().get_parent().rotation
		bullet.position = global_position
		ammo-=1

func get_ammo_text():
	return String(ammo) + "/" + String(max_ammo)

func get_texture():
	return texture
