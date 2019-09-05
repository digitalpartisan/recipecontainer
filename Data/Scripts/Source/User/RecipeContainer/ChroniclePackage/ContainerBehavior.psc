Scriptname RecipeContainer:ChroniclePackage:ContainerBehavior extends Chronicle:Package:CustomBehavior

RecipeContainer:Logic[] Property Containers Auto Const Mandatory

Function startContainers()
	RecipeContainer:Logic.startBulk(Containers)
EndFunction

Function shutdownContainers()
	RecipeContainer:Logic.stopBulk(Containers)
EndFunction

Function cleanContainers()
	RecipeContainer:Logic.cleanBulk(Containers)
EndFunction

Bool Function installBehavior()
	startContainers()
	return true
EndFunction

Bool Function postloadBehavior()
	cleanContainers()
	return true
EndFunction

Bool Function uninstallBehavior()
	shutdownContainers()
	return true
EndFunction
