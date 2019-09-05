Scriptname RecipeContainer:ContainerInstance:Queue extends Jiffy:List:Queue

Bool Function equalityCheck(Var avItemOne, Var avItemTwo)
	return (avItemOne as RecipeContainer:ContainerInstance) == (avItemtwo as RecipeContainer:ContainerInstance)
EndFunction

RecipeContainer:ContainerInstance Function getContainerInstance(Int iIndex)
	return get(iIndex) as RecipeContainer:ContainerInstance
EndFunction

RecipeContainer:ContainerInstance[] Function getContainerInstanceData()
	return getData() as RecipeContainer:ContainerInstance[]
EndFunction

RecipeContainer:ContainerInstance Function peekContainerInstance()
	return peek() as RecipeContainer:ContainerInstance
EndFunction

RecipeContainer:ContainerInstance Function pollContainerInstance()
	return poll() as RecipeContainer:ContainerInstance
EndFunction
