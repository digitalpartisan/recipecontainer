Scriptname RecipeContainer:Logic:Remote extends RecipeContainer:Logic

Import InjectTec:Utility:HexidecimalLogic

InjectTec:Plugin Property TargetPlugin Auto Const Mandatory
DigitSet Property TargetDigits Auto Const Mandatory

RecipeContainer:Logic:Local remoteContainerType = None

RecipeContainer:Logic:Local Function lookupRemoteContainerType()
	if (!TargetPlugin || !TargetDigits)
		RecipeContainer:Logger:Logic.remoteNotLoaded(self)
		return None
	endif
	
	RecipeContainer:Logic:Local remoteLogic = TargetPlugin.lookupWithDigits(TargetDigits) as RecipeContainer:Logic:Local
	if (remoteLogic)
		RecipeContainer:Logger:Logic.remoteLoaded(self, remoteLogic)
		return remoteLogic
	endif
	
	RecipeContainer:Logger:Logic.remoteNotLoaded(self)
	return None
EndFunction

Function setRemoteContainerType(RecipeContainer:Logic:Local newValue)
	remoteContainerType = newValue
EndFunction

Function refresh()
	setRemoteContainerType(lookupRemoteContainerType())
EndFunction

RecipeContainer:Logic:Local Function getRemoteContainerType()
	!remoteContainerType && refresh() ; could change the vaule of remoteContainerType
	!remoteContainerType && RecipeContainer:Logger:Logic.logRemoteNotFound(self)
	
	return remoteContainerType
EndFunction

Float Function getCycleHours()
	RecipeContainer:Logic:Local remoteContainer = getRemoteContainerType()
	if (remoteContainer)
		return remoteContainer.getCycleHours()
	endif
	
	return parent.getCycleHours()
EndFunction

Bool Function canProcessHelper(RecipeContainer:ContainerInstance akContainerRef)
	RecipeContainer:Logic:Local remoteContainer = getRemoteContainerType()
	if (remoteContainer)
		return remoteContainer.canProcessContainerInstance(akContainerRef)
	endif
	
	return false
EndFunction

Function processHelper(RecipeContainer:ContainerInstance akContainerRef)
	RecipeContainer:Logic:Local remoteContainer = getRemoteContainerType()
	remoteContainer && remoteContainer.processContainerInstance(akContainerRef)
EndFunction

Function readyHelper()
	refresh()
EndFunction

Function shutdownHelper()
	setRemoteContainerType(None)
EndFunction

Function dumpToContainer(ObjectReference akTargetRef, Int iAmount = 1)
	RecipeContainer:Logic:Local remoteContainer = getRemoteContainerType()
	remoteContainer && remoteContainer.dumpToContainer(akTargetRef, iAmount)
EndFunction
