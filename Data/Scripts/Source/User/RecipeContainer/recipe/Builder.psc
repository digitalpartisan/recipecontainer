Scriptname RecipeContainer:Recipe:Builder extends RecipeContainer:Utility:Recipe:UpdateableList Hidden Conditional

Import RecipeContainer:Utility:Recipe

String sStateWaiting = "Waiting" Const
String sStateBuilt = "Built" Const

Function goToWaiting()
	GoToState(sStateWaiting)
EndFunction

Function goToBuilt()
	GoToState(sStateBuilt)
EndFunction

Bool Function validate(Var avItem)
	return validate(avItem as SimpleRecipe)
EndFunction

Bool Function clean()
	return false ; so that this can be overridden in states on this script without compiler errors
EndFunction

SimpleRecipe[] Function getRecipes()
	return None ; so that this can be overridden in states on this script without compiler errors
EndFunction

Auto State Waiting
	Event OnBeginState(String asOldState)
		if (sStateBuilt == asOldState)
			clear()
		endif
	EndEvent
	
	Event OnQuestInit()
		goToBuilt()
	EndEvent
	
	Bool Function validate(Var avItem)
		return false
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
		update() ; as opposed to populate() because update() will trigger an updated event
	EndEvent
	
	Event OnQuestShutdown()
		goToWaiting()
	EndEvent
	
	Bool Function validate(Var avItem)
		return validate(avItem as SimpleRecipe)
	EndFunction
	
	SimpleRecipe[] Function getRecipes()
		return getData() as SimpleRecipe[]
	EndFunction
EndState

Function updateBulk(RecipeContainer:Recipe:Builder[] builders) Global
	if (!builders || !builders.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < builders.Length)
		if (builders[iCounter])
			builders[iCounter].update()
		endif
		
		iCounter += 1
	endWhile
EndFunction
