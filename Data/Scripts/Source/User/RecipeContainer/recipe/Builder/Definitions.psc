Scriptname RecipeContainer:Recipe:Builder:Definitions extends RecipeContainer:Recipe:Builder

Import RecipeContainer:Utility:Recipe

RecipeContainer:Recipe[] Property RecipesToBuild Auto Const
{Standard way of listing the recipe definitions}
FormList Property RecipeList Auto Const
{Using a FormList to list the recipe definitions may be preferrable if there are many of them or they change between updates on a regular basis.}

RecipeContainer:Recipe[] Function getDefinitions()
	if (RecipesToBuild)
		return RecipesToBuild
	endif
	
	if (RecipeList)
		return Jiffy:Utility:FormList.toArray(RecipeList) as RecipeContainer:Recipe[]
	endif
	
	return None
EndFunction

Var[] Function populateBehavior()
	RecipeContainer:Recipe[] definitionList = getDefinitions()

	if (!definitionList || !definitionList.Length)
		RecipeContainer:Recipe:Builder:Logger.noRecipes(self)
		return None
	endif
	
	SimpleRecipe[] results = new SimpleRecipe[0]
	
	Int iCounter = 0
	RecipeContainer:Recipe recipe = None
	SimpleRecipe newRecipe = None
	
	while (iCounter < definitionList.Length)
		recipe = definitionList[iCounter]
		if (!recipe)
			RecipeContainer:Recipe:Builder:Logger.invalidRecipe(self, iCounter, recipe)
			return None
		endif
		
		newRecipe = recipe.get()
		if (!newRecipe)
			RecipeContainer:Recipe:Builder:Logger.invalidSimpleRecipe(self, iCounter, newRecipe)
			return None
		endif
		
		results.Add(newRecipe)
		
		iCounter += 1
	endWhile
	
	return results as Var[]
EndFunction
