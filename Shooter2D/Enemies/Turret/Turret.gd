extends StaticBody2D

onready var ray_cast = $Rifle/RayCast
var player
var engaged = false
var cooldown = false
export (PackedScene) var TurretBullet

func _process(delta):
	aim_player()
	var collider = ray_cast.get_collider()
	if collider:
		if collider.name == "Player" and not cooldown:
			cooldown = true
			$CooldownTimer.start()
			var bullet = TurretBullet.instance()
			bullet.rotation = $Rifle.rotation
			bullet.position = $Rifle/BulletPosition.global_position
			get_tree().root.add_child(bullet)

func aim_player():
	if engaged:
		$Rifle.look_at(player.position)

func _on_EngageArea_body_entered(body):
	if body.name == "Player":
		player = body
		engaged = true

func _on_EngageArea_body_exited(body):
	if body.name == "Player":
		engaged = false

func _on_CooldownTimer_timeout():
	cooldown = false
