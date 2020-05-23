Scriptname RecipeContainer:CrossPluginIntegrator extends InjectTec:Integrator:BehaviorOmnibus Hidden Conditional

RecipeContainer:Recipe:Builder Property Builder Auto Const

RecipeContainer:Recipe:Builder Function getBuilder()
    return Builder
EndFunction

RecipeContainer:Logic:Local Function getContainerType()
{Override this method to implement a functional integrator according to your plugin's needs.}
	RecipeContainer:CrossPluginIntegrator:Logger.logNoGetContainerTypeImplementation(self)
	return None
EndFunction

Bool Function canHandleBuilder()
    if (!getBuilder())
        return false
    endif

    RecipeContainer:Logic:Local myContainer = getContainerType()
    if (!myContainer)
        RecipeContainer:CrossPluginIntegrator:Logger.logContainerNotFound(self)
        return false
    endif

    return true
EndFunction

Function startBehavior()
    canHandleBuilder() && getContainerType().addBuilder(getBuilder())
    parent.startBehavior()
EndFunction

Function stopBehavior()
    canHandleBuilder() && getContainerType().removeBuilder(getBuilder())
    parent.stopBehavior()
EndFunction

Function unrunBehavior()
    canHandleBuilder() && getContainerType().removeBuilder(getBuilder())
    parent.unrunBehavior()
EndFunction

Bool Function shouldUnrunLogic()
    return parent.shouldUnrunLogic() || (canHandleBuilder() && !getBuilder().validateData())
EndFunction
