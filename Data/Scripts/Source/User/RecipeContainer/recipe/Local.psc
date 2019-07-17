Scriptname RecipeContainer:Recipe:Local extends RecipeContainer:Recipe Hidden Const

Form Property Unprocessed Auto Const Mandatory
Form Property Processed Auto Const Mandatory

Form Function getUnprocessedForm()
	return Unprocessed
EndFunction

Form Function getProcessedForm()
	return Processed
EndFunction
