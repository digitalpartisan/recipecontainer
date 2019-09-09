Scriptname RecipeContainer:CrossPluginIntegrator:Paginator extends DynamicTerminal:Paginator Conditional

RecipeContainer:CrossPluginIntegrator:Handler Property IntegratorHandler Auto Const Mandatory

Function itemActivation(Int iItem, ObjectReference akTerminalRef)
	IntegratorHandler.setIntegrator(getItem(iItem) as RecipeContainer:CrossPluginIntegrator)
	IntegratorHandler.draw(akTerminalRef)
EndFunction
