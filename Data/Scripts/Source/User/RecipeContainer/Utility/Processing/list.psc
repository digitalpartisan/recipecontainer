Scriptname RecipeContainer:Utility:Processing:List extends Jiffy:List

Import RecipeContainer:Utility:Processing

Bool Function equalityCheck(Var avItemOne, Var avItemTwo)
	return compare(avItemOne as ProcessPattern, avItemTwo as ProcessPattern)
EndFunction

Bool Function validate(Var avItem)
	return validatePattern(avItem as ProcessPattern)
EndFunction

ProcessPattern[] Function getProcessPatternData()
	return getData() as ProcessPattern[]
EndFunction
