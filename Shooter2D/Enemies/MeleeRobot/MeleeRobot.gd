extends KinematicBody2D

var base_speed = 180
var speed
var velocity = Vector2.ZERO
var health = 1000
var power = 1
var player
var engaged = false
var knockback = false

func _ready():
	speed = base_speed
	add_to_group("enemies")
	player = get_parent().get_node("Player")

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
			else:
				velocity = Vector2.ZERO
	if knockback:
		velocity *= -speed
	else:
		velocity *= speed

func take_damage(dmg):
	health -= dmg
	if health <= 0:
		queue_free()
	else:
		$AnimatedSprite.modulate = Color(1, 0, 0)
		yield(get_tree().create_timer(0.1), "timeout")
		$AnimatedSprite.modulate = Color(1, 1, 1)
	

func start_knockback(knockback_speed):
	knockback = true
	speed = knockback_speed

func stop_knockback():
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
