Scriptname RecipeContainer:Logic:ProcessingData extends Quest

Import RecipeContainer:Utility:Processing
Import RecipeContainer:Utility:Recipe

Group ProcessingSets
	RecipeContainer:Logic:ProcessingData:Set:Forward Property ForwardSet Auto Const Mandatory
	RecipeContainer:Logic:ProcessingData:Set:Reverse Property ReverseSet Auto Const Mandatory
EndGroup

RecipeContainer:ContainerInstance:Queue Property ContainerInstanceQueue Auto Const Mandatory

String sStatePreStart = "PreStart" Const
String sStateWaiting = "Waiting" Const
String sStateUpdating = "Updating" Const
String sStateProcessing = "Processing" Const
String sStateShutdown = "Shutdown" Const

RecipeContainer:Recipe:Builder:List updateList = None

Bool Function isUpdateReady()
	return getUpdateList() as Bool
EndFunction

RecipeContainer:Recipe:Builder:List Function getUpdateList()
	return updateList
EndFunction

Function clearUpdateData()
	updateList = None
EndFunction

Function setUpdateList(RecipeContainer:Recipe:Builder:List builders)
	if (builders)
		updateList = builders
	else
		clearUpdateData()
	endif
EndFunction

Function update(RecipeContainer:Recipe:Builder:List builders)
	setUpdateList(builders)
EndFunction

Function goToPreStart()
	GoToState(sStatePreStart)
EndFunction

Function goToWaiting()
	GoToState(sStateWaiting)
EndFunction

Function goToUpdating()
	GoToState(sStateUpdating)
EndFunction

Function goToProcessing()
	GoToState(sStateProcessing)
EndFunction

Function goToShutdown()
	GoToState(sStateShutdown)
EndFunction

Function consumeRecipe(SimpleRecipe recipeData)
	if (!RecipeContainer:Utility:Recipe.validate(recipeData))
		return
	endif
	
	ProcessPattern newPattern = RecipeContainer:Utility:Processing.create(recipeData)
	ForwardSet.add(newPattern)
	ReverseSet.add(newPattern)
EndFunction

Function consumeBuilder(RecipeContainer:Recipe:Builder builder)
	if (!builder)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < builder.getSize())
		consumeRecipe(builder.getRecipe(iCounter))
		iCounter += 1
	endWhile
EndFunction

Function rebuild(RecipeContainer:Recipe:Builder:List builderList)
	ForwardSet.clear()
	ReverseSet.clear()
	
	if (!builderList)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < builderList.getSize())
		consumeBuilder(builderList.getBuilder(iCounter))
		iCounter += 1
	endWhile
EndFunction

RecipeContainer:Logic:ProcessingData:Set Function getDataSetForContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	if (!akContainerRef)
		return None
	endif
	
	if (akContainerRef.isProcessing())
		return ForwardSet
	endif
	
	return ReverseSet
EndFunction

Bool Function canProcessContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	RecipeContainer:Logic:ProcessingData:Set theSet = getDataSetForContainerInstance(akContainerRef)
	
	if (theSet)
		return theSet.canProcessContainerInstance(akContainerRef)
	endif
	
	return false
EndFunction

ProcessPattern[] Function getPatternsForContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	RecipeContainer:Logic:ProcessingData:Set theSet = getDataSetForContainerInstance(akContainerRef)
	
	if (theSet)
		return theSet.getProcessPatternData()
	endif
	
	return None
EndFunction

Bool Function queueContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	return canProcessContainerInstance(akContainerRef) && ContainerInstanceQueue.add(akContainerRef)
EndFunction

Function processContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	
EndFunction

Event OnQuestShutdown()
	goToShutdown()
EndEvent

Auto State PreStart
	Event OnQuestInit()
		goToWaiting()
	EndEvent
	
	Event OnQuestShutdown()
	
	EndEvent
	
	Bool Function canProcessContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		return false
	EndFunction
EndState

State Waiting
	Event OnBeginState(String asOldState)
		if (isUpdateReady())
			goToUpdating()
			return
		endif
		
		if (ContainerInstanceQueue.hasData())
			goToProcessing()
			return
		endif
	EndEvent
	
	Function update(RecipeContainer:Recipe:Builder:List builders)
		setUpdateList(builders)
		goToUpdating()
	EndFunction
	
	Function processContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		if (queueContainerInstance(akContainerRef))
			goToProcessing()
		endif
	EndFunction
EndState

State Updating
	Event OnBeginState(String asOldState)
		if (isUpdateReady())
			rebuild(getUpdateList())
		endif
		
		clearUpdateData()
		goToWaiting()
	EndEvent
	
	Bool Function canProcessContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		return true ; because we can't tell for sure at this juncture and the "can process" check will occur during processing anyway
	EndFunction
	
	Function processContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		queueContainerInstance(akContainerRef)
	EndFunction
EndState

State Processing
	Event OnBeginState(String asOldState)
		RecipeContainer:ContainerInstance containerRef = ContainerInstanceQueue.pollContainerInstance()
		if (containerRef && canProcessContainerInstance(containerRef))
			containerRef.processPatterns(getPatternsForContainerInstance(containerRef))
		endif
		
		goToWaiting()
	EndEvent
	
	Function processContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		queueContainerInstance(akContainerRef)
	EndFunction
EndState

State Shutdown
	Event OnBeginState(String asOldState)
		clearUpdateData()
	EndEvent
	
	Event OnQuestShutdown()
	
	EndEvent
	
	Function update(RecipeContainer:Recipe:Builder:List builders)
		
	EndFunction
	
	Bool Function canProcessContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		return false
	EndFunction
EndState
