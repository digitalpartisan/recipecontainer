Scriptname RecipeContainer:CrossPluginIntegrator:PackageData extends Chronicle:Package:CustomData

RecipeContainer:ChroniclePackage:Behavior:CrossPluginIntegrator Property IntegratorBehavior = None Auto Const

RecipeContainer:CrossPluginIntegrator[] Function getCrossPluginIntegrators()
	return IntegratorBehavior.Integrators
EndFunction
