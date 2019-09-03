Scriptname RecipeContainer:Recipe:Builder:Definitions extends RecipeContainer:Recipe:Builder

Import RecipeContainer:Utility:Recipe

RecipeContainer:Recipe[] Property RecipesToBuild Auto Const Mandatory

Var[] Function populateBehavior()
	if (!RecipesToBuild || !RecipesToBuild.Length)
		RecipeContainer:Logger:Builder.noRecipes(self)
		return None
	endif
	
	SimpleRecipe[] results = new SimpleRecipe[0]
	
	Int iCounter = 0
	RecipeContainer:Recipe recipe = None
	SimpleRecipe newRecipe = None
	
	while (iCounter < RecipesToBuild.Length)
		recipe = RecipesToBuild[iCounter]
		if (!recipe)
			RecipeContainer:Logger:Builder.invalidRecipe(self, iCounter, recipe)
			return None
		endif
		
		newRecipe = recipe.get()
		if (!newRecipe)
			RecipeContainer:Logger:Builder.invalidSimpleRecipe(self, iCounter, newRecipe)
			return None
		endif
		
		results.Add(newRecipe)
		
		iCounter += 1
	endWhile
	
	return results as Var[]
EndFunction
