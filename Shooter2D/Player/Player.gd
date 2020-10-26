extends KinematicBody2D

class_name Player

var speed = 200
var velocity = Vector2.ZERO
var health = 50

func _ready():
	emit_signal("damage_taken", health)
	$Weapon.update_HUD()

func _physics_process(delta):
	get_movement_input()
	velocity = move_and_slide(velocity)

func get_movement_input():
	look_at(get_global_mouse_position())
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		velocity += Vector2(0, 1)
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2(0, -1)
	if Input.is_action_pressed("ui_left"):
		velocity += Vector2(-1, 0)
	if Input.is_action_pressed("ui_right"):
		velocity += Vector2(1, 0)
	velocity = speed * velocity.normalized()

signal damage_taken(health)

func take_damage(dmg):
	health -= dmg
	emit_signal("damage_taken", health)
