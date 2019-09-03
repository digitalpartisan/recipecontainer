Scriptname RecipeContainer:Logic extends Quest Hidden
{Attach this script in the editor to define a type of container (ex. a "fridge") to specify how long the container takes to work and what recipes the type of container can put into effect.
Because of the use of drinking buddy recipes elsewhere in the game, this library makes use of them, though without the issue of whether or not the player has found a holotape for each recipe.
This decision was made largely because of the volume of existing recipes in the game files already which means this library can make use of them.
This functionality is here and not handled by the container instance script because doing so centralizes access to recipe options and removes anything not specifically required to determine the state of any particular container, which simplifies the container instance script.}

Import DialogueDrinkingBuddyScript

BrewingRecipe[] Property CustomRecipes Auto

Float Function getCycleHours()
	return 1
EndFunction

Function rebuildRecipesHelper()
	
EndFunction

Function rebuildProcessingData()
	
EndFunction

Bool Function canProcessHelper(RecipeContainer:ContainerInstance akContainerRef)
	
EndFunction

Bool Function canProcessContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	return false
EndFunction

Function processHelper(RecipeContainer:ContainerInstance akContainerRef)
	
EndFunction

Function processContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	
EndFunction

Function cleanHelper()

EndFunction

Function clean()
	
EndFunction

Function addBuilder(RecipeContainer:Recipe:Builder builder)
	
EndFunction

Function removeBuilder(RecipeContainer:Recipe:Builder builder)
	
EndFunction

Function listenForRecipeUpdates()
	
EndFunction

Function stopListeningForRecipeUpdates()

EndFunction

Function addMyBuilders()
	
EndFunction

Function readyHelper()

EndFunction

Function shutdownHelper()

EndFunction

Auto State Waiting
	Event OnQuestInit()
		GoToState("Ready")
	EndEvent
EndState

State Ready
	Event OnBeginState(String asOldState)
		readyHelper()
	EndEvent
	
	Event OnQuestShutdown()
		GoToState("Shutdown")
	EndEvent
	
	Function rebuildProcessingData()
		rebuildRecipesHelper()
	EndFunction
	
	Bool Function canProcessContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		return canProcessHelper(akContainerRef)
	EndFunction
	
	Function processContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		processHelper(akContainerRef)
	EndFunction
	
	Function clean()
		cleanHelper()
	EndFunction
EndState

State Shutdown
	Event OnBeginState(String asOldState)
		shutdownHelper()
	EndEvent
EndState

Function cleanBulk(RecipeContainer:Logic[] containerTypes) Global
	if (!containerTypes || !containerTypes.Length)
		return
	endif
	
	Int iCounter = 0
	RecipeContainer:Logic currentType = None
	while (iCounter < containerTypes.Length)
		currentType = containerTypes[iCounter]
		if (currentType)
			currentType.clean()
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function startBulk(RecipeContainer:Logic[] containerTypes) Global
	if (!containerTypes || !containerTypes.Length)
		return
	endif
	
	Int iCounter = 0
	RecipeContainer:Logic currentType = None
	while (iCounter < containerTypes.Length)
		currentType = containerTypes[iCounter]
		if (currentType)
			currentType.Start()
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function stopBulk(RecipeContainer:Logic[] containerTypes) Global
	if (!containerTypes || !containerTypes.Length)
		return
	endif
	
	Int iCounter = 0
	RecipeContainer:Logic currentType = None
	while (iCounter < containerTypes.Length)
		currentType = containerTypes[iCounter]
		if (currentType)
			currentType.Stop()
		endif
		
		iCounter += 1
	endWhile
EndFunction
