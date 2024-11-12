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
	sprite.modulate = inactive_color 
	
func _enter_entity(entity: Entity):
	current_entity = entity
	
func _exit_entity(entity: Entity):
	current_entity = null
	
func _on_activate():
	pass
	
func _on_deactivate():
	pass

func activate() -> void:
	sprite.modulate = active_color
	
func select() -> void:
	toggle_component.toggle_on()
	sprite.modulate = selected_color

func deactivate() -> void:
	toggle_component.toggle_off()
	sprite.modulate = inactive_color

func is_active() -> bool:
	return toggle_component.is_active
	
