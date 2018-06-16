Scriptname RecipeContainer:Utility Hidden Const
{Useful logic for modifying recipe arrays and creating new recipes to add to container types.}

Import DialogueDrinkingBuddyScript

BrewingRecipe Function createRecipe(Potion apWarmVariant, Potion apColdVariant) Global
	BrewingRecipe newRecipe = new BrewingRecipe
	newRecipe.WarmDrinkVariant = apWarmVariant
	newRecipe.ColdDrinkVariant = apColdVariant
	
	return newRecipe
EndFunction

Int Function findRecipe(BrewingRecipe[] dataSet, BrewingRecipe targetRecipe) Global
	return dataSet.Find(targetRecipe)
EndFunction

Int Function findRecipeInContainer(RecipeContainer:Logic targetContainer, BrewingRecipe targetRecipe) Global
	return findRecipe(targetContainer.CustomRecipes, targetRecipe)
EndFunction

Bool Function hasRecipe(BrewingRecipe[] dataSet, BrewingRecipe targetRecipe) Global
	return 0 <= findRecipe(dataSet, targetRecipe)
EndFunction

Bool Function containerHasRecipe(RecipeContainer:Logic targetContainer, BrewingRecipe targetRecipe) Global
	return 0 <= findRecipeInContainer(targetContainer, targetRecipe)
EndFunction

Function addRecipe(BrewingRecipe[] dataSet, BrewingRecipe newRecipe) Global
	Int iLocation = findRecipe(dataSet, newRecipe)
	if (iLocation < 0)
		dataSet.Add(newRecipe)
	endif
EndFunction

Function addRecipes(BrewingRecipe[] dataSet, BrewingRecipe[] newData) Global
	Int iCounter = 0
	while (iCounter < newData.Length)
		addRecipe(dataSet, newData[iCounter])
		iCounter += 1
	endWhile
EndFunction

Function addRecipeToContainer(RecipeContainer:Logic targetContainer, BrewingRecipe newRecipe) Global
	addRecipe(targetContainer.CustomRecipes, newRecipe)
EndFunction

Function addRecipesToContainer(RecipeContainer:Logic targetContainer, BrewingRecipe[] newData) Global
	RecipeContainer:Logger.logAddingRecipes(targetContainer, newData)
	addRecipes(targetContainer.CustomRecipes, newData)
EndFunction

Function removeRecipe(BrewingRecipe[] dataSet, BrewingRecipe targetRecipe) Global
	Int iLocation = findRecipe(dataSet, targetRecipe)
	if (iLocation >= 0)
		dataSet.Remove(iLocation)
	endif
EndFunction

Function removeRecipes(BrewingRecipe[] dataSet, BrewingRecipe[] oldData) Global
	Int iCounter = 0
	while (iCounter <= oldData.Length)
		removeRecipe(dataSet, oldData[iCounter])
		iCounter += 1
	endWhile
EndFunction

Function removeRecipeFromContainer(RecipeContainer:Logic targetContainer, BrewingRecipe targetRecipe) Global
	removeRecipe(targetContainer.CustomRecipes, targetRecipe)
EndFunction

Function removeRecipesFromContainer(RecipeContainer:Logic targetContainer, BrewingRecipe[] oldData) Global
	RecipeContainer:Logger.logRemovingRecipes(targetContainer, oldData)
	removeRecipes(targetContainer.CustomRecipes, oldData)
EndFunction

Function appendContainerRecipes(RecipeContainer:Logic targetContainer, RecipeContainer:Logic sourceContainer) Global
	RecipeContainer:Logger.logAppendContainerRecipes(targetContainer, sourceContainer)
	addRecipes(targetContainer.CustomRecipes, sourceContainer.customRecipes)
EndFunction

Function removeContainerRecipes(RecipeContainer:Logic targetContainer, RecipeContainer:Logic sourceContainer) Global
	RecipeContainer:Logger.logRemoveContainerRecipes(targetContainer, sourceContainer)
	removeRecipes(targetContainer.CustomRecipes, sourceContainer.customRecipes)
EndFunction

Function cleanDataSet(BrewingRecipe[] dataSet) Global
	Int iCounter = 0
	BrewingRecipe currentRecipe = None
	while (iCounter < dataSet.Length)
		currentRecipe = dataSet[iCounter]
		if (!currentRecipe || !currentRecipe.WarmDrinkVariant || !currentRecipe.ColdDrinkVariant)
			dataSet.Remove(iCounter)
		else
			iCounter += 1 ; because if an item was removed, no increment is required to proceed to it
		endif
	endWhile
EndFunction

Function cleanContainerData(RecipeContainer:Logic targetContainer) Global
	RecipeContainer:Logger.logCleaning(targetContainer)
	RecipeContainer:Logger.logContainerRecipes(targetContainer)
	cleanDataSet(targetContainer.CustomRecipes)
	RecipeContainer:Logger.logContainerRecipes(targetContainer)
EndFunction
