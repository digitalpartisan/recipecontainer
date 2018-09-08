Scriptname RecipeContainer:RemoteRecipes extends Quest

Import DialogueDrinkingBuddyScript

Struct RemoteRecipeDefinition
	Potion UnprocessedForm = None
	Int UnprocessedID = 0
	Potion ProcessedForm = None
	Int ProcessedID = 0
EndStruct

InjectTec:Plugin Property Plugin Auto Const Mandatory
RemoteRecipeDefinition[] Property RecipeDefinitions = None Auto Const

Potion Function getPotion(InjectTec:Plugin targetPlugin, Potion localForm = None, Int targetID = 0)
	if (localForm)
		return localForm
	endif
	
	return targetPlugin.lookupForm(targetID) as Potion
EndFunction

Potion Function getUnprocessedPotion(RemoteRecipeDefinition dataSet)
	return getPotion(Plugin, dataSet.UnprocessedForm, dataSet.UnprocessedID)
EndFunction

Potion Function getProcessedPotion(RemoteRecipeDefinition dataSet)
	return getPotion(Plugin, dataSet.ProcessedForm, dataSet.ProcessedID)
EndFunction

BrewingRecipe Function buildRecipe(RemoteRecipeDefinition dataSet)
	Potion unprocessedForm = getUnprocessedPotion(dataSet)
	Potion processedForm = getProcessedPotion(dataSet)
	
	if (!unprocessedForm || !processedForm)
		return None
	endif
	
	return RecipeContainer:Utility.createRecipe(unprocessedForm, processedForm)
EndFunction

BrewingRecipe[] Function buildRecipes()
	if (!RecipeDefinitions)
		return None
	endif

	BrewingRecipe[] recipes = new BrewingRecipe[0]
	Int iCounter = 0
	BrewingRecipe newRecipe = None
	while (iCounter < RecipeDefinitions.Length)
		newRecipe = buildRecipe(RecipeDefinitions[iCounter])
		if (!newRecipe)
			return None
		endif
		
		recipes.Add(newRecipe)
		iCounter += 1
	endWhile
	
	return recipes
EndFunction
