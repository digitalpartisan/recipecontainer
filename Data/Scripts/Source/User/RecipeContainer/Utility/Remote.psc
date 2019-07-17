Scriptname RecipeContainer:Utility:Remote Hidden Const

Import InjectTec:Utility:HexidecimalLogic
Import RecipeContainer:Utility:Recipe

Form Function loadDigits(InjectTec:Plugin plugin, DigitSet digits) Global
	return InjectTec:Plugin.fetchFromDigits(plugin, digits)
EndFunction

SimpleRecipe Function loadRemoteForms(InjectTec:Plugin unprocessedPlugin, DigitSet unprocessedDigits, InjectTec:Plugin processedPlugin, DigitSet processedDigits) Global
	return create(loadDigits(unprocessedPlugin, unprocessedDigits), loadDigits(processedPlugin, processedDigits))
EndFunction

SimpleRecipe Function loadSimpleRemoteRecipe(InjectTec:Plugin plugin, DigitSet unprocessedDigits, DigitSet processedDigits) Global
	return loadRemoteForms(plugin, unprocessedDigits, plugin, processedDigits)
EndFunction

RecipeContainer:Logic Function loadContainerLogic(InjectTec:Plugin plugin, DigitSet digits) Global
	return InjectTec:Plugin.fetchFromDigits(plugin, digits) as RecipeContainer:Logic
EndFunction

RecipeContainer:ContainerInstance Function loadContainerInstance(InjectTec:Plugin plugin, DigitSet digits) Global
	return InjectTec:Plugin.fetchFromDigits(plugin, digits) as RecipeContainer:ContainerInstance
EndFunction
