Scriptname RecipeContainer:Recipe extends Quest Hidden

Form Function getUnprocessedForm()
	RecipeContainer:Logger.logBehaviorUndefined(self, "getUnprocessedForm")
EndFunction

Form Function getProcessedForm()
	RecipeContainer:Logger.logBehaviorUndefined(self, "getProcessedForm")
EndFunction

RecipeContainer:Utility:Recipe:SimpleRecipe Function get()
	return RecipeContainer:Utility:Recipe.create(getUnprocessedForm(), getProcessedForm())
EndFunction
