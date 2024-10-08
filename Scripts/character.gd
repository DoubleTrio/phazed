extends Area2D

var animation_speed = 16
var direction = 0
var moving = false
var grid_size = 16
var dir_string = "right"
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT # For when a wall is hit to switch directions
}


#var direction = 0
#func _ready():
	#position = position.snapped(Vector2.ONE * tile_size)
	#position += Vector2.ONE * tile_size/2

@onready var timer = $Timer

# TODO Change to not raycast?
func _unhandled_input(event): #Smoother moment
	if event.is_action_pressed(dir_string):
		move(dir_string)
		if timer.is_stopped():
			timer.start()

func _on_timer_timeout():
	move(dir_string)
	timer.start()
	
			
@onready var ray = $RayCast2D
func move(dir):
	ray.target_position = inputs[dir] * grid_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] *    grid_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	else:
		# This will be where direction is changed
		if direction%2 == 0:
			dir_string = "left"
		else:
			dir_string = "right"
		direction = direction + 1
		return
