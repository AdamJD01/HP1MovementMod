//=============================================================================
// fluffyHead.
//
// Invisible actor controlling a single head of Fluffy.
// To do:
//		Sleep twitch.
//=============================================================================
class fluffyHead expands AnimChannel;

// Constant.
var() float ListenTime;
var() float SleepTime;
var() name AttackAnimL, AttackAnimR;
//var() float AttackDist;			// Distance from head on which aggression is based.
var() float StartSleepTime;     // Time it takes for FallAsleep anim to play
//var() float	FallAsleepTime;		// Time that head is asleep before it wakes up.
var   float _Timer;         // Timer for listening
var() sound SnarlSound, BarkSound, BiteSound, SnoreSound;

var() float HeadAttackCone;

// Runtime.
var PlayerPawn P;

// Variable.
var bool bSleeping;
var bool bActuallySleeping;  // On when the actual asleep timer is running, not as the head falls asleep.
var bool bCanAttack;         // Attacking is exclusive between heads.

// Temp.
var float r;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	P = BaseChar(Owner).PlayerHarry;

	_Timer = ListenTime;
}

//******************************************************************************************
function bool PlayerAttackableByHead()
{
	local float   d;
	local vector  vHeadLoc, vDir;
	local vector  v, v2;

	d = P.CollisionRadius + Fluffy(Owner).AttackDist;

	//return    VSize2D(P.Location - (Location                                       )) < d/2
	//       || VSize2D(P.Location - (Location + vector(Fluffy(Owner).Rotation) * d/4)) < d/2;

	vDir = Vector(Owner.Rotation);
	vHeadLoc = Location - vDir * ( (Location - Owner.Location) dot vDir ); //project onto plane lateral with the dogs location.

	//d = Vsize2d( vHeadLoc - playerHarry.Location );

	//return    VSize2D(P.Location - (vHeadLoc             )) < d/2
	//       || VSize2D(P.Location - (vHeadLoc + vDir * d/4)) < d/2;

	v2 = (vHeadLoc - vDir*40);  // a "head loc" that's further back

	v = p.Location - vHeadLoc;

	return    (normal( (p.Location - v2)*vect(1,1,0) ) dot vDir) > cos(HeadAttackCone * 2.0*pi/360.0)
	       && VSize2d( v ) < d;

}

//******************************************************************************************
// set iOutVar to 1 if head is asleep, 0 if it's not
function float GetSpecialHealth(out int iOutVar)
{
	if( bSleeping )
	{
		iOutVar = 1;
		return _Timer / SleepTime;
	}
	else
	{
		iOutVar = 0;
		return _Timer / ListenTime;
	}

	return 1.0;
}

//******************************************************************************************
function bool Attack()
{
	local vector pv;
	local name anim;

	//See if this head even can attack
	if( bSleeping )
		return false;

	// Choose attack based on player location.
	pv = (P.Location - Location) << Rotation;
	if( pv.Y < 0 )
		anim = AttackAnimL;
	else
		anim = AttackAnimR;

	// Main body attack.
	Owner.playAnim(anim, Fluffy(Owner).fAttackRearAnimRate, [Type] AT_Combine);
	Owner.gotoState('attacking');

	// Redundantly play attack anim on this head, for notify.
	playAnim(anim, Fluffy(Owner).fAttackRearAnimRate);

	GotoState('stateAttack');

	return true;
}

// Anim notifications.
function SoundBark()
{
	playSound(BarkSound);
}

function SoundGrowl()
{
	playSound(SnarlSound);
}

function AttackDamage()
{
	playSound(BiteSound);

	if( PlayerAttackableByHead() )
		P.TakeDamage( 5, none, Location, Vect(0,0,0), 'FluffyBite' );
}

// Overridden functions.
function StartSleeping()
{
}

function StopSleeping()
{
}

//****************************************************************************************
auto state awake
{
	// AE:
	function PlayPantSound()
	{
		switch( Rand(4) )
		{
			case 0: PlaySound(sound'HPSounds.Fluffy_sfx.fluffypant1'); break;
			case 1: PlaySound(sound'HPSounds.Fluffy_sfx.fluffypant2'); break;
			case 2: PlaySound(sound'HPSounds.Fluffy_sfx.fluffypant3'); break;
			case 3: PlaySound(sound'HPSounds.Fluffy_sfx.fluffypant4'); break;
		}
	}

	function StartSleeping()
	{
		// Initiate sleep countdown.
		//p.clientMessage(self$ " start listening: attackable = " $PlayerAttackable());
		//SetTimer(StartSleepTime, false);
		//baseHud(P.myHud).StartCountdown(FallAsleepTime);
		gotoState('listening');
	}

	//When awake, head regains awakedness, at a slow rate though.
	function Tick(float dtime)
	{
		_Timer += dtime/4;
		if( _Timer >= ListenTime )
			_Timer = ListenTime;
	}

  begin:
	// AE:
	PlayPantSound();
	loopAnim('bodybreath');

  loop:
	// Head waking idle. Check at short intervals.
	sleep(0.25);

	//if( PlayerAttackable() )
	//{
	//	// Bite or bark.
	//	if (bCanAttack && frand() < 0.2)
	//		Attack();
	//	else
	//		playAnim('fullbark');
	//}
	//else
	//{
		if( frand() < 0.0666 )
			playAnim('fullbark');
		else
		if( frand() < 0.1 )
			playAnim('fullgrowl');
		else
		if( frand() < 0.25 )
			playAnim('fullblink');
	//}

	finishAnim();

	goto 'loop';
}

