extends Button

@export_file var level_path

var original_scale := scale
var grow_scale := scale * Vector2(1.1, 1.1)

func _ready() -> void:
	self.pivot_offset = self.size/2

func _on_mouse_entered() -> void:
	grow_btn(grow_scale, 0.1)

func _on_mouse_exited() -> void:
	grow_btn(original_scale, 0.1)

func grow_btn(end_scale: Vector2, duration: float) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'scale', end_scale, duration)

func _on_pressed() -> void:
	if level_path == null:
		return
	GameManager.selected_level = level_path
	get_tree().change_scene_to_file(level_path)
