extends CanvasLayer

onready var health_bar = $ProgressBar
onready var ammo_label = $WeaponConteiner/AmmoLabel
onready var weapon_texture = $WeaponConteiner/WeaponTexture
onready var granade_label = $WeaponConteiner/GranadeContainer/GranadeLabel

export (Texture) var speakers
export (Texture) var muted_speakers

func _ready():
	if AudioServer.is_bus_mute(0):
		$MuteButton.set_normal_texture(muted_speakers)
	else:
		$MuteButton.set_normal_texture(speakers)

func _on_Player_damage_taken(health):
	health_bar.set_value(health)

func _on_Weapon_update_ammo_HUD(ammo_text):
	ammo_label.set_text(ammo_text)


func _on_Weapon_update_weapon_texture_HUD(texture):
	weapon_texture.set_texture(texture)

func _on_Weapon_update_granade_HUD(granade_count):
	granade_label.set_text(String(granade_count))

func _on_MuteButton_pressed():
	if AudioServer.is_bus_mute(0):
		AudioServer.set_bus_mute(0, false)
		$MuteButton.set_normal_texture(speakers)
	else:
		AudioServer.set_bus_mute(0, true)
		$MuteButton.set_normal_texture(muted_speakers)


func _on_MuteButton_mouse_entered():
	get_parent().weapon.set_process(false)


func _on_MuteButton_mouse_exited():
	get_parent().weapon.set_process(true)
