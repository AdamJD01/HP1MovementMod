// ***************************************************************
// Gargoyle Class - used in Lumos Animations and elsewhere...
class gargoyle extends baseChar;

// ***************************************************************
// Class Variables
var () bool ignoreCutCam;


// ***************************************************************
//	Functions and Events
function Trigger( actor Other, pawn EventInstigator )
{
	local actor A;
	gotostate('green');

	if( Event != '' )
		foreach AllActors( class 'Actor', A, Event )
			A.Trigger( self, self );
}

// ***************************************************************
//	Gargoyle States
auto state lookaround
{
begin:
	enable('trigger');
	loopanim('red');
		
looppoint:		// Loop here...
	sleep(0.5);
	goto 'lcloop';
}


// The "Final" State...
state green
{
	function switchCamera()
	{
		local BaseCam c;
		local hpoint p1;
		local hpoint p2;

		foreach allActors(class'BaseCam', c)
		{
			break;
		}

		foreach allActors(class 'hpoint',p1)
		{
			if(p1.Name=='hpoint0')
			{
				break;
			}
		}
		foreach allActors(class 'hpoint',p2)
		{
			
			if(p2.Name=='hpoint1')
			{
				break;
			}
		}

		c.setCutCamera (p1, p2);
	}

	function returnCamera()
	{
		local BaseCam c;

		foreach allActors(class'BaseCam', c)
		{
			break;
		}

		c.exitCutCamera();
	}


begin:
	playanim('change2green');	// Play a little Head Shake...

	Sleep(1.0);
	PlaySound(sound'HPSounds.critters2_sfx.gargoyle_eyes_growl');

	finishanim();

	loopanim('green');

	sleep(1);
	if(!ignorecutCam)
	{
		switchCamera();
		sleep (2);
		returnCamera();
	}

looppoint:
	sleep(0.5);
	goto 'looppoint';
}

// **********************************************************************
//	Default Properties

defaultproperties
{
     ignoreCutCam=True
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skgargoyleMesh'
     CollisionHeight=30
}
