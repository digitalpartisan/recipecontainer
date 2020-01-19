Scriptname RecipeContainer:CrossPluginIntegrator:PackageBehavior extends Chronicle:Package:CustomBehavior

RecipeContainer:CrossPluginIntegrator[] Property Integrators Auto Const Mandatory

Bool Function installBehavior()
	InjectTec:Integrator.stateCheckBulk(Integrators as InjectTec:Integrator[])
	return true
EndFunction

Bool Function postloadBehavior()
	InjectTec:Integrator.stateCheckBulk(Integrators as InjectTec:Integrator[])
	return true
EndFunction

Bool Function uninstallBehavior()
	InjectTec:Integrator.stopBulk(Integrators as InjectTec:Integrator[])
	return true
EndFunction
