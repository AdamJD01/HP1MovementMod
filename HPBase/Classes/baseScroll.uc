//===============================================================================
//  [baseScroll] 
//===============================================================================

class baseScroll extends baseprops;

var actor popup;
var rotator newrot;
var actor scrollparticle;


event expired()
{
		baseHud(playerharry.myHud).bCutSceneMode=false;
		playerharry.CutRelease();
		super.expired();
}

auto state wait
{

function tick (float delta)
{
	newrot=rotation;
	newrot.yaw=newrot.yaw+(50000*delta);
//	newrot.roll=newrot.roll+(1000*delta);
	setrotation(newrot);
	if(scrollparticle!=none)
	{
		scrollparticle.setlocation(location);
	}



}

	begin:
	sleep(1);
	goto 'begin';
}

state popstate
{






	begin:
	
	baseHud(playerharry.myHud).bCutSceneMode=true;
	playerharry.CutDoIdle();
	lifespan=popup.lifespan;
	sleep (0.5);

	
	

	poploop:
	if(playerharry.bSkipKeyPressed)
	{
		
		baseHud(playerharry.myHud).bCutSceneMode=false;
		playerharry.CutRelease();
		popup.destroy();
		destroy();
	}
	sleep(0.03);
	goto 'poploop';


}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     DrawScale=2
     CollisionRadius=100
     bCollideWorld=True
}
