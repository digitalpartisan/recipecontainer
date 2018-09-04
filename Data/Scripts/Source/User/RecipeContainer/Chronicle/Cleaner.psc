Scriptname RecipeContainer:Chronicle:Cleaner extends Chronicle:Package:CustomBehavior

RecipeContainer:Logic[] Property Containers = None Auto Const

Function cleanContainers()
	if (!Containers)
		return
	endif

	Int iCounter = 0
	while (iCounter < Containers.Length)
		Containers[iCounter].cleanData();
		iCounter += 1
	endWhile
EndFunction

Bool Function postloadBehavior()
	cleanContainers()
	return true
EndFunction
