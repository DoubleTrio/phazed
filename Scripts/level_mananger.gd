extends Node2D


# variable to store both teleporters
var stored_teleporter_index = []
#var teleporters
@onready var teleporters = $"../Teleporters"

func _ready() -> void:
	# STore the index of the teleporters
	#print(teleporters)
	#print(teleporters.get_child_count())
	for teleporter in teleporters.get_children():
		print(teleporter.name)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
