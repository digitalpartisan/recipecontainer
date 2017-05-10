Scriptname RecipeContainer:Logic extends Quest
{Attach this script in the editor to define a type of container (ex. a "fridge") to specify how long the container takes to work and what recipes the type of container can put into effect.
Because of the use of drinking buddy recipes elsewhere in the game, this library makes use of them, though without the issue of whether or not the player has found a holotape for each recipe.
This decision was made largely because of the volume of existing recipes in the game files already which means this library can make use of them.
This functionality is here and not handled by the container instance script because doing so centralizes access to recipe options and removes anything not specifically required to determine the state of any particular container, which simplifies the container instance script.}

Float Property CycleHours Auto Const Mandatory
{The number of in-game hours required to either cool drinks or cause them to become warm}
DialogueDrinkingBuddyScript:BrewingRecipe[] Property CustomRecipes Auto
{The recipes specific to this type of container will use to process contents.}

Bool Function validateRecipe(DialogueDrinkingBuddyScript:BrewingRecipe recipeData)
{The base game did something like this in ths Buddy dialogue logic, so it's probably best to do it here, too.}
	return (None != recipeData.WarmDrinkVariant && None != recipeData.ColdDrinkVariant)
EndFunction

Bool Function instanceNeedsProcessing(RecipeContainer:ContainerInstance akContainerRef, DialogueDrinkingBuddyScript:BrewingRecipe[] recipes = None)
	if (None == recipes)
		recipes = CustomRecipes
	endif
	
	if (0 == recipes.Length)
		return false
	endif
	
	if (0 == akContainerRef.GetItemCount())
		return false
	endif
	
	Int iCounter = 0
	Bool bCooling = akContainerRef.isCooling()
	Form fCheckFor = None
	while (iCounter < recipes.Length)
		if (bCooling)
			fCheckFor = recipes[iCounter].WarmDrinkVariant
		else
			fCheckFor = recipes[iCounter].ColdDrinkVariant
		endif
		if (0 < akContainerRef.GetItemCount(fCheckFor))
			return true
		endif
		
		iCounter += 1
	endwhile
	
	return false
EndFunction

Function processRecipe(RecipeContainer:ContainerInstance akContainer, DialogueDrinkingBuddyScript:BrewingRecipe recipeData, Bool bCooling)
{Acts on the contents of the given container instance using the specified recipe to either warm or cool said contents.
Warming or cooling will take the appropriate warm or cool item from the recipe and replace it with it's cool or warm variant in the container passed to this function.}
	if (!validateRecipe(recipeData))
		return
	endif

	Potion pSearch = recipeData.ColdDrinkVariant
	Potion pReplace = recipeData.WarmDrinkVariant
	if (bCooling)
		pSearch = recipeData.WarmDrinkVariant
		pReplace = recipeData.ColdDrinkVariant
	endif

	Int iCount = akContainer.GetItemCount(pSearch)
	if (0 == iCount)
		return
	endif

	RecipeContainer:Logger.logReplacement(akContainer, pSearch, pReplace, iCount)
	akContainer.RemoveItem(pSearch, iCount, true)
	akContainer.AddItem(pReplace, iCount, true)
EndFunction

Function processRecipeList(RecipeContainer:ContainerInstance akContainer, DialogueDrinkingBuddyScript:BrewingRecipe[] recipes)
{Makes use of processRecipe() on an array of recipe objects against the contents of the container instance passed in.}
	Int iCounter = 0
	Bool bCooling = akContainer.isCooling() ; prevents unnecessary work by calling this function once per processing cycle
	While (iCounter < recipes.Length)
		processRecipe(akContainer, recipes[iCounter], bCooling)
		iCounter += 1
	EndWhile
EndFunction

Function processContainer(RecipeContainer:ContainerInstance akContainer)
	RecipeContainer:Logger.logCycle(akContainer)
	processRecipeList(akContainer, CustomRecipes)
EndFunction

Function addRecipe(DialogueDrinkingBuddyScript:BrewingRecipe recipeData)
{Used to programmatically add to the options available to the container type this script represents.  Useful for plugins which increase the }
	CustomRecipes.Add(recipeData)
EndFunction
