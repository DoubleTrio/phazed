extends Node2D


# variable to store both teleporters
var active_teleporters = []
#var teleporters
@onready var teleporters = $"../Teleporters"


func _ready() -> void:
	# STore the index of the teleporters
	#print(teleporters)
	#print(teleporters.get_child_count())
	for teleporter in teleporters.get_children():
		teleporter.teleporter_clicked.connect(_on_teleporter_click)
		teleporter.teleporter_area_entered.connect(_on_teleporter_area_entered)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_teleporter_click(teleporter: Area2D) -> void:
	if teleporter in active_teleporters:
		active_teleporters.erase(teleporter)
		teleporter.deactivate()
	else:
		active_teleporters.push_back(teleporter)
		teleporter.activate()
		while len(active_teleporters) > 2:
			active_teleporters.pop_front().deactivate()

func _on_teleporter_area_entered(teleporter: Area2D, area: Area2D) -> void:
	if len(active_teleporters)==2 and teleporter in active_teleporters:
		var new_pos = active_teleporters.filter(func(t): return t!=teleporter)[0].global_position
		var tween = area.get("tween")
		if tween is Tween:
			await tween.finished
		area.global_position = new_pos
		
		for curr_t in active_teleporters:
			curr_t.deactivate()
		active_teleporters.clear()
	
