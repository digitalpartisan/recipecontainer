Scriptname RecipeContainer:Recipe:Builder:DrinkingBuddy extends RecipeContainer:Recipe:Builder

Import DialogueDrinkingBuddyScript
Import RecipeContainer:Utility:Recipe

DialogueDrinkingBuddyScript Property DialogueDrinkingBuddy Auto Const Mandatory
{The Drinking Buddy diagloque quest which contains the possible cold / warm variants which this script uses to cycle between warm and cold fridge contents}

Var[] Function populateBehavior()
	return createFromBulkBrewingRecipes(DialogueDrinkingBuddy.BrewingRecipes) as Var[]
EndFunction
