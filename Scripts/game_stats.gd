class_name GameStats

extends Resource

@export var total_times_teleported: int = 0 :
	set(value):
		total_times_teleported = value
		on_teleport.emit(total_times_teleported)

signal on_teleport(amt: int)
