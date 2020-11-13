extends KinematicBody2D

class_name Player

var speed = 200
var velocity = Vector2.ZERO
var health = 50

export (Texture) var blaster_texture
export (Texture) var shotgun_texture
export (Texture) var rifle_texture

func _ready():
	emit_signal("damage_taken", health)
	$Weapon.update_HUD()
	change_corps_texture("blaster")

func _physics_process(delta):
	get_movement_input()
	velocity = move_and_slide(velocity)
	if velocity.length() > 0:
		calculate_leg_animation()
		$LegAnimatedSprite.play()
	else:
		$LegAnimatedSprite.set_animation("walk")
		$LegAnimatedSprite.frame = 0
		$LegAnimatedSprite.stop()

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

func calculate_leg_animation():
	var angle = fmod(rotation - velocity.angle() + 2*PI, 2 * PI)
	if angle < PI/8 or 15*PI/8 <= angle:
		$LegAnimatedSprite.flip_h = false
		$LegAnimatedSprite.play("walk")
	elif PI/8 <= angle and angle < 3*PI/8:
		$LegAnimatedSprite.flip_h = true
		$LegAnimatedSprite.play("diagonal_walk")
	elif 3*PI/8 <= angle and angle < 5*PI/8:
		$LegAnimatedSprite.flip_h = true
		$LegAnimatedSprite.play("side_walk")
	elif 5*PI/8 <= angle and angle < 7*PI/8:
		$LegAnimatedSprite.flip_h = false
		$LegAnimatedSprite.play("diagonal_walk_backward")
	elif 7*PI/8 <= angle and angle < 9*PI/8:
		$LegAnimatedSprite.flip_h = false
		$LegAnimatedSprite.play("walk_backward")
	elif 9*PI/8 <= angle and angle < 11*PI/8:
		$LegAnimatedSprite.flip_h = true
		$LegAnimatedSprite.play("diagonal_walk_backward")
	elif 11*PI/8 <= angle and angle < 13*PI/8:
		$LegAnimatedSprite.flip_h = false
		$LegAnimatedSprite.play("side_walk")
	else:
		$LegAnimatedSprite.flip_h = false
		$LegAnimatedSprite.play("diagonal_walk")

func change_corps_texture(wepon_type):
	if wepon_type == "blaster":
		$CorpsSprite.texture = blaster_texture
		$Weapon.position.x = 75
		$Weapon.position.y = 0
	elif wepon_type == "shotgun":
		$CorpsSprite.texture = shotgun_texture
		$Weapon.position.x = 50
		$Weapon.position.y = 0
	elif wepon_type == "rifle":
		$CorpsSprite.texture = rifle_texture
		$Weapon.position.x = 75
		$Weapon.position.y = 10

signal damage_taken(health)

func take_damage(dmg):
	health -= dmg
	emit_signal("damage_taken", health)
