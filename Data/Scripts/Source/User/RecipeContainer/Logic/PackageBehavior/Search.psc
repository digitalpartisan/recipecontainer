Scriptname RecipeContainer:Logic:PackageBehavior:Search extends Chronicle:Package:custombehavior:BehaviorSearch

Bool Function meetsCriteria(Chronicle:Package:CustomBehavior behavior)
	return (behavior as RecipeContainer:Logic:PackageBehavior)
EndFunction

RecipeContainer:Logic:PackageBehavior[] Function searchContainers(Chronicle:Package targetPackage)
	return search(targetPackage) as RecipeContainer:Logic:PackageBehavior[]
EndFunction

RecipeContainer:Logic:PackageBehavior Function searchOneContainer(Chronicle:Package targetPackage)
	return searchOne(targetPackage) as RecipeContainer:Logic:PackageBehavior
EndFunction
