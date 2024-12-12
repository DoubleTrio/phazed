class_name Teleporter

extends Entity

@onready var click_component: ClickComponent = $ClickComponent as ClickComponent
@onready var toggle_component: ToggleComponent = $ToggleComponent as ToggleComponent
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D as AnimatedSprite2D
@onready var detect_area_component = $DetectAreaComponent

@export var inactive_color: Color = Color.WHITE
@export var selected_color: Color = Color.YELLOW
@export var active_color: Color = Color.GREEN
@export var mouse_button: MouseButton = MOUSE_BUTTON_LEFT

var current_entity:
	get:
		return detect_area_component.latest_entity

func has_entity() -> bool:
	return current_entity != null

func _ready():
	super._ready()
	set_color(inactive_color)
	
func _enter_entity(entity: Entity):
	current_entity = entity
	
func _exit_entity(entity: Entity):
	current_entity = null
	
func _on_activate():
	pass
	
func _on_deactivate():
	pass

func activate() -> void:
	set_color(active_color)
	
func select() -> void:
	toggle_component.toggle_on()
	set_color(selected_color)

func deactivate() -> void:
	toggle_component.toggle_off()
	set_color(inactive_color)

func is_active() -> bool:
	return toggle_component.is_active

func set_color(new_color: Color) -> void:
	sprite.modulate = new_color
	sprite.material.set_shader_parameter("color_workaround",new_color)
