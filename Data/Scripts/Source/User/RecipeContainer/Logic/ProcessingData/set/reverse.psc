Scriptname RecipeContainer:Logic:ProcessingData:Set:Reverse extends RecipeContainer:Logic:ProcessingData:Set

Import RecipeContainer:Utility:Processing

ProcessPattern Function preAddTransform(Var avItem)
	return reverse(avItem as ProcessPattern)
EndFunction
