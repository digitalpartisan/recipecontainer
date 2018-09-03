Scriptname RecipeContainer:Logic extends Quest
{Attach this script in the editor to define a type of container (ex. a "fridge") to specify how long the container takes to work and what recipes the type of container can put into effect.
Because of the use of drinking buddy recipes elsewhere in the game, this library makes use of them, though without the issue of whether or not the player has found a holotape for each recipe.
This decision was made largely because of the volume of existing recipes in the game files already which means this library can make use of them.
This functionality is here and not handled by the container instance script because doing so centralizes access to recipe options and removes anything not specifically required to determine the state of any particular container, which simplifies the container instance script.}

Import DialogueDrinkingBuddyScript

Float Property CycleHours = 3.0 Auto Const
{The number of in-game hours required to either cool drinks or cause them to become warm}
BrewingRecipe[] Property CustomRecipes Auto
{The recipes specific to this type of container will use to process contents.}
RecipeContainer:RemoteContainer Property RemoteContainer Auto

Bool Function validateRecipe(BrewingRecipe recipeData)
{The base game did something like this in ths Buddy dialogue logic, so it's probably best to do it here, too.}
	return (None != recipeData.WarmDrinkVariant && None != recipeData.ColdDrinkVariant)
EndFunction

Bool Function instanceNeedsProcessing(RecipeContainer:ContainerInstance akContainerRef)
	if (RecipeContainer:Utility.isInstanceUnprocessed(akContainerRef, CustomRecipes))
		return true
	endif
	
	if (RemoteContainer)
		RecipeContainer:Logic remoteLogic = RemoteContainer.lookup()
		if (remoteLogic)
			return remoteLogic.instanceNeedsProcessing(akContainerRef)
		endif
	endif
	
	return false
EndFunction

Function processRecipe(RecipeContainer:ContainerInstance akContainerRef, BrewingRecipe recipeData, Bool bCooling)
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

	Int iCount = akContainerRef.GetItemCount(pSearch)
	if (0 == iCount)
		return
	endif

	RecipeContainer:Logger.logReplacement(akContainerRef, pSearch, pReplace, iCount)
	akContainerRef.RemoveItem(pSearch, iCount, true)
	akContainerRef.AddItem(pReplace, iCount, true)
EndFunction

Function processRecipeList(RecipeContainer:ContainerInstance akContainerRef, BrewingRecipe[] recipes)
{Makes use of processRecipe() on an array of recipe objects against the contents of the container instance passed in.}
	Int iCounter = 0
	Bool bCooling = akContainerRef.isCooling() ; prevents unnecessary work by calling this function once per processing cycle
	While (iCounter < recipes.Length)
		processRecipe(akContainerRef, recipes[iCounter], bCooling)
		iCounter += 1
	EndWhile
EndFunction

Function processInstance(RecipeContainer:ContainerInstance akContainerRef)
	RecipeContainer:Logger.logCycle(akContainerRef)
	processRecipeList(akContainerRef, CustomRecipes)
	
	if (RemoteContainer)
		RecipeContainer:Logic remoteLogic = RemoteContainer.lookup()
		if (remoteLogic)
			remoteLogic.processInstance(akContainerRef)
		endif
	endif
EndFunction

Function addRecipe(BrewingRecipe recipeData)
	RecipeContainer:Utility.addRecipeToContainer(self, recipeData)
EndFunction

Function addRecipes(BrewingRecipe[] newData)
	RecipeContainer:Utility.addRecipesToContainer(self, newData)
EndFunction

Function removeRecipe(BrewingRecipe targetRecipe)
	RecipeContainer:Utility.removeRecipeFromContainer(self, targetRecipe)
EndFunction

Function removeRecipes(BrewingRecipe[] oldData)
	RecipeContainer:Utility.removeRecipesFromContainer(self, oldData)
EndFunction

Function cleanData()
	RecipeContainer:Utility.cleanContainerData(self)
EndFunction

Function appendContainerRecipes(RecipeContainer:Logic sourceContainer)
	RecipeContainer:Utility.appendContainerRecipes(self, sourceContainer)
EndFunction

Function removeContainerRecipes(RecipeContainer:Logic sourceContainer)
	RecipeContainer:Utility.removeContainerRecipes(self, sourceContainer)
EndFunction
