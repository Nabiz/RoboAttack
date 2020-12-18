extends "res://Enemies/RangeRobot/RangeRobot.gd"

export (PackedScene) var Explosion
export (PackedScene) var BossHUD
export (PackedScene) var Rocket

var is_bossHUD = false
var bossHUD = null
var rocket_cooldown = false

func _ready():
	health = 10000

func calculate_velocity():
	if engaged:
		look_at(player.get_global_position())
		var collider = $RayCast.get_collider()
		if collider:
			if collider.name == "Player":
				if not cooldown:
					shot()
					$CooldownTimer.start()
					cooldown = true
				if not rocket_cooldown:
					rocket_shot()
					$RocketCooldownTimer.start()
					rocket_cooldown = true
				if player.position.distance_to(position) <= 600:
					velocity = Vector2.ZERO
					$AnimatedSprite.stop()
					$AnimatedSprite.frame = 0
				else:
					velocity = Vector2(speed, 0).rotated(rotation)
					$AnimatedSprite.play()
					if $WalkAudioStreamPlayer2D.playing == false:
						$WalkAudioStreamPlayer2D.play()
			else:
				velocity = Vector2.ZERO
				$AnimatedSprite.stop()
				$AnimatedSprite.frame = 0
	if knockback:
		velocity = -Vector2(speed, 0).rotated(rotation)

func shot():
	var audio_stream = ShotAudioStream.instance()
	add_child(audio_stream)
	var bullet = RangeRobotBullet.instance()
	bullet.modulate = Color(1, 0, 0)
	bullet.rotation = rotation
	bullet.position = $WeaponPosition.global_position
	get_tree().root.add_child(bullet)
	bullet = RangeRobotBullet.instance()
	bullet.modulate = Color(1, 0, 0)
	bullet.rotation = rotation + PI/8
	bullet.position = $WeaponPosition.global_position
	get_tree().root.add_child(bullet)
	bullet = RangeRobotBullet.instance()
	bullet.modulate = Color(1, 0, 0)
	bullet.rotation = rotation - PI/8
	bullet.position = $WeaponPosition.global_position
	get_tree().root.add_child(bullet)

func rocket_shot():
	$RocketAudioStreamPlayer2D.play()
	var bullet = Rocket.instance()
	bullet.rotation = rotation
	bullet.position = $RocketPosition.global_position
	get_tree().root.add_child(bullet)	

signal update_boss_HUD(health)

func take_damage(dmg):
	if is_bossHUD == false and player != null:
		is_bossHUD = true
		bossHUD = BossHUD.instance()
		connect("update_boss_HUD", bossHUD, "_on_Boss_update_boss_HUD")
		player.add_child(bossHUD)
	emit_signal("update_boss_HUD", health)
	health -= dmg
	play_damage_audio_stream()
	if health <= 0:
		var explosion = Explosion.instance()
		explosion.position = global_position
		get_tree().root.add_child(explosion)
		bossHUD.free()
		queue_free()
	else:
		modulate = Color(1, 0, 0)
		yield(get_tree().create_timer(0.1), "timeout")
		modulate = Color(1, 1, 1)


func _on_RocketCooldownTimer_timeout():
	rocket_cooldown = false
