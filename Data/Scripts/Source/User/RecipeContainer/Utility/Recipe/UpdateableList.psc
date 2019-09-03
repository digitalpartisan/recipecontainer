Scriptname RecipeContainer:Utility:Recipe:UpdateableList extends Jiffy:List:Updateable

Import RecipeContainer:Utility:Recipe

Bool Function equalityCheck(Var avItem1, Var avItem2)
	return compare(avItem1 as SimpleRecipe, avItem2 as SimpleRecipe)
EndFunction

SimpleRecipe Function getRecipe(Int iIndex)
	return get(iIndex) as SimpleRecipe
EndFunction

SimpleRecipe[] Function getRecipeData()
	return None
EndFunction

Function setRecipes(SimpleRecipe[] newValue)
	setData(newValue as Var[])
EndFunction
