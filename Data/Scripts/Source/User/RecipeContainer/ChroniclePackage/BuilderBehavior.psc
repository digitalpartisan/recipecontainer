Scriptname RecipeContainer:ChroniclePackage:BuilderBehavior extends Chronicle:Package:CustomBehavior

RecipeContainer:Recipe:Builder[] Property Builders Auto Const Mandatory

Function updateBuilders()
	RecipeContainer:Recipe:Builder.updateBulk(Builders)
EndFunction

Bool Function postloadBehavior()
	updateBuilders()
	return true
EndFunction
