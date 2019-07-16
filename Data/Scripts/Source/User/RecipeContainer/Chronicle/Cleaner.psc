Scriptname RecipeContainer:Chronicle:Cleaner extends Chronicle:Package:CustomBehavior

RecipeContainer:Logic[] Property Containers = None Auto Const

Function cleanContainers()
	RecipeContainer:Logic.cleanBulk(Containers)
EndFunction

Bool Function postloadBehavior()
	cleanContainers()
	return true
EndFunction
