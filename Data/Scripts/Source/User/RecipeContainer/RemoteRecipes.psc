Scriptname RecipeContainer:RemoteRecipes extends Quest

Import RecipeContainer:Utility:Recipe
Import InjectTec:Utility:HexidecimalLogic

Struct RemoteRecipeDefinition
	Potion UnprocessedForm = None
	Int UnprocessedID = 0
	Potion ProcessedForm = None
	Int ProcessedID = 0
EndStruct

InjectTec:Plugin Property Plugin Auto Const Mandatory
RemoteRecipeDefinition[] Property RecipeDefinitions = None Auto Const

Form Function getPotion(InjectTec:Plugin targetPlugin, Potion localForm = None, Int targetID = 0)
	if (localForm)
		return localForm
	endif
	
	return targetPlugin.lookup(targetID)
EndFunction

Form Function getUnprocessedPotion(RemoteRecipeDefinition dataSet)
	return getPotion(Plugin, dataSet.UnprocessedForm, dataSet.UnprocessedID)
EndFunction

Form Function getProcessedPotion(RemoteRecipeDefinition dataSet)
	return getPotion(Plugin, dataSet.ProcessedForm, dataSet.ProcessedID)
EndFunction

SimpleRecipe Function buildRecipe(RemoteRecipeDefinition dataSet)
	Form unprocessedForm = getUnprocessedPotion(dataSet)
	Form processedForm = getProcessedPotion(dataSet)
	
	if (!unprocessedForm || !processedForm)
		return None
	endif
	
	return create(unprocessedForm, processedForm)
EndFunction

SimpleRecipe[] Function buildRecipes()
	if (!RecipeDefinitions)
		return None
	endif

	SimpleRecipe[] recipes = new SimpleRecipe[0]
	Int iCounter = 0
	SimpleRecipe newRecipe = None
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
