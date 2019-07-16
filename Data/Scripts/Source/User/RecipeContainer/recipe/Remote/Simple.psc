Scriptname RecipeContainer:Recipe:Remote:Simple extends RecipeContainer:Recipe:Remote

Import InjectTec:Utility:HexidecimalLogic

InjectTec:Plugin Property Plugin Auto Const Mandatory
DigitSet Property UnprocessedDigits Auto Const Mandatory
DigitSet Property ProcessedDigits Auto Const Mandatory

Potion Function getUnprocessedForm()
	RecipeContainer:Utility:Remote.loadDigits(Plugin, UnprocessedDigits)
EndFunction

Potion Function getProcessedForm()
	RecipeContainer:Utility:Remote.loadDigits(Plugin, ProcessedDigits)
EndFunction

