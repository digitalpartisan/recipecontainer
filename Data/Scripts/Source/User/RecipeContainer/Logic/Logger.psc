Scriptname RecipeContainer:Logic:Logger Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Container Type Logic"
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

Bool Function remoteLoaded(RecipeContainer:Logic:Remote remoteContainer, RecipeContainer:Logic:Local localType) Global
	return log(remoteContainer + " loaded remote container type " + localType)
EndFunction

Bool Function remoteNotLoaded(RecipeContainer:Logic:Remote remoteContainer) Global
	return log(remoteContainer + " could not load remote container type")
EndFunction

Bool Function logRemoteNotFound(RecipeContainer:Logic:Remote remoteContainer) Global
	return log(remoteContainer + " was not found and cannot operate")
EndFunction
