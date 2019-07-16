Scriptname RecipeContainer:Recipe:Remote:Complex extends RecipeContainer:Recipe:Remote Hidden Const

Import InjectTec:Utility:HexidecimalLogic

InjectTec:Plugin Property UnprocessedPlugin Auto Const Mandatory
InjectTec:Plugin Property ProcessedPlugin Auto Const Mandatory
DigitSet Property UnprocessedDigits Auto Const Mandatory
DigitSet Property ProcessedDigits Auto Const Mandatory

Potion Function getUnprocessedForm()
	RecipeContainer:Utility:Remote.loadDigits(UnprocessedPlugin, UnprocessedDigits)
EndFunction

Potion Function getProcessedForm()
	RecipeContainer:Utility:Remote.loadDigits(ProcessedPlugin, ProcessedDigits)
EndFunction
