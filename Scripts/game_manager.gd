extends Node


func wait(delay: float):
	await self.get_tree().create_timer(delay).timeout
	
func wait_next_frame():
	await self.get_tree().process_frame

func play_sound(name: String):
	var file_name = "res://Sounds/" + name
	var audio_stream = load(file_name)
	
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = audio_stream
	add_child(audio_player)
	audio_player.play()
	audio_player.connect("finished", audio_player.queue_free)
	
#func play_sound_with_stream(audio_stream: AudioStream

func _input(event):
	if LevelScene.instance == null:
		return
	if event.is_pressed():
		LevelScene.instance.level_start.emit()
	
	if event.is_action_pressed("restart"):
		(func():
			(func():
				wait_next_frame()
				if get_tree() != null:
					LevelScene.instance = null
					get_tree().reload_current_scene()
			).call_deferred()
		).call_deferred()
	else:
		if event.is_action_pressed("pause"):
			LevelScene.instance.paused = !LevelScene.instance.paused
		if !LevelScene.instance.paused:
			if Input.is_action_pressed("speed_up"):
				LevelScene.instance.set_speed(LevelScene.Speed.FAST)
			else:
				LevelScene.instance.set_speed(LevelScene.Speed.NORMAL)
