Scriptname RecipeContainer:Logic:Remote extends Quest

Import InjectTec:Utility:HexidecimalLogic

InjectTec:Plugin Property TargetPlugin Auto Const Mandatory
Int Property TargetID Auto Const
DigitSet Property TargetDigits Auto Const Mandatory

RecipeContainer:Logic Function lookup()
	return InjectTec:Plugin.fetchFromDigits(TargetPlugin, TargetDigits) as RecipeContainer:Logic
EndFunction

Bool Function canProcessInstance(RecipeContainer:ContainerInstance akContainerRef)
	RecipeContainer:Logic remoteLogic = lookup()
	if (remoteLogic)
		return remoteLogic.canProcessInstance(akContainerRef)
	endif
	
	return false
EndFunction

Function processInstance(RecipeContainer:ContainerInstance akContainerRef)
	RecipeContainer:Logic remoteLogic = lookup()
	if (remoteLogic)
		remoteLogic.processInstance(akContainerRef)
	endif
EndFunction
