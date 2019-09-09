Scriptname RecipeContainer:recipe:Remote:SemiComplex:Unprocessed extends RecipeContainer:recipe:Remote:SemiComplex

Form Function getUnprocessedForm()
	return RecipeContainer:Utility:Remote.loadDigits(Plugin, RemoteDigits)
EndFunction

Form Function getProcessedForm()
	return LocalForm
EndFunction
