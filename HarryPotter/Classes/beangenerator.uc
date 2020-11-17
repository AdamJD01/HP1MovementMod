class beangenerator extends baseprops;



/*
	How beangenarator works
	if connected to a trigger, when triggered will generate a bean (or anything else for that matter)
	 that is stored in transforminto, at the same location as beangenerator. Beangenerator then destroys itself.






*/


	
function Trigger( actor Other, pawn EventInstigator )

{
local vector spawnLoc;
local actor newSpawn;
local actor a;




	spawnLoc=location;
	newSpawn=Spawn(transformInto,,, spawnLoc);
	destroy();	
	
	
	

}

defaultproperties
{
     bStatic=False
     bHidden=True
     Texture=Texture'Engine.S_Pawn'
     bCollideActors=False
}
