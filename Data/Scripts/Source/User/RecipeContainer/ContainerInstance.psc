Scriptname RecipeContainer:ContainerInstance extends ObjectReference
{Attach this script in the editor to a container record which is intended for placement in a cell - either as a standalone reference or through the workshop construction feature.
This script handles the reference-specific state and timer events and only these things.  The reason for focusing on just these tasks here is that this script will not request timer events
from the game engine unless there are contents which could be processed in the cycle to be requested.  Doing so means that there are fewer stresses put on the game than would otherwise be the case.
This involves some slight overhead involving multiple calls to instanceNeedsProcessing() on the container type object, but the bulk of these extraneous calls are expected to occur once before putting the script into the Waiting state.}

CustomEvent Processed

RecipeContainer:Logic Property ContainerType Auto Const Mandatory
{What sort of container this is.  See the RecipeContainer:Logic script for details.}
Int Property ProcessingTimerID = 1 Auto Const
{Used for tracking the process cycles on this script.}

String sStateWaiting = "Waiting" Const
String sStateProcessing = "Processing" Const

Bool Function isWaiting()
	return false
EndFunction

Function goToWaiting()
	GoToState(sStateWaiting)
EndFunction

Bool Function requiresPower()
	return GetValue(Game.GetFormFromFile(0x00000330, "Fallout4.esm") as ActorValue) > 0
EndFunction

Bool Function meetsPowerRequirements()
	return !requiresPower() || IsPowered()
EndFunction

Bool Function isProcessing()
	return false
EndFunction

Function goToProcessing()
	GoToState(sStateProcessing)
EndFunction

RecipeContainer:Logic Function getContainerType()
	return ContainerType
EndFunction

Bool Function needsProcessing()
	if (!meetsPowerRequirements())
		return false
	endif
	
	Bool bResult = getContainerType().canProcessContainerInstance(self)
	RecipeContainer:Logger:ContainerInstance.needsProcessing(self, bResult)
	return bResult
EndFunction

Function cancelThisCycle()
{Used in situations where the current cycle needs to stop for whatever reason, such as a loss of power event.}
	CancelTimerGameTime(ProcessingTimerID)
EndFunction

Function restartCycle()
{Another handy routine for processing things like object creation or a power state change.}
	cancelThisCycle()
	requestNextCycle()
EndFunction

Function examineState()
{This is the mechanism by which the container instance goes from a passive state to an actively monitored state should it be appropriate.}
	Bool bWaiting = isWaiting()
	Bool bNeedProcessing = needsProcessing()
	
	if (bWaiting && bNeedProcessing) ; if there is something to process but the container is not processing, begin to do so.
		goToProcessing()
	endif
	
	if (!bWaiting && !bNeedProcessing) ; if the container is processing but there is nothing to process, stop processing.  Doing so will only do a bunch of work for no reason before performing this check again to come to the same conclusion.
		goToWaiting()
	endif
EndFunction

Function requestNextCycle()
	
EndFunction

Function sendProcessedEvent()
	
EndFunction

Function postProcessing()
	sendProcessedEvent()
	requestNextCycle()
EndFunction

Event OnInit()
	RecipeContainer:Logger:ContainerInstance.initialization(self)
	AddInventoryEventFilter(None)
	examineState()
EndEvent

Event OnWorkshopObjectDestroyed(ObjectReference akActionRef)
	RecipeContainer:Logger:ContainerInstance.destruction(self)
	cancelThisCycle() ; there's no reference left to receive event updates - timers or otherwise - do be polite and tell the game engine to disregard any timer that may be in progress.
EndEvent

Event OnPowerOn(ObjectReference akGenerator)
{If power is applied, the container was previously warming.  Since it takes a certain number of hours to cool, that update needs to happen that number of hours from this event.}
	RecipeContainer:Logger:ContainerInstance.powerEvent(self)
	examineState()
EndEvent

Event OnPowerOff()
{See documentation for the power on event.  Ditto for previously cooling.  So many hours from this event, the next update needs to happen a cycle's worth of hours from now.}
	RecipeContainer:Logger:ContainerInstance.powerEvent(self)
	examineState()
EndEvent

Auto State Waiting
	Bool Function isWaiting()
		return true
	EndFunction
	
	Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
		examineState() ; doing this in the waiting state means that the first item added that causes a processing cycle is the only one to trigger the examination check, thus limiting the number of times that happens
	EndEvent
EndState

State Processing
	Event OnBeginState(String sPreviousState)
		requestNextCycle()
	EndEvent
	
	Bool Function isProcessing()
		return true
	EndFunction
	
	Event OnTimerGameTime(Int aiTimerID)
	{Event observer for timer updates from the game engine.  See requestNextCycle() and cancelThisCycle().  Note that this behavior only occurs in this state, so that timer events received in another state will just go away.  This is the desired behavior.}
		if (ProcessingTimerID == aiTimerID)
			RecipeContainer:Logger:ContainerInstance.logTimerEvent(self)
			getContainerType().processContainerInstance(self)
			postProcessing()
		endif
	EndEvent
	
	Function requestNextCycle()
	{When the container is anticipates the need to process contents, verify that doing so is appropriate at this time and if so, request a timer event for the next processing round.}
		if (getContainerType().canProcessContainerInstance(self))
			RecipeContainer:Logger:ContainerInstance.logStartTimer(self)
			StartTimerGameTime(getContainerType().getCycleHours(), ProcessingTimerID)
		else
			goToWaiting()
		endif
	EndFunction
	
	Function sendProcessedEvent()
		SendCustomEvent("Processed")
	EndFunction
EndState
