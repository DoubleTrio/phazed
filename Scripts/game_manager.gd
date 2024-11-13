extends Node

var selected_level = null

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
