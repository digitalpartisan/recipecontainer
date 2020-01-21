Scriptname RecipeContainer:Recipe:Builder:List extends Jiffy:List

Bool Function equalityCheck(Var avItemOne, Var avItemTwo)
	return (avItemOne as RecipeContainer:Recipe:Builder) == (avItemTwo as RecipeContainer:Recipe:Builder)
EndFunction

RecipeContainer:Recipe:Builder Function getBuilder(Int iIndex)
	return get(iIndex) as RecipeContainer:Recipe:Builder
EndFunction

RecipeContainer:Recipe:Builder[] Function getBuilderData()
	return getData() as RecipeContainer:Recipe:Builder[]
EndFunction

Function updateBuilders()
	RecipeContainer:Recipe:Builder.updateBulk(getBuilderData())
EndFunction

Bool Function validate(Var avItem)
	return (avItem as RecipeContainer:Recipe:Builder) ; this doesn't need a validateData() call because the detailed state logic in a cross-plugin integrator will shut itself down if some data becomes bad
EndFunction

Bool Function add(Var avItem)
	RecipeContainer:Recipe:Builder builder = avItem as RecipeContainer:Recipe:Builder
	Bool bParentReturn = parent.add(avItem)
	
	if (bParentReturn && builder)
		builder.Start()
	endif
	
	return bParentReturn
EndFunction

Bool Function removeAt(Int iIndex)
	RecipeContainer:Recipe:Builder builder = getBuilder(iIndex)
	Bool bParentReturn = parent.removeAt(iIndex)
	
	if (bParentReturn && builder)
		builder.Stop()
	endif
	
	return bParentReturn
EndFunction

Function clear()
	while(getData().Length > 0)
		removeAt(0) ; because this script has additional events that fire when a removal happens and None-ing out the data isn't good enough by itself
	endWhile
	
	parent.clear()
EndFunction

Bool Function isRelevantToContainer(RecipeContainer:ContainerInstance containerRef)
	RecipeContainer:Recipe:Builder[] builders = getBuilderData()
	if (!builders || !containerRef)
		return false
	endif
	
	Int iCounter = 0
	while (iCounter < builders.Length)
		if (builders[iCounter] && builders[iCounter].isRelevantToContainer(containerRef))
			return true
		endif
		
		iCounter += 1
	endWhile
	
	return false
EndFunction

Function processContainerInstance(RecipeContainer:ContainerInstance containerRef)
	RecipeContainer:Recipe:Builder[] builders = getBuilderData()
	if (!builders || !containerRef)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < builders.Length)
		builders[iCounter] && builders[iCounter].processContainer(containerRef)
		iCounter += 1
	endWhile
EndFunction

Function updateBuildersBulk(RecipeContainer:Recipe:Builder:List[] builderLists) Global
	if (!builderLists || !builderLists.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < builderLists.Length)
		if (builderLists[iCounter])
			builderLists[iCounter].updateBuilders()
		endif
		
		iCounter += 1
	endWhile
EndFunction
