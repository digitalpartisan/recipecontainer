Scriptname RecipeContainer:Logic:Fridge extends RecipeContainer:Logic

DialogueDrinkingBuddyScript Property DialogueDrinkingBuddy Auto Const Mandatory
{The Drinking Buddy diagloque quest which contains the possible cold / warm variants which this script uses to cycle between warm and cold fridge contents}

Bool Function instanceNeedsProcessing(RecipeContainer:ContainerInstance akContainer, DialogueDrinkingBuddyScript: BrewingRecipe[] recipes = None)
{In addition to the base logic, this function needs to consider the Drinking Buddy list of recipes.}
	return parent.instanceNeedsProcessing(akContainer) || parent.instanceNeedsProcessing(akContainer, DialogueDrinkingBuddy.BrewingRecipes)
EndFunction

Function processContainer(RecipeContainer:ContainerInstance akContainer)
{Just like instanceNeedsProcessing(), this function must also work on the given container using the Drink Buddy recipes since that is the base game's central source of cold drinks.}
	parent.processContainer(akContainer)
	processRecipeList(akContainer, DialogueDrinkingBuddy.BrewingRecipes)
EndFunction
