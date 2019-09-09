Scriptname RecipeContainer:Recipe:Remote:SemiComplex:Processed extends RecipeContainer:Recipe:Remote:SemiComplex

Form Function getUnprocessedForm()
	return LocalForm
EndFunction

Form Function getProcessedForm()
	return RecipeContainer:Utility:Remote.loadDigits(Plugin, RemoteDigits)
EndFunction
