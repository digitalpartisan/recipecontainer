Scriptname RecipeContainer:Recipe:Builder extends Quest

Import RecipeContainer:Utility:Recipe

Struct RemoteRecipeDefinition
	Potion UnprocessedForm = None
	Int UnprocessedID = 0
	Potion ProcessedForm = None
	Int ProcessedID = 0
EndStruct

RemoteRecipeDefinition[] Property RecipeDefinitions = None Auto Const

RecipeContainer:Recipe[] Property Recipes Auto Const Mandatory

SimpleRecipe[] Function buildRecipes()
	if (!Recipes)
		return None
	endif

	SimpleRecipe[] builtRecipes = new SimpleRecipe[0]
	Int iCounter = 0
	RecipeContainer:Recipe recipe = None
	SimpleRecipe newRecipe = None
	while (iCounter < RecipeDefinitions.Length)
		recipe = Recipes[iCounter]
		if (!recipe)
			return None
		endif
		
		newRecipe = recipe.get()
		if (!newRecipe)
			return None
		endif
		
		builtRecipes.Add(newRecipe)
		iCounter += 1
	endWhile
	
	return builtRecipes
EndFunction
