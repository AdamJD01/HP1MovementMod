class filch extends baseChar;



var() Sound say1;
var bool warned;


function PostBeginPlay()
{

		Super.PostBeginPlay();
			   
		foreach allActors(class'baseHarry', p)
		{
			if( p.bIsPlayer&& p!=Self)
			{
		
				break;
			}
		}

		setPhysics(PHYS_Walking);
		LoopAnim('Breathe');
		warned = false;	
		gotostate('wait');

}

auto state wait
{
	begin:

	loop:

		FinishAnim();

		if(frand() < 0.4)
			LoopAnim('Breathe',,0.5);
		else
		if(frand() < 0.8)
		{
			LoopAnim('Sweep',,0.5);
		}
		else
			LoopAnim('Look',,0.5);		
		
		if(vsize(location-p.location)<75  && warned == false)
		{
		//	p.clientmessage("talking"$vsize(location-p.location));
		//	p.clientmessage("time "$GetSoundDuration(say1));
			warned = true;
			LoopAnim('Talk',,0.5);
			SetTimer( GetSoundDuration(say1), false);
			PlaySound(say1);
			gotostate('talk');
		}	 

		goto 'loop';

}

function PlaySweepSound()
{
	playSound(Sound'HPSounds.critters2_sfx.FIL_SWEEP',,0.5,,300);
}

state talk
{

	begin:
	loop:
		turntoward(p);	  // turn to player when talking to him
		
		goto 'loop';

}


simulated function Timer()
{
	LoopAnim('Breathe',,0.5);
	gotostate('wait');
}

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skfilchMesh'
     CollisionHeight=50
}
