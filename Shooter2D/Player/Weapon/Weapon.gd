extends Node2D


export (PackedScene) var Blaster
export (PackedScene) var Shotgun
export (PackedScene) var Rifle
export (PackedScene) var Granade

var blaster
var shotgun
var rifle
var granade_count = 3

var current_weapon

func _ready():
	blaster = Blaster.instance()
	shotgun = Shotgun.instance()
	rifle = Rifle.instance()
	add_child(blaster)
	add_child(shotgun)
	add_child(rifle)
	current_weapon = blaster

func _process(_delta):
	change_weapon()
	if current_weapon.detect_shot():
		current_weapon.shot()
		update_ammo_HUD()
	process_granade()

func change_weapon():
	if Input.is_action_just_released("ui_blaster"):
		current_weapon = blaster
		get_parent().change_corps_texture("blaster")
		update_HUD()
	if Input.is_action_just_released("ui_shotgun"):
		current_weapon = shotgun
		get_parent().change_corps_texture("shotgun")
		update_HUD()
	if Input.is_action_just_released("ui_rifle"):
		current_weapon = rifle
		get_parent().change_corps_texture("rifle")
		update_HUD()

func process_granade():
	if Input.is_action_just_released("ui_granade") and granade_count > 0:
		granade_count -= 1
		update_granade_HUD()
		var granade = Granade.instance()
		granade.position = global_position
		granade.rotation = get_parent().rotation
		get_tree().root.add_child(granade)
		granade.throw(get_global_mouse_position())

func update_HUD():
	update_ammo_HUD()
	update_weapon_texture_HUD()

signal update_granade_HUD(granade_count)

func update_granade_HUD():
	emit_signal("update_granade_HUD", granade_count)

signal update_ammo_HUD(ammo_text)

func update_ammo_HUD():
	emit_signal("update_ammo_HUD", current_weapon.get_ammo_text())

signal update_weapon_texture_HUD(texture)

func update_weapon_texture_HUD():
	emit_signal("update_weapon_texture_HUD", current_weapon.get_texture())
