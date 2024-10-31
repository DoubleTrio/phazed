extends EntityEvent

func apply(owner: Entity, context: LevelContext):
	#print("COLLECTED KEY")
	#print(owner)
	if (owner.contains_component("IDComponent")):
		var id_component = owner.get_component("IDComponent") as IDComponent
		#print(id_component.id)
	
