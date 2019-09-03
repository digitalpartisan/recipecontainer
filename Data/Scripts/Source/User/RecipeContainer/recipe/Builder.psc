Scriptname RecipeContainer:Recipe:Builder extends RecipeContainer:Utility:Recipe:UpdateableList Hidden Conditional

Import RecipeContainer:Utility:Recipe
Import RecipeContainer:Utility:Processing

Struct RemoteRecipeDefinition
	Potion UnprocessedForm = None
	Int UnprocessedID = 0
	Potion ProcessedForm = None
	Int ProcessedID = 0
EndStruct

RemoteRecipeDefinition[] Property RecipeDefinitions = None Auto Const

String sStateWaiting = "Waiting" Const
String sStateBuilt = "Built" Const

Bool bHasRun = false Conditional ; useful for allowing various game systems to tell whether or not this builder has run

Function goToWaiting()
	GoToState(sStateWaiting)
EndFunction

Function goToBuilt()
	GoToState(sStateBuilt)
EndFunction

Bool Function getHasRun() ; legacy ; artifact required to determine if an in-upgrade builder has run so that it can be put into the appropriate state
	return bHasRun
EndFunction

Bool Function hasBuilt()
	return false
EndFunction

Bool Function customCouldBuildLogic()
	return true
EndFunction

Bool Function couldBuild()
	return false
EndFunction

Bool Function validate(Var avItem)
	return validate(avItem as SimpleRecipe)
EndFunction

Bool Function validateForCleaning()
	return false
EndFunction

Bool Function clean()
	return false ; so that this can be overridden in states on this script without compiler errors
EndFunction

SimpleRecipe[] Function getRecipes()
	return None ; so that this can be overridden in states on this script without compiler errors
EndFunction

Function refreshProcessPatterns()
	
EndFunction

ProcessPattern[] Function getProcessPatterns(Bool bForward = true)
	return None
EndFunction

Auto State Waiting
	Event OnBeginState(String asOldState)
		if (sStateBuilt == asOldState)
			clear()
			bHasRun = false
		endif
	EndEvent
	
	Event OnQuestInit()
		goToBuilt()
	EndEvent
	
	Bool Function validate(Var avItem)
		return false
	EndFunction
	
	Bool Function couldBuild()
		return customCouldBuildLogic()
	EndFunction
	
	Bool Function validateForCleaning()
		return couldBuild()
	EndFunction
	
	Function populate()
		
	EndFunction
	
	Function update()
		
	EndFunction
	
	Bool Function clean()
		return false
	EndFunction
EndState

State Built
	Event OnBeginState(String asOldState)
		if (customCouldBuildLogic()) ; because couldBuild() is used to determine whether or not the script can enter this state while customCouldBuildLogic() determines the feasibility of building recipes
			bHasRun = true
			update() ; as opposed to populate() because update() will trigger an updated event
		else
			goToWaiting()
		endif
	EndEvent
	
	Event OnQuestShutdown()
		goToWaiting()
	EndEvent
	
	Bool Function validate(Var avItem)
		return validate(avItem as SimpleRecipe)
	EndFunction
	
	Bool Function validateForCleaning()
		return customCouldBuildLogic()
	EndFunction
	
	SimpleRecipe[] Function getRecipes()
		return getData() as SimpleRecipe[]
	EndFunction
	
	Bool Function hasBuilt()
		return true
	EndFunction
EndState
