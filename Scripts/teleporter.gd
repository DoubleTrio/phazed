extends Area2D

#@onready var character = $"../Character"

signal teleporter_clicked(teleporter)
signal teleporter_area_entered(teleporter,area)

@onready var levelManager = $"../../LevelMananger"

func _on_body_entered(body: Node2D) -> void:
	pass

func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			teleporter_clicked.emit(self)

func _on_area_entered(area: Area2D) -> void:
	teleporter_area_entered.emit(self,area)
	

func activate() -> void:
	print(self.name + " activated")
	

func deactivate() -> void:
	print(self.name + " has deactivated")
	
