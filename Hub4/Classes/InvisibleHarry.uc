// Invisible Harry - Harry with the Invisibility Cloak, used on the sneak levels.  He fades to
//		visible in about a second when he's casting a spell, and fades back to invisible after
//		about a second when he's done casting a spell...
// author:  Paul  J. Furio

class InvisibleHarry extends Harry;

//Edited by- AdamJD (edited code will have AdamJD by it)

// Make this setable in the Editor so we can tweak it...
var () float	InvisibleValue;
var Texture		HitTexture;		// This is global to the class here so we can check it from Filch & Norris
var bool		bVisible;
var () bool		bHasCloak;

var vector		LastLocation;
var () float	FlagMovementRadius;
var bool		IsMoving;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	// Make his wand Opaque too...
	weapon.Opacity = InvisibleValue;

	bVisible = false;
	LastLocation = location;

	Enable('PlayerTick');
	IsMoving = false;
	bInSneak = true;
}

// ***** These two are always called from within Tick
function MakeInvisible(float DeltaTime)
{
	// if it's not already totally invisible...
	if(Opacity != InvisibleValue)
	{

		// This makes it take a second to become invisible, right?
		Opacity = Opacity - ( DeltaTime * 3 * (1.0 - InvisibleValue));

		// Make sure we don't overshoot this
		if(Opacity < InvisibleValue)
			Opacity = InvisibleValue;

		weapon.Opacity = Opacity;

		if(Opacity < (((1.0 - InvisibleValue) / 2.0) +  InvisibleValue ))
		{
			if(bVisible)
			{
				PlaySound(sound'HPSounds.magic_sfx.HAR_invisible');
				bVisible = false;
			}
		}

	}
}

function MakeVisible(float DeltaTime)
{
	// if it's not already totally visible...
	if(Opacity < 1.0)
	{

		// This makes it take a second to become invisible, right?
		Opacity = Opacity + ( DeltaTime * 3 * (1.0 - InvisibleValue));

		// Make sure we don't overshoot this
		if(Opacity > 1.0)
			Opacity = 1.0;

		weapon.Opacity = Opacity;

		
		if(Opacity >= (((1.0 - InvisibleValue) / 2.0) +  InvisibleValue ))
		{
			if(!bVisible)
			{
				PlaySound(sound'HPSounds.magic_sfx.HAR_visible');
				bVisible = true;
			}
		}
	}
}

function OverrideTick(float DeltaTime)
{
	local bool isDebugged;
	
	// This lets us know that, in fact, this function is not called all the time...
	
	//if(!IsInState('playeraiming')) //old not needed retail PlayerAiming state -AdamJD
	if(!bPlayerCasting) //is player not casting? -AdamJD
	{
		if(bHasCloak)
			MakeInvisible(DeltaTime);
		else
			MakeVisible(DeltaTime);
	}
	else
	{
		MakeVisible(DeltaTime);
	}
	
	//old retail code -AdamJD
	/*
	// Now signal for Movement
	if(VSize (LastLocation - location) > FlagMovementRadius)
	{
		//Diagnostics 
		if(!IsMoving)
			clientmessage("Harry Started Moving.");
		IsMoving = true;
	}
	else
	{
		//Diagnostics 
		if(IsMoving)
			clientmessage("Harry Stopped Moving.");
		IsMoving = false;
	}
	*/
	
	//Player is not touching a movement key or is in a cutscene -AdamJD
	if( Acceleration == vect(0,0,0) )
	{
		IsMoving = false;
		//ClientMessage("Harry not moving"); //for testing -AdamJD
	}
	
	//Player has touched a movement key so therefore Harry is now moving -AdamJD
	else
	{
		IsMoving = true; 
		//ClientMessage("Harry is moving"); //for testing -AdamJD
	}
	
	LastLocation = location;
}

// Override for all Ticks...
event PlayerTick(float DeltaTime)
{
	Super.PlayerTick(DeltaTime);

	OverrideTick(DeltaTime);
}

