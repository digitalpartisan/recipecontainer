Scriptname RecipeContainer:Recipe:Remote:SemiComplex:Processed extends RecipeContainer:Recipe:Remote:SemiComplex

Potion Function getUnprocessedForm()
	return LocalForm
EndFunction

Potion Function getProcessedForm()
	RecipeContainer:Utility:Remote.loadDigits(Plugin, RemoteDigits)
EndFunction
