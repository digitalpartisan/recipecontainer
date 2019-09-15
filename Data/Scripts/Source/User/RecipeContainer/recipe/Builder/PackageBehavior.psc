Scriptname RecipeContainer:Recipe:Builder:PackageBehavior extends Chronicle:Package:CustomBehavior

RecipeContainer:Recipe:Builder[] Property Builders Auto Const Mandatory

Bool Function postloadBehavior()
	RecipeContainer:Recipe:Builder.updateBulk(Builders)
	return true
EndFunction
