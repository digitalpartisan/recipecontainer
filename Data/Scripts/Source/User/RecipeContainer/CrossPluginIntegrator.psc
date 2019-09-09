Scriptname RecipeContainer:CrossPluginIntegrator extends Quest Hidden Conditional

InjectTec:Plugin[] Property Plugins Auto Const Mandatory
RecipeContainer:Recipe:Builder Property Builder Auto Const
InjectTec:Injector:Bulk Property Injections Auto Const

String sStateWaiting = "Waiting" Const
String sStateStarted = "Started" Const

Bool bHasRun = false Conditional

Bool Function hasRun()
{Legacy function needed to help retrofit older versions of this script to the right state.}
	return bHasRun
EndFunction

Function goToWaiting()
	GoToState(sStateWaiting)
EndFunction

Function goToStarted()
	GoToState(sStateStarted)
EndFunction

RecipeContainer:Logic:Local Function getContainerType()
{Override this method to implement a functional integrator according to your plugin's needs.}
	RecipeContainer:Logger:CrossPluginIntegrator.logNoGetContainerTypeImplementation(self)
	return None
EndFunction

Bool Function isPluginRequirementMet()
	return InjectTec:Plugin.isInstalledBulk(Plugins)
EndFunction

Function handleInjectionsBehavior(InjectTec:Injector:Bulk injectionTarget, Bool bForce = false)
	
EndFunction

Function handleInjections(Bool bForce = false)
	if (Injections)
		handleInjectionsBehavior(Injections, bForce)
	endif
EndFunction

Function handlerBuilderBehavior(RecipeContainer:Logic:Local containerTarget, RecipeContainer:Recipe:Builder builderToUse)
	
EndFunction

Function handleBuilder()
	if (!Builder)
		return
	endif
	
	RecipeContainer:Logic:Local myContainer = getContainerType()
	if (!myContainer)
		RecipeContainer:Logger:CrossPluginIntegrator.logContainerNotFound(self)
		return
	endif
	
	handlerBuilderBehavior(myContainer, Builder)
EndFunction

Function stateCheck()
	
EndFunction

Bool Function shouldStart()
	return false
EndFunction

Bool Function shouldStop()
	return false
EndFunction

Auto State Waiting
	Event OnBeginState(String asOldState)
		RecipeContainer:Logger:CrossPluginIntegrator.logStopping(self)
		
		bHasRun = false
		handleBuilder()
		handleInjections()
		
		RecipeContainer:Logger:CrossPluginIntegrator.logStopped(self)
	EndEvent
	
	Event OnQuestInit()
		goToStarted()
	EndEvent
	
	Function handlerBuilderBehavior(RecipeContainer:Logic:Local containerTarget, RecipeContainer:Recipe:Builder builderToUse)
		containerTarget.removeBuilder(builderToUse)
	EndFunction
	
	Function handleInjectionsBehavior(InjectTec:Injector:Bulk targetInjections, Bool bForce = false)
		targetInjections.revert(bForce)
	EndFunction
	
	Bool Function shouldStart()
		return isPluginRequirementMet()
	EndFunction
	
	Function stateCheck()
		if (shouldStart())
			Start()
		endif
	EndFunction
EndState

State Started
	Event OnBeginState(String asOldState)
		RecipeContainer:Logger:CrossPluginIntegrator.logStarting(self)
		
		if (!isPluginRequirementMet())
			RecipeContainer:Logger:CrossPluginIntegrator.logDoesNotMeetRequirements(self)
			Stop()
			return
		endif
		
		handleInjections()
		handleBuilder()
		bHasRun = true
		
		RecipeContainer:Logger:CrossPluginIntegrator.logStarted(self)
	EndEvent
	
	Event OnQuestShutdown()
		goToWaiting()
	EndEvent
	
	Function handlerBuilderBehavior(RecipeContainer:Logic:Local containerTarget, RecipeContainer:Recipe:Builder builderToUse)
		containerTarget.addBuilder(builderToUse)
	EndFunction
	
	Function handleInjectionsBehavior(InjectTec:Injector:Bulk targetInjections, Bool bForce = false)
		targetInjections.inject(bForce)
	EndFunction
	
	Bool Function shouldStop()
		return (!isPluginRequirementMet() || (Builder && !Builder.validateData()) )
	EndFunction
	
	Function stateCheck()
		if (shouldStop())
			Stop()
		endif
	EndFunction
EndState

Function stateCheckBulk(RecipeContainer:CrossPluginIntegrator[] integrators) Global
	if (!integrators || !integrators.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < integrators.Length)
		if (integrators[iCounter])
			integrators[iCounter].stateCheck()
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function stopBulk(RecipeContainer:CrossPluginIntegrator[] integrators, Bool bCheck = true) Global
	if (!integrators || !integrators.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < integrators.Length)
		if (integrators[iCounter])
			integrators[iCounter].Stop()
		endif
		
		iCounter += 1
	endWhile
EndFunction
