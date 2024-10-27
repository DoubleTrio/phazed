extends Entity

@export var tint_color: Color = Color.WHITE
@export var sprite: AnimatedSprite2D
@onready var raycast = $RayCast2D
@onready var direction_component = $DirectionComponent

func _ready():
	super._ready()
	direction_component.direction_changed.connect(_direction_changed)
	sprite.modulate = tint_color
	
func _direction_changed(direction: Vector2):
	match direction:
		Vector2.LEFT:
			sprite.flip_h = true
		Vector2.RIGHT: 
			sprite.flip_h = false
		# TODO ADD DIRECTIONS
			
#func _physics_process(delta):
	#raycast.target_position = Helpers.map_str_to_vec(direction_component.direction) * 16
	#
	#switch 
	#if direction == "left":
		#sprite.flip_h = true
		#sprite.flip_v = false
	#else if direction == "right":
		#sprite.flip_h = false
		#sprite.flip_v = false
	#else if direction == ""
	
