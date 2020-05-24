Scriptname RecipeContainer:CrossPluginIntegrator:Logger Hidden Const DebugOnly

String[] Function getTags() Global
	String[] tags = new String[0]
	tags.Add("Cross Plugin Integrator")
	return tags
EndFunction

Bool Function log(String sMessage) Global
	return RecipeContainer:Logger.log(sMessage, getTags())
EndFunction

Bool Function warn(String sMessage) Global
	return RecipeContainer:Logger.warn(sMessage, getTags())
EndFunction

Bool Function error(String sMessage) Global
	return RecipeContainer:Logger.error(sMessage, getTags())
EndFunction

Bool Function logDoesNotMeetRequirements(RecipeContainer:CrossPluginIntegrator integrator) Global
	return log(integrator + " does not meet its plugin requirements")
EndFunction

Bool Function logStarting(RecipeContainer:CrossPluginIntegrator integrator) Global
	return log(integrator + " is starting")
EndFunction

Bool Function logStarted(RecipeContainer:CrossPluginIntegrator integrator) Global
	return log(integrator + " has finished starting")
EndFunction

Bool Function logStopping(RecipeContainer:CrossPluginIntegrator integrator) Global
	return log(integrator + " is stopping")
EndFunction

Bool Function logStopped(RecipeContainer:CrossPluginIntegrator integrator) Global
	return log(integrator + " has finished stopping")
EndFunction

Bool Function logContainerNotFound(RecipeContainer:CrossPluginIntegrator integrator) Global
	return error(integrator + " needed a container type that it could not find")
EndFunction

Bool Function logNoGetContainerTypeImplementation(RecipeContainer:CrossPluginIntegrator integrator) Global
	return error(integrator + " has no getContainerType() implementation")
EndFunction
