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
	if self.has_overlapping_areas():
		var closest_area = self.get_overlapping_areas().reduce(func (a,b):return a if self.position.distance_to(a.position)<=self.position.distance_to(b.position) else b)
		teleporter_area_entered.emit(self, closest_area)

func select() -> void:
	sprite.modulate = Color.YELLOW

func deactivate() -> void:
	sprite.modulate = Color.WHITE

	
