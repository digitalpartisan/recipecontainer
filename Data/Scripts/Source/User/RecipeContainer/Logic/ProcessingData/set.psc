Scriptname RecipeContainer:Logic:ProcessingData:Set extends RecipeContainer:Utility:Processing:List Hidden

Import RecipeContainer:Utility:Processing

FormList Property SearchForms Auto Const Mandatory

FormList Function getSearchForms()
	return SearchForms
EndFunction

Function clear()
	getSearchForms().Revert()
	parent.clear()
EndFunction

ProcessPattern Function preAddTransform(Var avItem)
	return avItem as ProcessPattern
EndFunction

Bool Function add(Var avItem)
	ProcessPattern patternValue = preAddTransform(avItem)
	Bool bParentReturn = parent.add(patternValue)
	if (bParentReturn)
		SearchForms.AddForm(patternValue.search)
	endif
	
	return bParentReturn
EndFunction

Bool Function canProcessContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	if (!akContainerRef)
		RecipeContainer:Logger:Logic.logCannotProcessReference(self)
		return false
	endif
	
	return akContainerRef.GetItemCount(getSearchForms()) as Bool
EndFunction
