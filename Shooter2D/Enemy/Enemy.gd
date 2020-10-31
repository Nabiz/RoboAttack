extends KinematicBody2D

var SPEED = 100
var speed
var velocity = Vector2.ZERO
var power = 1
var player
var knockback = false

func _ready():
	speed = SPEED
	add_to_group("enemies")
	player = get_parent().get_node("Player")

func _physics_process(delta):
	calculate_velocity()
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.collider.name == "Player":
			collision.collider.take_damage(power)
			#dead_cam()

func calculate_velocity():
	if player:
		look_at(player.get_global_position())
		velocity = Vector2(1, 0).rotated(rotation)
	if knockback:
		velocity *= -speed
	else:
		velocity *= speed

func start_knockback(knockback_speed):
	knockback = true
	speed = knockback_speed

func stop_knockback():
	knockback = false
	speed = SPEED

func dead_cam():
	var camera = Camera2D.new()
	self.add_child(camera)
	camera.current = true
