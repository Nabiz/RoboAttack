extends Node2D


export (PackedScene) var Bullet
export var ammo = 100

func _process(delta):
	if Input.is_action_just_pressed("ui_shot") and ammo > 0:
		var bullet = Bullet.instance()
		get_tree().root.add_child(bullet)
		bullet.rotation = get_parent().rotation
		bullet.position = global_position
		ammo-=1
