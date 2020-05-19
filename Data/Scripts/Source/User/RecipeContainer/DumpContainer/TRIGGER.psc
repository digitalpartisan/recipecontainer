Scriptname RecipeContainer:DumpContainer:Trigger extends ObjectReference

RecipeContainer:DumpContainer Property ContainerReferece Auto Const Mandatory

Event OnActivate(ObjectReference akActionRef)
	ContainerReferece.refresh()
EndEvent
