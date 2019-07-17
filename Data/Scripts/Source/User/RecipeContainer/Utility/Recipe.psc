Scriptname RecipeContainer:Utility:Recipe Hidden Const

Import DialogueDrinkingBuddyScript

Struct SimpleRecipe
	Form unprocessed
	Form processed
EndStruct

SimpleRecipe Function create(Form unprocessedVariant, Form processedVariant) Global
	if (!unprocessedVariant || !processedVariant)
		return None
	endif
	
	SimpleRecipe newRecipe = new SimpleRecipe
	newRecipe.unprocessed = unprocessedVariant
	newRecipe.processed = processedVariant
	
	return newRecipe
EndFunction

SimpleRecipe Function createFromBrewingRecipe(BrewingRecipe recipe) Global
	if (!recipe)
		return None
	endif
	
	return create(recipe.WarmDrinkVariant, recipe.ColdDrinkVariant)
EndFunction

SimpleRecipe[] Function createFromBulkBrewingRecipe(BrewingRecipe[] recipes) Global
	if (!recipes || !recipes.Length)
		return None
	endif
	
	SimpleRecipe[] results = new SimpleRecipe[0]
	
	Int iCounter = 0
	while (iCounter < recipes.Length)
		results.Add(createFromBrewingRecipe(recipes[iCounter]))
		iCounter += 1
	endWhile
	
	return results
EndFunction

Bool Function validate(SimpleRecipe recipe) Global
	return recipe && recipe.unprocessed && recipe.processed
EndFunction

Bool Function clean(SimpleRecipe[] recipes) Global
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
