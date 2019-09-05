Scriptname RecipeContainer:Logger:Builder Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[1]
	tags[0] = "Recipe Builder"
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

Bool Function noRecipes(RecipeContainer:Recipe:Builder record) Global
	return error(record + " has no recipes, will build nothing")
EndFunction

Bool Function invalidRecipe(RecipeContainer:Recipe:Builder record, Int iIndex, RecipeContainer:Recipe recipe) Global
	return error(record + " found invalid recipe definition at index " + iIndex + " with value " + recipe)
EndFunction

Bool Function invalidSimpleRecipe(RecipeContainer:Recipe:Builder record, Int iIndex, RecipeContainer:Utility:Recipe:SimpleRecipe simple) Global
	return error(record + " build an invalid simple recipe at index " + iIndex + " with value " + simple)
EndFunction
