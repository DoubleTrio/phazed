extends Entity

class_name Character

@export var tint_color: Color = Color.WHITE
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var raycast = $RayCast2D
@onready var direction_component = $DirectionComponent

func _ready():
	super._ready()
	direction_component.direction_changed.connect(_direction_changed)
	LevelEvents.on_gravity_changed.connect(_gravity_changed)
	LevelScene.instance.level_complete.connect(_level_complete)
	#enter_detect_area.connect(_enter_detection_area)
	#sprite.modulate = tint_color
	
func _gravity_changed(direction: Vector2):
	#print("TODO: Change sprite orientation")
	pass
	
func _level_complete():
	sprite.play("idle", 1)

func _direction_changed(direction: Vector2):
	match direction:
		Vector2.LEFT:
			sprite.flip_h = true
		Vector2.RIGHT: 
			sprite.flip_h = false
	
