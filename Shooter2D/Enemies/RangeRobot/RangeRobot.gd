extends KinematicBody2D


var base_speed = 150
var speed
var velocity = Vector2.ZERO
var health = 800
var player
var engaged = false
var knockback = false
var cooldown = false

export (PackedScene) var RangeRobotBullet
export (PackedScene) var DamageAudioStream
export (PackedScene) var ShotAudioStream

func _ready():
	speed = base_speed
	add_to_group("enemies")

func _physics_process(delta):
	calculate_velocity()
	move_and_collide(velocity*delta)

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
	bullet.rotation = rotation
	bullet.position = $WeaponPosition.global_position
	get_tree().root.add_child(bullet)

func take_damage(dmg):
	health -= dmg
	play_damage_audio_stream()
	if health <= 0:
		queue_free()
	else:
		modulate = Color(1, 0, 0)
		yield(get_tree().create_timer(0.1), "timeout")
		modulate = Color(1, 1, 1)

func play_damage_audio_stream():
	var damage_audio_stream = DamageAudioStream.instance()
	add_child(damage_audio_stream)

func start_knockback(knockback_speed):
	knockback = true
	set_collision_mask_bit(1, false)
	speed = knockback_speed

func stop_knockback():
	set_collision_mask_bit(1, true)
	yield(get_tree().create_timer(0.2), "timeout")
	knockback = false
	speed = base_speed

func _on_EngageArea_body_entered(body):
	if body.name == "Player":
		player = body
		engaged = true

func _on_EngageArea_body_exited(body):
	if body.name == "Player":
		engaged = false
		velocity = Vector2.ZERO
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0

func _on_CooldownTimer_timeout():
	cooldown = false
