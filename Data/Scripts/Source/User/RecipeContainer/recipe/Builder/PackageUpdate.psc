Scriptname RecipeContainer:recipe:Builder:PackageUpdate extends Chronicle:Package:Update

RecipeContainer:Logic:Local Property ContainerType Auto Const Mandatory
RecipeContainer:Recipe:Builder[] Property Builders Auto Const Mandatory

Function addBuilders()
	if (!ContainerType || !Builders || !Builders.Length)
		return
	endif
	
	Int iCounter = 0
	while (iCounter < Builders.Length)
		if (Builders[iCounter])
			ContainerType.addBuilder(Builders[iCounter])
		endif
		
		iCounter += 1
	endWhile
EndFunction

Function updateLogic()
	addBuilders()
	sendSuccess()
EndFunction
