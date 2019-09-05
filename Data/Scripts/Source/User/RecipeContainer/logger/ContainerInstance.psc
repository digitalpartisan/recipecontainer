Scriptname RecipeContainer:Logger:ContainerInstance Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Container Instace"
	return tags
EndFunction

Bool Function log(String sMessage) Global
	return RecipeContainer:Logger.log(sMessage, getTags())
EndFunction

Bool Function warn(String sMessage) Global
	return RecipeContainer:Logger.warn(sMessage, getTags())
EndFunction

Bool Function error(String sMessage) Global
	return RecipeContainer:Logger.error(sMessage, getTags())
EndFunction

Bool Function initialization(RecipeContainer:ContainerInstance object) Global
	return log(object + " has been initialized")
EndFunction

Bool Function destruction(RecipeContainer:ContainerInstance object) Global
	return log(object + " has been destroyed")
EndFunction

Bool Function needsProcessing(RecipeContainer:ContainerInstance object, Bool bNeeds) Global
	return log(object + " needs processing: " + bNeeds)
EndFunction

Bool Function powerEvent(RecipeContainer:ContainerInstance object) Global
	return log(object + " observed a power event, powered on: " + object.IsPowered() + " and is processing: " + object.isProcessing())
EndFunction

Bool Function stateEvent(RecipeContainer:ContainerInstance object) Global
	return log(object + " has entered state: " + object.GetState())
EndFunction
