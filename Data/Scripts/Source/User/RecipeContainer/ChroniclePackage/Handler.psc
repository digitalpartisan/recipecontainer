Scriptname RecipeContainer:ChroniclePackage:Handler extends Chronicle:Package:Handler Conditional

Form[] Function getCrossPluginIntegrators()
	RecipeContainer:ChroniclePackage:Data packageData = getPackage().getCustomData() as RecipeContainer:ChroniclePackage:Data
	if (!packageData)
		return None
	endif
	
	return packageData.getCrossPluginIntegrators() as Form[]
EndFunction
