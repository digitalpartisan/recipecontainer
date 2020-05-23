Scriptname RecipeContainer:ContainerInstance:Logger Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Container Instance"
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
	return log(object + " observed a power event, powered on: " + object.IsPowered())
EndFunction

Bool Function stateEvent(RecipeContainer:ContainerInstance object) Global
	return log(object + " has entered state: " + object.GetState())
EndFunction

Bool Function logStartTimer(RecipeContainer:ContainerInstance object) Global
	return log(object + " has started its timer")
EndFunction

Bool Function logTimerEvent(RecipeContainer:ContainerInstance object) Global
	return log(object + " has received a timer event")
EndFunction
