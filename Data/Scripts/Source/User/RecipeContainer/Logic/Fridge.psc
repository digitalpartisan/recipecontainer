Scriptname RecipeContainer:Logic:Fridge extends RecipeContainer:Logic

Import DialogueDrinkingBuddyScript

DialogueDrinkingBuddyScript Property DialogueDrinkingBuddy Auto Const Mandatory
{The Drinking Buddy diagloque quest which contains the possible cold / warm variants which this script uses to cycle between warm and cold fridge contents}

Function buildRecipes()
	parent.buildRecipes()
	setRecipes(Jiffy:Utility:Array.union(getRecipes() as Var[], DialogueDrinkingBuddy.BrewingRecipes as Var[]) as BrewingRecipe[])
EndFunction	
