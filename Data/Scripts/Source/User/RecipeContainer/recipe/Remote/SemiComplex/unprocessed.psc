Scriptname RecipeContainer:recipe:Remote:SemiComplex:Unprocessed extends RecipeContainer:recipe:Remote:SemiComplex

Potion Function getUnprocessedForm()
	RecipeContainer:Utility:Remote.loadDigits(Plugin, RemoteDigits)
EndFunction

Potion Function getProcessedForm()
	return LocalForm
EndFunction
