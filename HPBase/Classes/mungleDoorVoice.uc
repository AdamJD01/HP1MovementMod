class mungleDoorVoice expands inform;






var baseHarry playerHarry;

function PreBeginPlay()
{
local int count;

	Super.PreBeginPlay();

	foreach AllActors(class'baseharry', playerHarry)
		{
		if( playerHarry.bIsPlayer&& playerHarry!=Self)
			{
				break;
			}
		}

}





function touch (actor other)
{
	if(other==playerharry)
	{
//		PlaySound(sound'HPSounds.dlg_har.Har_019');
		destroy();
	}


}


function Trigger( actor Other, pawn EventInstigator )
{
	destroy();
}

defaultproperties
{
     bHidden=True
     CollisionRadius=30
     CollisionHeight=20
     bCollideActors=True
}
