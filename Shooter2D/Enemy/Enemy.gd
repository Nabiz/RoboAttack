extends KinematicBody2D

var speed = 100
var velocity = Vector2.ZERO
var power = 1
var player

func _ready():
	add_to_group("enemies")
	player = get_parent().get_node("Player")

func _physics_process(delta):
	if player:
		look_at(player.get_global_position())
		velocity = Vector2(speed, 0).rotated(rotation)
		var collision = move_and_collide(velocity*delta)
		if collision:
			if collision.collider.name == "Player":
				collision.collider.take_damage(power)
				#dead_cam()

func dead_cam():
	var camera = Camera2D.new()
	self.add_child(camera)
	camera.current = true
