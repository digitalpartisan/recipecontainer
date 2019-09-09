Scriptname RecipeContainer:CrossPluginIntegrator:Handler extends DynamicTerminal:Basic Conditional

Message Property InvalidOptionMessage Auto Const Mandatory

Bool bIsValid = false Conditional
Bool bHasRun = false Conditional
Bool bShouldStart = false Conditional
Bool bShouldStop = false Conditional

RecipeContainer:CrossPluginIntegrator myIntegrator

RecipeContainer:CrossPluginIntegrator Function getIntegrator()
	return myIntegrator
EndFunction

Bool Function isValid()
	return bIsValid
EndFunction

Function setIntegrator(RecipeContainer:CrossPluginIntegrator newValue)
	myIntegrator = newValue
	updateState()
EndFunction

Function updateState()
	bIsValid = false
	bHasRun = false
	bShouldStart = false
	bShouldStop = false
	
	RecipeContainer:CrossPluginIntegrator integrator = getIntegrator()
	if (!integrator)
		return
	endif
	
	bIsValid = true
	bHasRun = integrator.hasRun()
	bShouldStart = integrator.shouldStart()
	bShouldStop = integrator.shouldStop()
EndFunction

Function rerun(ObjectReference akTerminalRef)
	RecipeContainer:CrossPluginIntegrator integrator = getIntegrator()

	integrator.Stop()
	integrator.Start()
	updateState()
	draw(akTerminalRef)
EndFunction

Function teardown(ObjectReference akTerminalRef)
	getIntegrator().Stop()
	updateState()
	draw(akTerminalRef)
EndFunction

Function forceInjections(ObjectReference akTerminalRef)
	getIntegrator().handleInjections(true)
	updateState()
	draw(akTerminalRef)
EndFunction

Function tokenReplacementLogic()
	if (isValid())
		replace("SelectedIntegrator", getIntegrator())
	else
		replace("SelectedIntegrator", InvalidOptionMessage) ; The terminal shouldn't show a replacement field in this case, but caution never hurt
	endif
EndFunction