// We're adding some stuff here so we can "announce" what surface we're on...
simulated function PlayFootStep()
{
	local sound step;
	local float decision;

	local int Flags;

	local sound Footstep1;
	local sound Footstep2;
	local sound Footstep3;

	if ( FootRegion.Zone.bWaterZone )
	{
		PlaySound(WaterStep, SLOT_Interact, 1, false, 1000.0, 1.0);
		return;
	}

	HitTexture = TraceTexture(Location + (vect(0,0,-128)), Location, Flags );

	super.PlayFootStep();
	/*
	if (HitTexture.FootstepSound == FOOTSTEP_Wood)
	{
	//	Footstep1 = Sound'HPSounds.test_sfx.HAR_foot_wood1';
	//	Footstep2 = Sound'HPSounds.test_sfx.HAR_foot_wood2';
	//	Footstep3 = Sound'HPSounds.test_sfx.HAR_foot_wood3';


	}
	else if (HitTexture.FootstepSound == FOOTSTEP_Rug)
	{
	//	Footstep1 = Sound'HPSounds.test_sfx.HAR_foot_rug1';
	//	Footstep2 = Sound'HPSounds.test_sfx.HAR_foot_rug2';
	//	Footstep3 = Sound'HPSounds.test_sfx.HAR_foot_rug3';

	}
	else
	{
	//	Footstep1 = Sound'HPSounds.test_sfx.HAR_foot_stone1';
	//	Footstep2 = Sound'HPSounds.test_sfx.HAR_foot_stone2';
	//	Footstep3 = Sound'HPSounds.test_sfx.HAR_foot_stone3';
	}

	decision = FRand();
	if ( decision < 0.34 )
		step = Footstep1;
	else if (decision < 0.67 )
		step = Footstep2;
	else
		step = Footstep3;

	PlaySound(step, SLOT_Interact,1, false, 1000.0, 0.9);
	*/
}

// ******************************************************************
// ** All these states are redefined here so we can overload the
// **  PlayerTick() function to adjust the opacity.
// ******************************************************************
state harryfrozen
{
	event PlayerTick(float DeltaTime)
	{
		Super.PlayerTick(DeltaTime);

		OverrideTick(DeltaTime);
		
		//stop casting and turn off cursor if caught -AdamJD
		if(bPlayerCasting == true)
		{
			bPlayerCasting = false;
			StopCasting();
			baseWand(weapon).bPointing = false;
			basewand(weapon).bCasting=false;
			baseWand(Weapon).WandEffect.bHidden = true;
			rectarget.destroy();
			StopSoundFX();
		}
	}

	function ProcessMove(float DeltaTime, vector NewAccel, eDodgeDir DodgeMove, rotator DeltaRot)	
	{
		local vector OldAccel;
		
	
		OldAccel = Acceleration;
		Acceleration = NewAccel;
		bIsTurning = ( Abs(DeltaRot.Yaw/DeltaTime) > 5000 );

		if(bJustAltFired || bJustFired)
		{
			Velocity = vect(0,0,0);
			return;
		}

		if ( bPressedJump )
		{
			// DoJump();	// Disable jumping
			bPressedJump = false;
		}

		if ( (Physics == PHYS_Walking) )
		{
			loopanim('caughtbyfilch');
		}
	}
}

// Override this to play the right animation
state stateDead
{
	ignores Tick, AltFire, Fire;

	//Use this, cause it gets called when you call GotoState();
	function BeginState()
	{
		//enable('tick');
		Velocity.x = 0;
		Velocity.y = 0;
		Acceleration = vect(0,0,0);

		PlayAnim('caughtbyfilch');

		//Harry's anim has already been started, so now set the frame his faint is on.
		//if( bClubDeath )
		//	AnimFrame = 42.0/93.0;//0.247;
	}

  begin:

	cam.GotoState('CutState');

	//	moveto(self.location);
loop:
	Sleep(0.5);

	if( bAllowHarryToDie )
	{
		//I'm sure something else needs to happen here...

		//Level.Game.RestartGame();

		baseConsole(player.console).LoadSelectedSlot();
	
/*		if( SaveGameExists() )
		{
			ConsoleCommand("open save9.usa");
		}
		else
		{
			Level.Game.RestartGame();
		}
*/
		//ClientTravel( "?load=9", TRAVEL_Absolute, false);

	}

	goto 'loop';

}


state FallingMount
{
	event PlayerTick(float DeltaTime)
	{
		Super.PlayerTick(DeltaTime);

		OverrideTick(DeltaTime);
	}
}

state Mounting
{
	event PlayerTick(float DeltaTime)
	{
		Super.PlayerTick(DeltaTime);

		OverrideTick(DeltaTime);
	}
}

//old not needed retail PlayerAiming state -AdamJD
/*
state playeraiming
{
	event PlayerTick(float DeltaTime)
	{
		MakeVisible(DeltaTime);

		Super.PlayerTick(DeltaTime);
	}
}
*/

state PlayerWalking
{
	event PlayerTick(float DeltaTime)
	{
		Super.PlayerTick(DeltaTime);

		OverrideTick(DeltaTime);
		
		//if player is casting then make Harry visible -AdamJD
		if (bPlayerCasting == true) 
		{
			MakeVisible(DeltaTime); 
		}
	}
}



// *********************************************************
// Set the Opacity.  This totally fucking sucks from a serious programming standpoint,
//	because I should be able to use the "constant" InvisibleValue like this:
//		Opacity = InvisibleValue;
//	but that doesn't work because UnrealScript sucks ass

defaultproperties
{
     InvisibleValue=0.15
     FlagMovementRadius=2
     bInSneak=True
     Opacity=0.15
}
