Scriptname RecipeContainer:Utility:Remote Hidden Const

Import DialogueDrinkingBuddyScript
Import InjectTec:Utility:HexidecimalLogic

Potion Function loadDigits(InjectTec:Plugin plugin, DigitSet digits) Global
	return InjectTec:Plugin.fetchFromDigits(plugin, digits) as Potion
EndFunction

BrewingRecipe Function loadRemotePotions(InjectTec:Plugin unprocessedPlugin, DigitSet unprocessedDigits, InjectTec:Plugin processedPlugin, DigitSet processedDigits) Global
	return RecipeContainer:Utility:Recipe.create(loadDigits(unprocessedPlugin, unprocessedDigits), loadDigits(processedPlugin, processedDigits))
EndFunction

BrewingRecipe Function loadSimpleRemoteRecipe(InjectTec:Plugin plugin, DigitSet unprocessedDigits, DigitSet processedDigits) Global
	return loadRemotePotions(plugin, unprocessedDigits, plugin, processedDigits)
EndFunction

RecipeContainer:Logic Function loadContainerLogic(InjectTec:Plugin plugin, DigitSet digits) Global
	return InjectTec:Plugin.fetchFromDigits(plugin, digits) as RecipeContainer:Logic
EndFunction

RecipeContainer:ContainerInstance Function loadContainerInstance(InjectTec:Plugin plugin, DigitSet digits) Global
	return InjectTec:Plugin.fetchFromDigits(plugin, digits) as RecipeContainer:ContainerInstance
EndFunction
