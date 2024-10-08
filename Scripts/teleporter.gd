extends Area2D

#@onready var character = $"../Character"


func _on_body_entered(body: Node2D) -> void:
	pass



func _on_area_entered(area: Area2D) -> void:
	#print("area")
	#area.position = ???
	# check if selected from the level manager???
	# if selected and other teleporter is selected:
	print("teleported")
	#character.position 
	
