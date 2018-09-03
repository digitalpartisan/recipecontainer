Scriptname RecipeContainer:RemoteContainer extends Quest

InjectTec:Plugin Property TargetPlugin Auto Const Mandatory
Int Property TargetID Auto Const Mandatory

RecipeContainer:Logic Function lookup()
	if (!TargetPlugin.isInstalled())
		return None
	endif
	
	Form target = TargetPlugin.lookupForm(TargetID)
	return target as RecipeContainer:Logic
EndFunction
