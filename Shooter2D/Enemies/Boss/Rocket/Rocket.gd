extends KinematicBody2D

var SPEED = 400
var power = 350

func _ready():
	$AnimatedSprite.visible = false

func _physics_process(delta):
	var collision = move_and_collide(Vector2(SPEED * delta,0).rotated(rotation))
	if collision:
		if $AudioStreamPlayer.playing == false:
			$AudioStreamPlayer.play()
		if collision.collider.name == "Player":
			if collision.collider.has_method("take_damage"):
				collision.collider.take_damage(power)
				set_collision_layer_bit(3, false)
				set_collision_mask_bit(0, false)
			else:
				collision.collider.queue_free()
		$AnimatedSprite.play()
		$AnimatedSprite.visible = true
		SPEED = 0
		$Sprite.visible = false


func _on_AnimatedSprite_animation_finished():
	queue_free()
