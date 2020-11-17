class savepoint extends baseprops;

var bool inactive;

function PostBeginPlay()
{
	Super.PostbeginPlay();
	SetTimer(1.0, false);
}

function Timer()
{
	if( VSize2d(playerHarry.Location - Location) > 100 )
		inactive = false;
}

function touch (actor other)
{
	if(other==playerharry && !inactive)
	{
		PlaySound(sound'HpSounds.menu_sfx.save_game', SLOT_Interact);
		inactive=true;
		destroy();
		HPConsole(playerHarry.player.console).MenuBook.SaveSelectedSlot();
	}
}

defaultproperties
{
     bDoBob=True
     bStatic=False
     Rotation=(Pitch=16384)
     DrawType=DT_Mesh
     Texture=Texture'Engine.S_Pawn'
     Mesh=SkeletalMesh'HPModels.SavePointFloatBookMesh'
     AmbientGlow=75
}
