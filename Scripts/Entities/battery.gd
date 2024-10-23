extends Area2D

@onready var character: Area2D = $"../Character"
@onready var end_screen = $"../EndScreen"


func _on_area_entered(area: Area2D) -> void:
	queue_free()
	character.timer.paused = true
	character.sprite.play("idle")
	end_screen.visible = true
