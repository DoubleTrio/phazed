extends Node

class_name ToggleComponent

signal activate()
signal deactivate()

var is_active = false :
	set(value):
		if value == is_active: return
		is_active = value
		if is_active:
			activate.emit()
		else:
			deactivate.emit()

func toggle() -> void:
	if is_active:
		is_active = false
	else:
		is_active = true

func toggle_off() -> void:
	if is_active == false: return
	
	is_active = false
	
func toggle_on() -> void:
	if is_active == true: return
	
	is_active = true

		
func set_active(should_activate: bool) -> void:
	is_active = should_activate
