extends Node2D

class_name TeleportManager

# variable to store both teleporters
var active_teleporters = []

func _ready() -> void:
	for teleporter: Teleporter in self.get_children():
		teleporter.click_component.click.connect(_on_teleporter_click)

func _on_teleporter_click(tp: Area2D) -> void:
	var teleporter: Teleporter = tp
	
	if teleporter.is_active():
		active_teleporters.erase(teleporter)
		teleporter.deactivate()
	else:
		active_teleporters.push_back(teleporter)
		teleporter.select()
		while len(active_teleporters) > 2:
			active_teleporters.pop_front().deactivate()
			
	for active_t: Teleporter in active_teleporters:
		if len(active_teleporters) == 1:
			active_t.select()
		elif len(active_teleporters) == 2:
			active_t.activate()
			
func remove_active_teleporters():
	for curr_t: Teleporter in active_teleporters:
		curr_t.deactivate()
	active_teleporters.clear()
