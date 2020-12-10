extends KinematicBody2D

var base_speed = 160
var speed
var velocity = Vector2.ZERO
var health = 1000
var power = 10
var player
var engaged = false
var knockback = false

export (PackedScene) var DamageAudioStream

func _ready():
	speed = base_speed
	add_to_group("enemies")

func _physics_process(delta):
	calculate_velocity()
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.collider.name == "Player":
			collision.collider.take_damage(power)

func calculate_velocity():
	if engaged:
		look_at(player.get_global_position())
		var collider = $RayCast.get_collider()
		if collider:
			if collider.name == "Player":
				velocity = Vector2(1, 0).rotated(rotation)
				$AnimatedSprite.play()
				if $WalkAudioStreamPlayer2D.playing == false:
					$WalkAudioStreamPlayer2D.play()
			else:
				velocity = Vector2.ZERO
				$AnimatedSprite.stop()
				$AnimatedSprite.frame = 0
	if knockback:
		velocity *= -speed
	else:
		velocity *= speed

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
