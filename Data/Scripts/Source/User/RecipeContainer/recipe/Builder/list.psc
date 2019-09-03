Scriptname RecipeContainer:Recipe:Builder:List extends Jiffy:List

CustomEvent RebuildRequired

Function sendRebuildRequired()
	SendCustomEvent("RebuildRequired")
EndFunction

Function listenForUpdates(RecipeContainer:Recipe:Builder builder)
	RegisterForCustomEvent(builder, "Updated")
EndFunction

Function stopListeningForUpdates(RecipeContainer:Recipe:Builder builder)
	UnregisterForCustomEvent(builder, "Updated")
EndFunction

Event Jiffy:List:Updateable.Updated(Jiffy:List:Updateable akSender, Var[] akVargs)
	sendRebuildRequired()
EndEvent

Bool Function equalityCheck(Var avItemOne, Var avItemTwo)
	return (avItemOne as RecipeContainer:Recipe:Builder) == (avItemTwo as RecipeContainer:Recipe:Builder)
EndFunction

RecipeContainer:Recipe:Builder Function getBuilder(Int iIndex)
	return get(iIndex) as RecipeContainer:Recipe:Builder
EndFunction

RecipeContainer:Recipe:Builder[] Function getBuilderData()
	return getData() as RecipeContainer:Recipe:Builder[]
EndFunction

Bool Function validate(Var avItem)
	RecipeContainer:Recipe:Builder builder = avItem as RecipeContainer:Recipe:Builder
	return (builder && builder.validateForCleaning())
EndFunction

Bool Function add(Var avItem)
	RecipeContainer:Recipe:Builder builder = avItem as RecipeContainer:Recipe:Builder
	Bool bParentReturn = parent.add(avItem)
	
	if (bParentReturn && builder)
		listenForUpdates(builder)
		builder.Start()
	endif
	
	return bParentReturn
EndFunction

Bool Function removeAt(Int iIndex)
	RecipeContainer:Recipe:Builder builder = getBuilder(iIndex)
	Bool bParentReturn = parent.removeAt(iIndex)
	
	if (bParentReturn && builder)
		stopListeningForUpdates(builder)
		builder.Stop()
		sendRebuildRequired()
	endif
	
	return bParentReturn
EndFunction

Function clear()
	while(getData().Length > 0)
		removeAt(0)
	endWhile
	
	parent.clear()
EndFunction
