extends Area2D

var animation_speed = 16
var moving = false
var grid_size = 16

var dir_string = "right"
@onready var layer = $"../TileMapLayer"

var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT
}
var tween = null

@onready var timer = $Timer
@onready var sprite = $AnimatedSprite2D
@onready var ray = $RayCast2D
	
func _unhandled_input(event):
	if event.is_action_pressed(dir_string):
		move()
		timer.start()

func _on_timer_timeout():
	move()
	# TODO: LATER - RESTART THE TIMER AFTER ALL EVENTS INVOLVED WITH 
	# THE PLATER ARE FINISHED like falling
	timer.start()
	
# TODO - This code is really unclean, clean up later 
# once we have a better idea of how we want the player to move
# We will need to account for the player falling down
func move():
	ray.target_position = inputs[dir_string] * grid_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		pass
	else:
		if dir_string == "left":
			dir_string = "right"
			sprite.flip_h = false
		else: 
			dir_string = "left"
			sprite.flip_h = true
	tween = create_tween()
	tween.tween_property(self, "position", position + inputs[dir_string] *  grid_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	sprite.play("walk", 2)
	await tween.finished
	moving = false
