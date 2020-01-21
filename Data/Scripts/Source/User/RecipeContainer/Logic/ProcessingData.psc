Scriptname RecipeContainer:Logic:ProcessingData extends Quest

Import RecipeContainer:Utility:Recipe

RecipeContainer:ContainerInstance:Queue Property ContainerInstanceQueue Auto Const Mandatory
RecipeContainer:Recipe:Builder:List Property BuilderList Auto Const Mandatory

String sStatePreStart = "PreStart" Const
String sStateWaiting = "Waiting" Const
String sStateProcessing = "Processing" Const
String sStateShutdown = "Shutdown" Const

Function goToPreStart()
	GoToState(sStatePreStart)
EndFunction

Function goToWaiting()
	GoToState(sStateWaiting)
EndFunction

Function goToProcessing()
	GoToState(sStateProcessing)
EndFunction

Function goToShutdown()
	GoToState(sStateShutdown)
EndFunction

Bool Function canProcessContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	return BuilderList.isRelevantToContainer(akContainerRef)
EndFunction

Bool Function queueContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	return canProcessContainerInstance(akContainerRef) && ContainerInstanceQueue.add(akContainerRef)
EndFunction

Function processContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	BuilderList.processContainerInstance(akContainerRef)
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
	
	Function processContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
	
	EndFunction
EndState

State Waiting
	Event OnBeginState(String asOldState)
		ContainerInstanceQueue.hasData() && goToProcessing()
	EndEvent
	
	Function processContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		queueContainerInstance(akContainerRef) && goToProcessing()
	EndFunction
EndState

State Processing
	Event OnBeginState(String asOldState)
		RecipeContainer:ContainerInstance containerRef = ContainerInstanceQueue.pollContainerInstance()
		containerRef && canProcessContainerInstance(containerRef) && containerRef.processBuilders(BuilderList)
		goToWaiting()
	EndEvent
	
	Function processContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		queueContainerInstance(akContainerRef)
	EndFunction
EndState

State Shutdown
	Event OnQuestShutdown()
	
	EndEvent
	
	Bool Function canProcessContainerInstance(RecipeContainer:ContainerInstance akContainerRef)
		return false
	EndFunction
EndState
