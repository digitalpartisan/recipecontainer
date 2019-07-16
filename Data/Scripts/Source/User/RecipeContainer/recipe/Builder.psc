Scriptname RecipeContainer:Recipe:Builder extends Quest Conditional

Import DialogueDrinkingBuddyScript

Struct RemoteRecipeDefinition
	Potion UnprocessedForm = None
	Int UnprocessedID = 0
	Potion ProcessedForm = None
	Int ProcessedID = 0
EndStruct

RemoteRecipeDefinition[] Property RecipeDefinitions = None Auto Const

RecipeContainer:Recipe[] Property Recipes Auto Const Mandatory

BrewingRecipe[] Function buildRecipes()
	if (!Recipes)
		return None
	endif

	BrewingRecipe[] brewables = new BrewingRecipe[0]
	Int iCounter = 0
	RecipeContainer:Recipe recipe = None
	BrewingRecipe newRecipe = None
	while (iCounter < RecipeDefinitions.Length)
		recipe = Recipes[iCounter]
		if (!recipe)
			return None
		endif
		
		newRecipe = recipe.get()
		if (!newRecipe)
			return None
		endif
		
		brewables.Add(newRecipe)
		iCounter += 1
	endWhile
	
	return brewables
EndFunction
