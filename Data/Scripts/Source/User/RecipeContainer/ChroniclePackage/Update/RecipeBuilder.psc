Scriptname RecipeContainer:ChroniclePackage:Update:RecipeBuilder extends Chronicle:Package:Update

RecipeContainer:Recipe:Builder[] Property Builders Auto Const Mandatory

Function updateBuilders()
	RecipeContainer:Recipe:Builder.updateBulk(Builders)
EndFunction

Function updateLogic()
	updateBuilders()
	sendSuccess()
EndFunction
