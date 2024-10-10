extends Area2D

@onready var character: Area2D = $"../Character"


func _on_area_entered(area: Area2D) -> void:
	queue_free()
	character.timer.paused = true
	character.sprite.play("idle")
