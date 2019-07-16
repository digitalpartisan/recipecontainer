Scriptname RecipeContainer:Recipe extends Quest Hidden Const

Import DialogueDrinkingBuddyScript

Potion Function getUnprocessedForm()
	RecipeContainer:Logger.logBehaviorUndefined(self, "getUnprocessedForm")
EndFunction

Potion Function getProcessedForm()
	RecipeContainer:Logger.logBehaviorUndefined(self, "getProcessedForm")
EndFunction

BrewingRecipe Function get()
	return RecipeContainer:Utility:Recipe.create(getUnprocessedForm(), getProcessedForm())
EndFunction
