Scriptname RecipeContainer:ChroniclePackage:Behavior:RecipeBuilderListUpdate extends Chronicle:Package:CustomBehavior

RecipeContainer:Recipe:Builder:List[] Property BuilderLists Auto Const Mandatory

Bool Function postloadBehavior()
	RecipeContainer:Recipe:Builder:List.updateBuildersBulk(BuilderLists)
	return true
EndFunction
