extends Control

func _on_speed_up_button_button_down():
	var event = InputEventAction.new()
	event.action = "speed_up"
	event.pressed = true
	Input.parse_input_event(event)
		
func _on_speed_up_button_button_up():
	var event = InputEventAction.new()
	event.action = "speed_up"
	event.pressed = false
	Input.parse_input_event(event)
		
func _on_pause_button_button_down():
	var event = InputEventAction.new()
	event.action = "pause"
	event.pressed = true
	Input.parse_input_event(event)
	
func _on_pause_button_button_up():
	var event = InputEventAction.new()
	event.action = "pause"
	event.pressed = false
	Input.parse_input_event(event)

func _on_restart_button_button_down():
	var event = InputEventAction.new()
	event.action = "restart"
	event.pressed = true
	Input.parse_input_event(event)
	
