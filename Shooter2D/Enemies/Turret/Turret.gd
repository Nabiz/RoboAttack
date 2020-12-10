extends StaticBody2D

onready var ray_cast = $Rifle/RayCast
var player
var health = 2000
var engaged = false
var cooldown = false
export (PackedScene) var TurretBullet
export (PackedScene) var DamageAudioStream
export (PackedScene) var ShotAudioStream

func _ready():
	add_to_group("enemies")

func _process(_delta):
	aim_player()
	var collider = ray_cast.get_collider()
	if collider:
		if collider.name == "Player" and not cooldown:
			cooldown = true
			play_shot_audio_stream()
			$CooldownTimer.start()
			var bullet = TurretBullet.instance()
			bullet.rotation = $Rifle.rotation
			bullet.position = $Rifle/BulletPosition.global_position
			get_tree().root.add_child(bullet)

func aim_player():
	if engaged:
		$Rifle.look_at(player.position)

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

func play_shot_audio_stream():
	var audio_stream = ShotAudioStream.instance()
	add_child(audio_stream)

func _on_EngageArea_body_entered(body):
	if body.name == "Player":
		player = body
		engaged = true

func _on_EngageArea_body_exited(body):
	if body.name == "Player":
		engaged = false

func _on_CooldownTimer_timeout():
	cooldown = false
