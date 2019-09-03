Scriptname RecipeContainer:Recipe:Local extends RecipeContainer:Recipe

Group FormSettings
	Form Property Unprocessed Auto Const Mandatory
	Form Property Processed Auto Const Mandatory
EndGroup

Form Function getUnprocessedForm()
	return Unprocessed
EndFunction

Form Function getProcessedForm()
	return Processed
EndFunction
