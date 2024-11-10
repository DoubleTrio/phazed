extends Area2D

class_name LockBlock

@onready var sprite = $Sprite2D
@export var color_code: ColorID
@export var required_keys: int = 1

func _ready():
	sprite.modulate = color_code.color

func action():
	required_keys -= 1
	if (required_keys <= 0):
		LevelScene.instance.remove_block(self)
