Scriptname RecipeContainer:Logic:Local extends RecipeContainer:Logic

Import RecipeContainer:Utility:Processing

Float Property CycleHours = 3.0 Auto Const
RecipeContainer:Recipe:Builder[] Property MyBuilders Auto Const Mandatory
RecipeContainer:Logic:ProcessingData Property ProcessingData Auto Const Mandatory
RecipeContainer:Recipe:Builder:List Property BuilderList Auto Const Mandatory

Float Function getCycleHours()
	return CycleHours
EndFunction

Bool Function canProcessHelper(RecipeContainer:ContainerInstance akContainerRef)
	return ProcessingData.canProcessContainerInstance(akContainerRef)
EndFunction

Function processHelper(RecipeContainer:ContainerInstance akContainerRef)
	if (canProcessContainerInstance(akContainerRef))
		processReference(akContainerRef, ProcessingData.getPatternsForContainerInstance(akContainerRef))
	endif
EndFunction

Function rebuildRecipesHelper()
	ProcessingData.rebuild(BuilderList)
EndFunction

Function cleanHelper()
	RecipeContainer:Logger.logCleaning(self)
	BuilderList.clean()
EndFunction

Function addBuilder(RecipeContainer:Recipe:Builder builder)
	BuilderList.add(builder)
EndFunction

Function removeBuilder(RecipeContainer:Recipe:Builder builder)
	BuilderList.remove(builder)
EndFunction

Function readyHelper()
	RegisterForCustomEvent(BuilderList, "RebuildRequired")
	
	if (!MyBuilders)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < MyBuilders.Length)
		addBuilder(MyBuilders[iCounter])
		iCounter += 1
	endWhile
EndFunction

Function shutdownHelper()
	UnregisterForCustomEvent(BuilderList, "RebuildRequired")
	BuilderList.clear()
EndFunction

Event RecipeContainer:Recipe:Builder:List.RebuildRequired(RecipeContainer:Recipe:Builder:List akSender, Var[] akArgs)
	if (BuilderList == akSender)
		rebuildProcessingData()
	endif
EndEvent
