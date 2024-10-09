class_name Teleporter

extends Area2D

signal teleporter_clicked(teleporter: Area2D)
signal teleporter_area_entered(teleporter: Area2D, area: Area2D)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	pass

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			teleporter_clicked.emit(self)

func _on_area_entered(area: Area2D) -> void:
	teleporter_area_entered.emit(self, area)
	

func activate() -> void:
	sprite.modulate = Color.GREEN
	

func deactivate() -> void:
	sprite.modulate = Color.WHITE

	
