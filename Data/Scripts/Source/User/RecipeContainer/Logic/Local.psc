Scriptname RecipeContainer:Logic:Local extends RecipeContainer:Logic

Float Property CycleHours = 1.0 Auto Const
RecipeContainer:Recipe:Builder[] Property MyBuilders Auto Const Mandatory
RecipeContainer:Logic:ProcessingData Property ProcessingData Auto Const Mandatory
RecipeContainer:Recipe:Builder:List Property BuilderList Auto Const Mandatory

RecipeContainer:Logic:ProcessingData Function getProcessingData()
	return ProcessingData
EndFunction

Float Function getCycleHours()
	return CycleHours
EndFunction

Bool Function canProcessHelper(RecipeContainer:ContainerInstance akContainerRef)
	return getProcessingData().canProcessContainerInstance(akContainerRef)
EndFunction

Function processHelper(RecipeContainer:ContainerInstance akContainerRef)
	getProcessingData().processContainerInstance(akContainerRef)
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
	getProcessingData().Start()

	if (MyBuilders)
		Int iCounter = 0
		while (iCounter < MyBuilders.Length)
			addBuilder(MyBuilders[iCounter])
			iCounter += 1
		endWhile
	endif
EndFunction

Function shutdownHelper()
	getProcessingData().Stop()
	BuilderList.clear()
EndFunction
