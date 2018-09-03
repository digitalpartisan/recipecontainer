Scriptname RecipeContainer:ContainerInstance extends ObjectReference
{Attach this script in the editor to a container record which is intended for placement in a cell - either as a standalone reference or through the workshop construction feature.
This script handles the reference-specific state and timer events and only these things.  The reason for focusing on just these tasks here is that this script will not request timer events
from the game engine unless there are contents which could be processed in the cycle to be requested.  Doing so means that there are fewer stresses put on the game than would otherwise be the case.
This involves some slight overhead involving multiple calls to instanceNeedsProcessing() on the container type object, but the bulk of these extraneous calls are expected to occur once before putting the script into the Waiting state.}

RecipeContainer:Logic Property ContainerType Auto Const Mandatory
{What sort of container this is.  See the RecipeContainer:Logic script for details.}
Bool Property PowerRequired = true Auto Const
{Setting this value to false will cause the container to cool regardless of whether or not it has power.  This is most appropriate for containers placed in a cell which is not part of a workshop.}
Int Property ProcessingTimerID = 1 Auto Const
{Used for tracking the process cycles on this script.}

String sStateWaiting = "Waiting" Const
String sStateProcessing = "Processing" Const

Bool Function isCooling()
{A container is said to cool its contents if it either does not require power or if it requires and has power.  Otherwise (i.e. if it lacks required power) it is in a warming cycle.}
	return !PowerRequired || IsPowered()
EndFunction

Bool Function needsProcessing()
	Bool bResult = ContainerType.instanceNeedsProcessing(self)
	RecipeContainer:Logger.logNeedsProcessing(self, bResult)
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

Function process()
	ContainerType.processInstance(self)
	requestNextCycle()
EndFunction

Function examineState()
{This is the mechanism by which the container instance goes from a passive state to an actively monitored state should it be appropriate.}
	Bool bWaiting = GetState() == sStateWaiting
	Bool bNeedProcessing = needsProcessing()
	
	if (bWaiting && bNeedProcessing) ; if there is something to process but the container is not processing, begin to do so.
		GoToState(sStateProcessing)
	endif
	
	if (!bWaiting && !bNeedProcessing) ; if the container is processing but there is nothing to process, stop processing.  Doing so will only do a bunch of work for no reason before performing this check again to come to the same conclusion.
		GoToState(sStateWaiting)
	endif
EndFunction

Event OnInit()
	RecipeContainer:Logger.logInit(self)
	AddInventoryEventFilter(None)
	examineState()
EndEvent

Event OnWorkshopObjectDestroyed(ObjectReference akActionRef)
	RecipeContainer:Logger.logDestruction(self)
	cancelThisCycle() ; there's no reference left to receive event updates - timers or otherwise - do be polite and tell the game engine to disregard any timer that may be in progress.
EndEvent

Event OnPowerOn(ObjectReference akGenerator)
{If power is applied, the container was previously warming.  Since it takes a certain number of hours to cool, that update needs to happen that number of hours from this event.}
	RecipeContainer:Logger.logPowerEvent(self)
	examineState()
EndEvent

Event OnPowerOff()
{See documentation for the power on event.  Ditto for previously cooling.  So many hours from this event, the next update needs to happen a cycle's worth of hours from now.}
	RecipeContainer:Logger.logPowerEvent(self)
	examineState()
EndEvent

Function requestNextCycle()
{Required to be defined here so that it exists as empty in every state unless specifically defined therein.}
EndFunction

Auto State Waiting
	Event OnBeginState(String sPreviousState)
		RecipeContainer:Logger.logState(self, sStateWaiting)
	EndEvent
	
	Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	{This entire script is designed to prevent requesting timer events and running through a container's contents against the container type's recipe list unless there's somethign to process.  When something is added to the container, reconsider whether or not processing is appropriate, but only if a processing cycle is not already in effect.}
		examineState() ; doing this only in a waiting state means that the item replacements made during processing will not trigger another examineState() call since it will be called at the end of processing
	EndEvent
EndState

State Processing
	Event OnBeginState(String sPreviousState)
		RecipeContainer:Logger.logState(self, sStateProcessing)
		requestNextCycle()
	EndEvent
	
	Function requestNextCycle()
	{When the container is anticipates the need to process contents, verify that doing so is appropriate at this time and if so, request a timer event for the next processing round.}
		if (ContainerType.instanceNeedsProcessing(self))
			StartTimerGameTime(ContainerType.CycleHours, ProcessingTimerID)
		else
			GoToState(sStateWaiting)
		endif
	EndFunction
	
	Event OnTimerGameTime(Int aiTimerID)
	{Event observer for timer updates from the game engine.  See requestNextCycle() and cancelThisCycle().  Note that this behavior only occurs in this state, so that timer events received in another state will just go away.  This is the desired behavior.}
		if (ProcessingTimerID == aiTimerID)
			process()
		endif
	EndEvent
EndState
