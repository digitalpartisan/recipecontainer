Scriptname RecipeContainer:Logger Hidden Const DebugOnly

Import DialogueDrinkingBuddyScript

String Function getName() Global
	return "RecipeContainer"
EndFunction

Bool Function log(String sMessage, String[] tags = None) Global
	return Jiffy:Loggout.log(getName(), sMessage, tags)
EndFunction

Bool Function warn(String sMessage, String[] tags = None) Global
	return Jiffy:Loggout.warn(getName(), sMessage, tags)
EndFunction

Bool Function error(String sMessage, String[] tags = None) Global
	return Jiffy:Loggout.error(getName(), sMessage, tags)
EndFunction

Bool Function logBehaviorUndefined(ScriptObject object, String sFunctionName) Global
	return warn(object + " is missing a definition for the behavior " + sFunctionName)
EndFunction

Bool Function logCycle(RecipeContainer:ContainerInstance akContainerRef) Global
	return log(akContainerRef + " processing")
EndFunction

Bool Function logReplacement(ObjectReference akContainerRef, Form apSearch, Form apReplace, Int iCount) Global
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

Bool Function logCleaning(RecipeContainer:Logic akContainerType) Global
	return log(akContainerType + " is being cleaned")
EndFunction

Bool Function logBrewingRecipeConversion(DialogueDrinkingBuddyScript:BrewingRecipe oldRecipe, RecipeContainer:Utility:Recipe:SimpleRecipe newRecipe) Global
	return log("converted " + oldRecipe + " to " + newRecipe)
EndFunction

Bool Function logCouldNotCreateSimpleRecipe(Form unprocessed, Form processed) Global
	return error("could not create new simple recipe with input " + unprocessed + " " + processed)
EndFunction
