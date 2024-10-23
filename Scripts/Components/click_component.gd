extends Node2D

class_name ClickComponent

@export var mouse_button: MouseButton = MOUSE_BUTTON_LEFT
@export var click_component: Area2D

# Define the signal with an Area2D parameter
signal click(area: Area2D)

func _ready():
	click_component.connect("input_event", on_click_event)

# Handle the input_event from click_component
func on_click_event(viewport: Viewport, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton:
		if event.button_index == mouse_button and event.pressed:
			click.emit(click_component)
