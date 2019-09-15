Scriptname RecipeContainer:Recipe:Builder:PackageBehavior:Search extends Chronicle:Package:CustomBehavior:BehaviorSearch

Bool Function meetsCriteria(Chronicle:Package:CustomBehavior behavior)
	return behavior is RecipeContainer:Recipe:Builder:PackageBehavior
EndFunction

RecipeContainer:Recipe:Builder:PackageBehavior[] Function searchRecipeBuilders(Chronicle:Package targetPackage)
	return search(targetPackage) as RecipeContainer:Recipe:Builder:PackageBehavior[]
EndFunction

RecipeContainer:Recipe:Builder:PackageBehavior Function searchOneRecipeBuilder(Chronicle:Package targetPackage)
	return searchOne(targetPackage) as RecipeContainer:Recipe:Builder:PackageBehavior
EndFunction
