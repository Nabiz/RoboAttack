extends Node2D

export (PackedScene) var BlasterBullet

var ammo = 0
var max_ammo = 100
export (Texture) var texture
export (PackedScene) var RifleAudioStream

var cooldown = false
onready var cooldown_timer = $CooldownTimer

func detect_shot():
	if not cooldown:
		return Input.is_action_pressed("ui_shot")

func _on_CooldownTimer_timeout():
	cooldown = false

func shot():
	if ammo > 0:
		play_audio_stream()
		cooldown = true
		cooldown_timer.start()
		var bullet = BlasterBullet.instance()
		get_tree().root.add_child(bullet)
		bullet.rotation = get_parent().get_parent().rotation
		bullet.position = global_position
		ammo-=1

func play_audio_stream():
	var audio_stream = RifleAudioStream.instance()
	add_child(audio_stream)

func add_ammo(amount):
	if ammo + amount > max_ammo:
		ammo = max_ammo
	else:
		ammo += amount

func get_ammo_text():
	return String(ammo) + "/" + String(max_ammo)

func get_texture():
	return texture
