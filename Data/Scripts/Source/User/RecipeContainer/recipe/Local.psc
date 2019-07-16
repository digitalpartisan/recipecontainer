Scriptname RecipeContainer:Recipe:Local extends RecipeContainer:Recipe Hidden Const

Potion Property Unprocessed Auto Const Mandatory
Potion Property Processed Auto Const Mandatory

Potion Function getUnprocessedForm()
	return Unprocessed
EndFunction

Potion Function getProcessedForm()
	return Processed
EndFunction
