Scriptname RecipeContainer:Logic:ProcessingData extends Quest

Import RecipeContainer:Utility:Processing
Import RecipeContainer:Utility:Recipe

Group ProcessingSets
	RecipeContainer:Logic:ProcessingData:Set:Forward Property ForwardSet Auto Const Mandatory
	RecipeContainer:Logic:ProcessingData:Set:Reverse Property ReverseSet Auto Const Mandatory
EndGroup

Function consumeRecipe(SimpleRecipe recipeData)
	if (!RecipeContainer:Utility:Recipe.validate(recipeData))
		return
	endif
	
	ProcessPattern newPattern = RecipeContainer:Utility:Processing.create(recipeData)
	ForwardSet.add(newPattern)
	ReverseSet.add(newPattern)
EndFunction

Function consumeBuilder(RecipeContainer:Recipe:Builder builder)
	if (!builder)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < builder.getSize())
		consumeRecipe(builder.getRecipe(iCounter))
		iCounter += 1
	endWhile
EndFunction

Function rebuild(RecipeContainer:Recipe:Builder:List builderList)
	ForwardSet.clear()
	ReverseSet.clear()
	
	if (!builderList)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < builderList.getSize())
		consumeBuilder(builderList.getBuilder(iCounter))
		iCounter += 1
	endWhile
EndFunction

RecipeContainer:Logic:ProcessingData:Set Function getDataSetForContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	if (!akContainerRef)
		return None
	endif
	
	if (akContainerRef.isProcessing())
		return ForwardSet
	endif
	
	return ReverseSet
EndFunction

Bool Function canProcessContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	RecipeContainer:Logic:ProcessingData:Set theSet = getDataSetForContainerInstance(akContainerRef)
	
	if (theSet)
		return theSet.canProcessContainerInstance(akContainerRef)
	endif
	
	return false
EndFunction

ProcessPattern[] Function getPatternsForContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	RecipeContainer:Logic:ProcessingData:Set theSet = getDataSetForContainerInstance(akContainerRef)
	
	if (theSet)
		return theSet.getProcessPatternData()
	endif
	
	return None
EndFunction
