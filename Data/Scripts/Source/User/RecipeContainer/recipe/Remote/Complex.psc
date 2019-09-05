Scriptname RecipeContainer:Recipe:Remote:Complex extends RecipeContainer:Recipe:Remote

Import InjectTec:Utility:HexidecimalLogic

Group FormSettings
	DigitSet Property UnprocessedDigits Auto Const Mandatory
	DigitSet Property ProcessedDigits Auto Const Mandatory
EndGroup

Group PluginSettings
	InjectTec:Plugin Property UnprocessedPlugin Auto Const Mandatory
	InjectTec:Plugin Property ProcessedPlugin Auto Const Mandatory
EndGroup

Form Function getUnprocessedForm()
	RecipeContainer:Utility:Remote.loadDigits(UnprocessedPlugin, UnprocessedDigits)
EndFunction

Form Function getProcessedForm()
	RecipeContainer:Utility:Remote.loadDigits(ProcessedPlugin, ProcessedDigits)
EndFunction
