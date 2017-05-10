Scriptname RecipeContainer:Logger Hidden Const DebugOnly

String Function getName() Global
	return "RecipeContainer"
EndFunction

Bool Function log(String sMessage) Global
	return Loggout.log(getName(), sMessage)
EndFunction

Bool Function warn(String sMessage) Global
	return Loggout.warn(getName(), sMessage)
EndFunction

Bool Function error(String sMessage) Global
	return Loggout.error(getName(), sMessage)
EndFunction

Bool Function logCycle(RecipeContainer:ContainerInstance akContainerRef) Global
	return log(akContainerRef + " processing, cooling: " + akContainerRef.isCooling())
EndFunction

Bool Function logReplacement(RecipeContainer:ContainerInstance akContainerRef, Potion apSearch, Potion apReplace, Int iCount) Global
	return log(akContainerRef + " replaced " + iCount + " of " + apSearch + " with " + apReplace)
EndFunction

Bool Function logDestruction(RecipeContainer:ContainerInstance akContainerRef) Global
	return log(akContainerRef + " removed from workshop")
EndFunction

Bool Function logState(RecipeContainer:ContainerInstance akContainerRef, String sState) Global
	return log(akContainerRef + " in state: " + sState)
EndFunction

Bool Function logNeedsProcessing(RecipeContainer:ContainerInstance akContainerRef, Bool bNeeded) Global
	return log(akContainerRef + " needs processing: " + bNeeded)
EndFunction

Bool Function logPowerEvent(RecipeContainer:ContainerInstance akContainerRef) Global
	return log(akContainerRef + " has power: " + akContainerRef.IsPowered())
EndFunction

Bool Function logInit(RecipeContainer:ContainerInstance akContainerRef) Global
	return log(akContainerRef + " has initialized")
EndFunction
