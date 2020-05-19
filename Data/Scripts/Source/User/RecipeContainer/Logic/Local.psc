Scriptname RecipeContainer:Logic:Local extends RecipeContainer:Logic

Float Property CycleHours = 1.0 Auto Const
RecipeContainer:Recipe:Builder[] Property MyBuilders Auto Const
RecipeContainer:Logic:ProcessingData Property ProcessingData Auto Const Mandatory
RecipeContainer:Recipe:Builder:List Property BuilderList Auto Const Mandatory

RecipeContainer:Logic:ProcessingData Function getProcessingData()
	return ProcessingData
EndFunction

Float Function getCycleHours()
	return CycleHours
EndFunction

RecipeContainer:Recipe:Builder:List Function getBuilderList()
	return BuilderList
EndFunction

RecipeContainer:Recipe:Builder[] Function getMyBuilders()
	return MyBuilders
EndFunction

Bool Function canProcessHelper(RecipeContainer:ContainerInstance akContainerRef)
	return getProcessingData().canProcessContainerInstance(akContainerRef)
EndFunction

Function processHelper(RecipeContainer:ContainerInstance akContainerRef)
	getProcessingData().processContainerInstance(akContainerRef)
EndFunction

Function cleanHelper()
	RecipeContainer:Logger.logCleaning(self)
	getBuilderList().clean()
EndFunction

Function addBuilder(RecipeContainer:Recipe:Builder builder)
	getBuilderList().add(builder)
EndFunction

Function addBuilders(RecipeContainer:Recipe:Builder[] builders)
	getBuilderList().addBulk(builders as Var[])
EndFunction

Function addMyBuilders()
	addBuilders(getMyBuilders())
EndFunction

Function removeBuilder(RecipeContainer:Recipe:Builder builder)
	getBuilderList().remove(builder)
EndFunction

Function removeBuilders(RecipeContainer:Recipe:Builder[] builders)
	getBuilderList().removeBulk(builders as Var[])
EndFunction

Function readyHelper()
	getProcessingData().Start()
	addMyBuilders()
EndFunction

Function shutdownHelper()
	getProcessingData().Stop()
	getBuilderList().clear()
EndFunction

Function dumpToContainer(ObjectReference akTargetRef, Int iAmount = 1)
	if (!akTargetRef || iAmount < 1)
		return
	endif
	
	getBuilderList().dumpToContainer(akTargetRef, iAmount)
EndFunction
