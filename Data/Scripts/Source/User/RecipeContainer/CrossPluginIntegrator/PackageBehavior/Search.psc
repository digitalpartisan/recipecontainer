Scriptname RecipeContainer:CrossPluginIntegrator:PackageBehavior:Search extends Chronicle:Package:custombehavior:BehaviorSearch

Bool Function meetsCriteria(Chronicle:Package:CustomBehavior behavior)
	return (behavior as RecipeContainer:CrossPluginIntegrator:PackageBehavior)
EndFunction

RecipeContainer:CrossPluginIntegrator:PackageBehavior[] Function searchCrossPluginIntegrators(Chronicle:Package targetPackage)
	return search(targetPackage) as RecipeContainer:CrossPluginIntegrator:PackageBehavior[]
EndFunction

RecipeContainer:CrossPluginIntegrator:PackageBehavior Function searchOneCrossPluginIntegrator(Chronicle:Package targetPackage)
	return searchOne(targetPackage) as RecipeContainer:CrossPluginIntegrator:PackageBehavior
EndFunction
