Scriptname RecipeContainer:RemoteContainer extends Quest

Import InjectTec:Utility:HexidecimalLogic

InjectTec:Plugin Property TargetPlugin Auto Const Mandatory
Int Property TargetID Auto Const
DigitSet Property TargetDigits Auto Const Mandatory

RecipeContainer:Logic Function lookup()
	return InjectTec:Utility:Form.load(None, TargetPlugin, TargetID, TargetDigits) as RecipeContainer:Logic
EndFunction
