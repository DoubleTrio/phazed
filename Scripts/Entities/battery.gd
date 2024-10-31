extends Area2D

@export var end_screen: Control;

func _on_area_entered(area: Area2D) -> void:
	queue_free()
	#character.timer.paused = true
	#character.sprite.play("idle")
	#end_screen.visible = true
