Scriptname RecipeContainer:Logic:PackageBehavior extends Chronicle:Package:CustomBehavior

RecipeContainer:Logic[] Property Containers Auto Const Mandatory

RecipeContainer:Logic[] Function getContainers()
    return Containers
EndFunction

Bool Function installBehavior()
	RecipeContainer:Logic.startBulk(getContainers())
	return true
EndFunction

Bool Function postloadBehavior()
	RecipeContainer:Logic.cleanBulk(getContainers())
	return true
EndFunction

Bool Function uninstallBehavior()
	RecipeContainer:Logic.stopBulk(getContainers())
	return true
EndFunction
