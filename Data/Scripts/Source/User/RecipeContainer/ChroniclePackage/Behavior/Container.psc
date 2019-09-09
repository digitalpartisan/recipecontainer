Scriptname RecipeContainer:ChroniclePackage:Behavior:Container extends Chronicle:Package:CustomBehavior

RecipeContainer:Logic[] Property Containers Auto Const Mandatory

Bool Function installBehavior()
	RecipeContainer:Logic.startBulk(Containers)
	return true
EndFunction

Bool Function postloadBehavior()
	RecipeContainer:Logic.cleanBulk(Containers)
	return true
EndFunction

Bool Function uninstallBehavior()
	RecipeContainer:Logic.stopBulk(Containers)
	return true
EndFunction
