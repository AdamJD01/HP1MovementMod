class H202Gargoyle extends baseProps;

var () bool ignoreCutCam;

function Trigger( actor Other, pawn EventInstigator )
{
	local actor A;
	gotostate('green');

		if( Event != '' )
			foreach AllActors( class 'Actor', A, Event )
				A.Trigger( self, None );
}
event PreBeginPlay()
{
	super.preBeginPlay();
	killAttachedParticleFX(0.0);	//start out with no particle effect.
}


auto state lookaround
{

begin:
	enable('trigger');
	loopanim('red');
		
loop:
	stop;

}


state green
{
begin:
		sleep(1);
		loopanim('green');
//		finishanim();
//		PlaySound(sound'HPSounds.critters_sfx.critters.s_gargoyle_eyes_growl');
		changeAttachedParticleFX(attachedParticleClass);	//start flame

loop:
	stop;

}

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skgargoyleMesh'
}
