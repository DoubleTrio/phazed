extends Entity

@onready var sprite: Sprite2D = $Sprite2D as Sprite2D
@onready var detect_area_component: DetectAreaComponent = $DetectAreaComponent as DetectAreaComponent

@export var north_texture: Texture2D 
@export var east_texture: Texture2D 
@export var south_texture: Texture2D 
@export var west_texture: Texture2D 

func _ready():
	super._ready()
	sprite.texture = south_texture
	LevelEvents.on_gravity_changed.connect(_gravity_change)
	

func _gravity_change(direction: Vector2):
	var next_texture: Texture2D

	match direction:
		Vector2.UP:
			next_texture = north_texture
		Vector2.RIGHT:
			next_texture = east_texture
		Vector2.DOWN:
			next_texture = south_texture
		Vector2.LEFT:
			next_texture = west_texture
	sprite.texture = next_texture
