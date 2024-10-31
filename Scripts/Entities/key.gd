extends Entity

@onready var sprite: Sprite2D = $Sprite2D as Sprite2D
@onready var id_component: IDComponent = $IDComponent as IDComponent


@onready var detect_area_component: DetectAreaComponent = $DetectAreaComponent as DetectAreaComponent

@export var tint_color: Color = Color.WHITE
	
@export var id: int
#@export var north_texture: Texture2D 

func _ready():
	id_component.set_id(id)
	sprite.modulate = tint_color
	LevelEvents.on_gravity_changed.connect(_gravity_change)
	super._ready()

	

func _gravity_change(direction: Vector2):
	pass
	# TODO
	#print("flip key?")
	#var next_texture: Texture2D
#
	#match direction:
		#Vector2.UP:
			#next_texture = north_texture
		#Vector2.RIGHT:
			#next_texture = east_texture
		#Vector2.DOWN:
			#next_texture = south_texture
		#Vector2.LEFT:
			#next_texture = west_texture
	#sprite.texture = next_texture
