Scriptname RecipeContainer:CrossPluginIntegrator:PackageBehavior extends Chronicle:Package:CustomBehavior

RecipeContainer:CrossPluginIntegrator[] Property Integrators Auto Const Mandatory

Bool Function installBehavior()
	RecipeContainer:CrossPluginIntegrator.stateCheckBulk(Integrators)
	return true
EndFunction

Bool Function postloadBehavior()
	RecipeContainer:CrossPluginIntegrator.stateCheckBulk(Integrators)
	return true
EndFunction

Bool Function uninstallBehavior()
	RecipeContainer:CrossPluginIntegrator.stopBulk(Integrators)
	return true
EndFunction
