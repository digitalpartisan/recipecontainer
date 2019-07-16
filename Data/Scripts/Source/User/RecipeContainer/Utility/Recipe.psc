Scriptname RecipeContainer:Utility:Recipe Hidden Const

Import DialogueDrinkingBuddyScript

BrewingRecipe Function create(Potion unprocessedVariant, Potion processedVariant) Global
	if (!unprocessedVariant || !processedVariant)
		return None
	endif
	
	BrewingRecipe newRecipe = new BrewingRecipe
	newRecipe.WarmDrinkVariant = unprocessedVariant
	newRecipe.ColdDrinkVariant = processedVariant
	
	return newRecipe
EndFunction

Bool Function validate(BrewingRecipe recipe) Global
	return recipe && recipe.WarmDrinkVariant && recipe.ColdDrinkVariant
EndFunction

Bool Function clean(BrewingRecipe[] recipes) Global
	Int iCounter = 0
	Bool bResult = false
	
	while (iCounter < recipes.Length)
		if (!validate(recipes[iCounter]))
			recipes.Remove(iCounter)
			bResult = true
		else
			iCounter += 1 ; because if an item was removed, no increment is required to proceed to it
		endif
	endWhile
	
	return bResult
EndFunction
