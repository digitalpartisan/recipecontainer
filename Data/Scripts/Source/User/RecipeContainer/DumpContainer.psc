Scriptname RecipeContainer:DumpContainer extends ObjectReference

RecipeContainer:Logic[] Property ContainerTypes Auto Const Mandatory
Int Property Amount = 10 Auto Const

Function refresh()
	RemoveAllItems()
	
	if (!ContainerTypes || !ContainerTypes.Length || Amount < 1)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < ContainerTypes.Length)
		ContainerTypes[iCounter] && ContainerTypes[iCounter].dumpToContainer(self, Amount)
		iCounter += 1
	endWhile
EndFunction
