extends Area2D

class_name LockBlock

@onready var sprite = $Sprite2D
@export var color_code: ColorID

func _ready():
	sprite.modulate = color_code.color