//********************************************************************************
state listening
{
	function BeginState()
	{
		//baseHud(P.myHud).StartCountdown( ListenTime );
		//baseHud(P.myHud).bAutoCount = false; //Dont let the hud decrement the counter.

		//Now copy in our current sleep time
		//baseHud(P.myHud).fCountdownTime = _Timer;
	}

	function EndState()
	{
		//baseHud(P.myHud).StopCountdown();
	}

	function StopSleeping()
	{
		// Cancel countdown.
		p.clientMessage(self$ " stop listening");
		//SetTimer(0.0, false);
		//baseHud(P.myHud).StopCountdown();
		gotoState('awake');
	}

	//function Timer()
	//{
	//	// Start sleeping the head.
	//	p.clientMessage(self$ " time up");
	//	gotostate('fall_asleep');
	//}

	function Tick(float dtime)
	{
		//When listening, head looses awakedness
		//But the hud is doing the timing for this
		//_Timer -= dtime;
		//if( _Timer <= 0 )
		//{
		//	_Timer = 0;
		//	baseHud(P.myHud).fCountdownTime = _Timer;
		
		//Copy the time out of the hud
		//_Timer = baseHud(P.myHud).fCountdownTime;
		_Timer -= dtime;

		//Alright, if we're at zero, goto sleep
		if( _Timer <= 0 )
		{
			_Timer = 0;
			GotoState('fall_asleep');
		}
	}

  begin:

  loop:
	// Head waking idle. Check at short intervals.
	sleep(0.25);

	if (frand() < 0.25)
		playAnim('fullblink');

	finishAnim();

	goto 'loop';
}

//********************************************************************************
state stateAttack
{
	function AttackRearFinish()
	{
		Fluffy(Owner).AnimRate = Fluffy(Owner).fAttackLungeAnimRate;
		AnimRate = Fluffy(Owner).fAttackLungeAnimRate;
	}

	function Tick(float dtime)
	{
		//Keep taking off time, if harrys playing to me
		if( HarryPlayingToMe() )
		{
			_Timer -= dtime;

			//Alright, if we're at zero, goto sleep
			if( _Timer <= 0 )
			{
				_Timer = 0;
				GotoState('fall_asleep');
			}
		}
	}

  Begin:
	//PlayAnim for attack has already been called
	FinishAnim();

	//This is not the best way to do this:  If Harry in front of me, and Harry's playing, goto listening.
	if( HarryPlayingToMe() )//
		GotoState( 'listening' );
	else
		GotoState('awake');
}

//********************************************************************************
function bool HarryPlayingToMe()
{
	return Fluffy(Owner).FindClosestHead() == self  &&  Fluffy(Owner).PlayerAttackable()  &&  P.IsInState('FlutePlay');
}

//********************************************************************************
state fall_asleep
{
	//function StopSleeping()
	//{
	//	// Cancel sleep process.
	//	baseHud(P.myHud).StopCountdown();
	//	gotostate('awake');
	//}

	function BeginState()
	{
		bSleeping = true;
		bActuallySleeping = false;
		_Timer = 0;
	}

	function EndState()
	{
		P.ClientMessage("Asleep.... End");
		bSleeping = false;
		bActuallySleeping = false;
	}

	function AnimEnd()
	{
		loopAnim('fullSleep');
	}

	function Tick(float dtime)
	{
		if( bActuallySleeping )
		{
			//If Harry's playing the flute to this head
			if( HarryPlayingToMe() )
			{
				_Timer -= dtime;
				if( _Timer < 0 )
					_Timer = 0;
			}
			else
			{
				_Timer += dtime;
				if( _Timer >= SleepTime )
					_Timer = SleepTime;
			}
		}
	}

  begin:

P.ClientMessage("Asleep....");
	// Fall asleep for pre-determined time, wake up again.
	playAnim('headLFallasleep', 1.0, 0.5);

	//sleep(FallAsleepTime-StartSleepTime);
	sleep( StartSleepTime );
	//FinishAnim();  //What the fuck, it's like this FinishAnim never returns

	loopAnim('fullSleep');
	bActuallySleeping = true; //alright, let Tick update the sleeping timer now.

	while( _Timer < SleepTime )
		sleep(0.001);

	playAnim('fullWake');
	//finishAnim();
	Sleep(1.5);
P.ClientMessage("Asleep.... Fix this!!");

	bSleeping = false;
	_Timer = ListenTime;  //And, we start back over with our timer.
P.ClientMessage("Asleep.... GotoState awake");
	gotostate('awake');
}

//********************************************************************************
state all_asleep
{
}

//********************************************************************************

defaultproperties
{
     ListenTime=3
     SleepTime=5
     StartSleepTime=3
     HeadAttackCone=20
     bCanAttack=True
     CollisionRadius=30
     CollisionHeight=150
     bCollideActors=True
}
