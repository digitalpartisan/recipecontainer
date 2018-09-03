Scriptname RecipeContainer:Logic:Fridge extends RecipeContainer:Logic

Import DialogueDrinkingBuddyScript

DialogueDrinkingBuddyScript Property DialogueDrinkingBuddy Auto Const Mandatory
{The Drinking Buddy diagloque quest which contains the possible cold / warm variants which this script uses to cycle between warm and cold fridge contents}

Bool Function instanceNeedsProcessing(RecipeContainer:ContainerInstance akContainerRef)
{In addition to the base logic, this function needs to consider the Drinking Buddy list of recipes.}
	return parent.instanceNeedsProcessing(akContainerRef) || RecipeContainer:Utility.isInstanceUnprocessed(akContainerRef, DialogueDrinkingBuddy.BrewingRecipes)
EndFunction

Function processInstance(RecipeContainer:ContainerInstance akContainerRef)
{Just like instanceNeedsProcessing(), this function must also work on the given container using the Drink Buddy recipes since that is the base game's central source of cold drinks.}
	parent.processInstance(akContainerRef)
	processRecipeList(akContainerRef, DialogueDrinkingBuddy.BrewingRecipes)
EndFunction
