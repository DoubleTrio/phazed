extends Control

class_name StatsHud

@onready var teleporter_label: Label = $TeleporterLabel as Label

func set_teleporter_label(text: String):
	teleporter_label.text = text
	
