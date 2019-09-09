Scriptname RecipeContainer:ChroniclePackage:Behavior:CrossPluginIntegrator extends chronicle:package:custombehavior

RecipeContainer:CrossPluginIntegrator[] Property Integrators = None Auto Const

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
