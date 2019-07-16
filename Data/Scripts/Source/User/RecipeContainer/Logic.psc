Scriptname RecipeContainer:Logic extends Quest
{Attach this script in the editor to define a type of container (ex. a "fridge") to specify how long the container takes to work and what recipes the type of container can put into effect.
Because of the use of drinking buddy recipes elsewhere in the game, this library makes use of them, though without the issue of whether or not the player has found a holotape for each recipe.
This decision was made largely because of the volume of existing recipes in the game files already which means this library can make use of them.
This functionality is here and not handled by the container instance script because doing so centralizes access to recipe options and removes anything not specifically required to determine the state of any particular container, which simplifies the container instance script.}

Import DialogueDrinkingBuddyScript
Import RecipeContainer:Utility:Processing

Float Property CycleHours = 3.0 Auto Const
{The number of in-game hours required to either cool drinks or cause them to become warm}
RecipeContainer:Recipe:Builder Property MyBuilder Auto Const
BrewingRecipe[] Property CustomRecipes Auto
{The recipes specific to this type of container will use to process contents.}
RecipeContainer:Logic:Remote Property RemoteContainer Auto
FormList Property ProcessingForms Auto Const Mandatory
FormList Property ReverseProcessingForms Auto Const Mandatory

BrewingRecipe[] builtRecipes = None
ProcessPattern[] processingPatterns = None
ProcessPattern[] reverseProcessingPatterns = None

Function buildRecipes()
	if (!builtRecipes)
		builtRecipes = new BrewingRecipe[0]
	endif
	builtRecipes.Clear() ; in case the variable was already set
	
	ingestBuilder(MyBuilder)
	rebuildProcessingData()
EndFunction	

BrewingRecipe[] Function getRecipes()
	return builtRecipes
EndFunction

Function setRecipes(BrewingRecipe[] recipes)
	builtRecipes = recipes
EndFunction

Function augmentRecipes(BrewingRecipe[] recipes)
	setRecipes(Jiffy:Utility:Array.union(getRecipes() as Var[], recipes as Var[]) as BrewingRecipe[])
EndFunction

Function ingestBuilder(RecipeContainer:Recipe:Builder builder)
	if (!builder)
		return
	endif
	
	augmentRecipes(builder.buildRecipes())
EndFunction

Float Function getCycleHours()
	return CycleHours
EndFunction

Function rebuildProcessingData()
	BrewingRecipe[] myRecipes = getRecipes()
	
	ProcessingForms.Revert()
	if (!processingPatterns)
		processingPatterns = new ProcessPattern[0]
	endif
	processingPatterns.Clear()
	
	ReverseProcessingForms.Revert()
	if (!reverseProcessingPatterns)
		reverseProcessingPatterns = new ProcessPattern[0]
	endif
	reverseProcessingPatterns.Clear()
	
	if (!myRecipes || !myRecipes.Length)
		return
	endif
	
	Int iCounter = 0
	ProcessPattern newPattern = None
	ProcessPattern newReversal = None
	while (iCounter < myRecipes.Length)
		newPattern = RecipeContainer:Utility:Processing.create(myRecipes[iCounter])
		newReversal = reverse(newPattern)
		
		if (newPattern && newReversal)
			processingPatterns.Add(newPattern)
			ProcessingForms.AddForm(newPattern.search)
			
			reverseProcessingPatterns.Add(newReversal)
			ReverseProcessingForms.AddForm(newReversal.search)
		endif
		
		iCounter += 1
	endWhile
EndFunction

FormList Function getSearchFormsForInstance(RecipeContainer:ContainerInstance akContainerRef)
	if (!akContainerRef)
		return None
	endif
	
	if (akContainerRef.isProcessing())
		return ProcessingForms
	endif
	
	return ReverseProcessingForms
EndFunction

ProcessPattern[] Function getProcessPatternsForInstance(RecipeContainer:ContainerInstance akContainerRef)
	if (!akContainerRef)
		return None
	endif
	
	if (akContainerRef.isProcessing())
		return processingPatterns
	endif
	
	return reverseProcessingPatterns
EndFunction

Bool Function canProcessInstance(RecipeContainer:ContainerInstance akContainerRef)
	if (RemoteContainer)
		return RemoteContainer.canProcessInstance(akContainerRef)
	endif
	
	return akContainerRef.GetItemCount(getSearchFormsForInstance(akContainerRef))
EndFunction

Function processInstance(RecipeContainer:ContainerInstance akContainerRef)
	if (RemoteContainer)
		RemoteContainer.processInstance(akContainerRef)
		return
	endif
	
	RecipeContainer:Logger.logCycle(akContainerRef)
	RecipeContainer:Utility:Processing.processReference(akContainerRef, getProcessPatternsForInstance(akContainerRef))
EndFunction

Function clean()
	RecipeContainer:Logger.logCleaning(self)
	if (RecipeContainer:Utility:Recipe.clean(getRecipes()))
		rebuildProcessingData()
	endif
EndFunction

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
