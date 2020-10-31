extends CanvasLayer

onready var health_bar = $ProgressBar
onready var ammo_label = $WeaponConteiner/AmmoLabel
onready var weapon_texture = $WeaponConteiner/WeaponTexture

func _on_Player_damage_taken(health):
	health_bar.set_value(health)

func _on_Weapon_update_ammo_HUD(ammo_text):
	ammo_label.set_text(ammo_text)


func _on_Weapon_update_weapon_texture_HUD(texture):
	weapon_texture.set_texture(texture)