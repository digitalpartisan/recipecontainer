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
	return false
EndFunction

Bool Function clean()
	return false ; so that this can be overridden in states on this script without compiler errors
EndFunction

SimpleRecipe[] Function getRecipes()
	return None ; so that this can be overridden in states on this script without compiler errors
EndFunction

Bool Function isRelevantToContainer(RecipeContainer:ContainerInstance containerInstance)
	return false
EndFunction

Function processContainer(RecipeContainer:ContainerInstance containerInstance)
	
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
		return RecipeContainer:Utility:Recipe.validate(avItem as SimpleRecipe) ; don't call this class' validate() method or else its always comes back false because a boolean is not a SimpleRecipe
	EndFunction
	
	SimpleRecipe[] Function getRecipes()
		return getData() as SimpleRecipe[]
	EndFunction
	
	Bool Function isRelevantToContainer(RecipeContainer:ContainerInstance containerInstance)
		SimpleRecipe[] recipes = getRecipes()
		if (!recipes || !recipes.Length || !containerInstance)
			return false
		endif
		
		Int iCounter = 0
		while (iCounter < recipes.Length)
			if (recipes[iCounter] && recipes[iCounter].unprocessed && containerInstance.GetItemCount(recipes[iCounter].unprocessed))
				return true
			endif
			
			iCounter += 1
		endWhile
		
		return false
	EndFunction
	
	Function processContainer(RecipeContainer:ContainerInstance containerInstance)
		SimpleRecipe[] recipes = getRecipes()
		if (!recipes || !recipes.Length || !containerInstance)
			return
		endif
		
		Int iCounter = 0
		while (iCounter < recipes.Length)
			process(recipes[iCounter], containerInstance)
			iCounter += 1
		endWhile
	EndFunction
EndState

Function updateBulk(RecipeContainer:Recipe:Builder[] builders) Global
	if (!builders || !builders.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < builders.Length)
		builders[iCounter] && builders[iCounter].update()
		iCounter += 1
	endWhile
EndFunction
