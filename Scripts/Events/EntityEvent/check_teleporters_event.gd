extends EntityEvent

func apply(owner: Entity, context: LevelContext):
	var teleporter_manager: TeleportManager = LevelScene.instance.teleport_manager
	var active_teleporters = teleporter_manager.active_teleporters 
	var should_teleport = false
	
	if (len(active_teleporters) < 2):
		return
			
	for teleporter: Teleporter in active_teleporters:
		if (teleporter.has_entity()):
			should_teleport = true

	if should_teleport:
		var t1: Teleporter = active_teleporters[0]
		var t2: Teleporter = active_teleporters[1]
		if (t1.has_entity()):
			t1.current_entity.global_position = t2.global_position
		if (t2.has_entity()):
			t2.current_entity.global_position = t1.global_position
		
		LevelEvents.on_teleport.emit()
		teleporter_manager.remove_active_teleporters()
		
