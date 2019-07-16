Scriptname RecipeContainer:Utility:Processing Hidden Const

Import DialogueDrinkingBuddyScript

Struct ProcessPattern
	Potion search
	Potion replace
EndStruct

Bool Function validatePattern(ProcessPattern pattern) Global
	return (pattern && pattern.search && pattern.replace)
EndFunction

ProcessPattern Function create(BrewingRecipe recipe) Global
	if (!RecipeContainer:Utility:Recipe.validate(recipe))
		return None
	endif
	
	ProcessPattern pattern = new ProcessPattern
	pattern.search = recipe.WarmDrinkVariant
	pattern.replace = recipe.ColdDrinkVariant
	
	return pattern
EndFunction

ProcessPattern Function reverse(ProcessPattern pattern) Global
	if (!validatePattern(pattern))
		return None
	endif
	
	ProcessPattern reversal = new ProcessPattern
	reversal.search = pattern.replace
	reversal.replace = pattern.search
	
	return reversal
EndFunction

Function processReferencePattern(ObjectReference akContainerRef, ProcessPattern pattern) Global
	if (!akContainerRef || !pattern)
		return
	endif
	
	Int iCount = akContainerRef.GetItemCount(pattern.search)
	if (!iCount)
		return
	endif
	
	RecipeContainer:Logger.logReplacement(akContainerRef, pattern.search, pattern.replace, iCount)
	akContainerRef.RemoveItem(pattern.search, iCount, true)
	akContainerRef.AddItem(pattern.replace, iCount, true)
EndFunction

Function processReference(ObjectReference akContainerRef, ProcessPattern[] patterns) Global
	if (!akContainerRef || !akContainerRef.GetItemCount() || !patterns || !patterns.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < patterns.Length)
		processReferencePattern(akContainerRef, patterns[iCounter])
		iCounter += 1
	endWhile
EndFunction