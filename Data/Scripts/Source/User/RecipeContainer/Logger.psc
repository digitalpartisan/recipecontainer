Scriptname RecipeContainer:Logger Hidden Const DebugOnly

Import DialogueDrinkingBuddyScript

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

Bool Function logBehaviorUndefined(ScriptObject object, String sFunctionName) Global
	return warn(object + " is missing a definition for the behavior " + sFunctionName)
EndFunction

Bool Function logCycle(RecipeContainer:ContainerInstance akContainerRef) Global
	return log(akContainerRef + " processing, processing: " + akContainerRef.isProcessing())
EndFunction

Bool Function logReplacement(ObjectReference akContainerRef, Potion apSearch, Potion apReplace, Int iCount) Global
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

Bool Function logAddingRecipes(RecipeContainer:Logic akContainerType, BrewingRecipe[] recipes) Global
	return log(akContainerType + " is adding recipes: " + recipes)
EndFunction

Bool Function logRemovingRecipes(RecipeContainer:Logic akContainerType, BrewingRecipe[] recipes) Global
	return log(akContainerType + " is removing recipes: " + recipes)
EndFunction

Bool Function logAppendContainerRecipes(RecipeContainer:Logic targetContainer, RecipeContainer:Logic sourceContainer) Global
	return log(targetContainer + " is appending recipes from container " + sourceContainer)
EndFunction

Bool Function logRemoveContainerRecipes(RecipeContainer:Logic targetContainer, RecipeContainer:Logic sourceContainer) Global
	return log(targetContainer + " is removing recipes from container " + sourceContainer)
EndFunction

Bool Function logContainerRecipes(RecipeContainer:Logic targetContainer) Global
	return log(targetContainer + " has recipes: " + targetContainer.CustomRecipes)
EndFunction
