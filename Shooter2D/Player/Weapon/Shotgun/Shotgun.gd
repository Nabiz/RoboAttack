extends Node2D

export (PackedScene) var ShotgunBullet

var ammo = 20
var max_ammo = 20
export (Texture) var texture

var cooldown = false
onready var cooldown_timer = $CooldownTimer

func detect_shot():
	if not cooldown:
		return Input.is_action_just_pressed("ui_shot")

func _on_CooldownTimer_timeout():
	cooldown = false

func shot():
	if ammo > 0:
		cooldown = true
		cooldown_timer.start()
		var bullet = ShotgunBullet.instance()
		get_tree().root.add_child(bullet)
		bullet.rotation = get_parent().get_parent().rotation
		bullet.position = global_position
		ammo-=1

func add_ammo(amount):
	if ammo + amount > max_ammo:
		ammo = max_ammo
	else:
		ammo += amount

func get_ammo_text():
	return String(ammo) + "/" + String(max_ammo)

func get_texture():
	return texture
