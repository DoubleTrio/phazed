extends Entity

class_name MarkerTeleporter

@onready var sprite = $Sprite2D

@export var marker: Node2D


func _ready():
	super._ready()
	sprite.visible = false
	
