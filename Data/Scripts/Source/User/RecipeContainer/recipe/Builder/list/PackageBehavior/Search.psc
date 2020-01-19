Scriptname RecipeContainer:Recipe:Builder:List:PackageBehavior:Search extends Chronicle:Package:CustomBehavior:BehaviorSearch

Bool Function meetsCriteria(Chronicle:Package:CustomBehavior behavior)
	return (behavior as RecipeContainer:Recipe:Builder:List:PackageBehavior)
EndFunction

RecipeContainer:Recipe:Builder:List:PackageBehavior[] Function searchRecipeBuilderLists(Chronicle:Package targetPackage)
	return search(targetPackage) as RecipeContainer:Recipe:Builder:List:PackageBehavior[]
EndFunction

RecipeContainer:Recipe:Builder:List:PackageBehavior Function searchOneRecipeBuilderList(Chronicle:Package targetPackage)
	return searchOne(targetPackage) as RecipeContainer:Recipe:Builder:List:PackageBehavior
EndFunction
