//=============================================================================
// fluffy.
// To do: 
//		Replace temp sounds.
//		Move collision bounds when asleep, if needed.
//=============================================================================
class Fluffy expands baseBoss;

// Runtime.
var FluffyHead Heads[3];
//var int SleepyHead;			// Which one currently being played to.
var particlefx FluteFX;		// Manage flute particles.
var wind FluteWind;			// Direct flute particles.
var() float AttackDist;

var() float fAttackTimerStart;
var   float fAttackTimer;

var() float fAttackRearAnimRate;
var() float fAttackLungeAnimRate;

var() float ListenTimeL;
var() float ListenTimeM;
var() float ListenTimeR;
var() float SleepTimeL;
var() float SleepTimeM;
var() float SleepTimeR;

// Temp.
var int h;

function PostBeginPlay()
{
	local int i, j;
	local float ListenTime[3];
	local float SleepTime[3];
	
	// Spawn the head controllers.
	Heads[0] = FluffyHead( CreateAnimChannel(class'FluffyHeadL', AT_Replace, 'bone_headL01') );
		Heads[0].SetLocation( BonePos('Dummy18') );
	Heads[1] = FluffyHead( CreateAnimChannel(class'FluffyHeadM', AT_Replace, 'bone_headM01') );
		Heads[1].SetLocation( BonePos('Dummy09') );
	Heads[2] = FluffyHead( CreateAnimChannel(class'FluffyHeadR', AT_Replace, 'bone_headR01') );
		Heads[2].SetLocation( BonePos('Dummy22') );

	Heads[0].ListenTime = ListenTimeL;
	Heads[0].SleepTime = SleepTimeL;
	Heads[1].ListenTime = ListenTimeM;
	Heads[1].SleepTime = SleepTimeM;
	Heads[2].ListenTime = ListenTimeR;
	Heads[2].SleepTime = SleepTimeR;

	//Randomize the heads
	for( i = 0; i < 3; i++ )
	{
		do
		{
			j = Rand(3);
		}until( ListenTime[j] == 0 )

		ListenTime[j] = Heads[i].ListenTime;
		SleepTime[j] =  Heads[i].SleepTime;
	}

	for( i = 0; i < 3; i++ )
	{
		Heads[i].ListenTime = ListenTime[i];
		Heads[i].SleepTime =  SleepTime[i];
	}

	//SleepyHead = -1;

	// Hack to move the feet down onto the trapdoor.
	PrePivot.Z -= 10;

	// Direct the notes via some negative wind -- this will be moved as needed.
	FluteWind = Heads[0].spawn(class'FluteWind');
}

function Trigger( Actor Other, Pawn Instigator )
{
	// Hacky way to intercept messages from others.
	//If Other is !none, flute started playing, otherwise flute stopped playing
	if( PlayerPawn(Instigator) != none )
		PlayFlute(Other);   		// Pass the info along
}

function bool PlayFlute( Actor flute )
{
	local int h;
	local actor faced;

	// Stop any existing sounds and particles.
	if( FluteFX!=none )
	{
		FluteFX.Shutdown();
		FluteFX = none;
	}

	playerHarry.stopSound([Slot] SLOT_Talk);

	if( flute!=none )
	{
		// Find which head Harry be facing.
		faced = FindClosestHead();//playerHarry.FacingActor( playerHarry.CollisionRadius + AttackDist*2 );
		playerHarry.clientMessage(" Faced " $faced );
		for (h=0; h<3; h++)
		{
			// Check if within attack distance of head.
			if( Heads[h] == faced && Heads[h].PlayerAttackableByHead() )
			{
				// Start sleeping timer.
				//SleepyHead = h;
				Heads[h].StartSleeping();
				
				// Spawn flute fx, and rotate upward.
				FluteFX = flute.spawn(class'FluteSleepFx', flute, [SpawnRotation] rot(16384,0,0));
				//FluteFX.AttachToOwner();
				if( flute(flute) != none )
					flute(flute).FluteFX = FluteFX;

				// Direct the notes via some negative wind.
				FluteWind.SetLocation(Heads[h].Location);

				// Play nice sound.
				// AE:
				playerHarry.playSound(sound'HPSounds.hub5_sfx.FluffyFlute', SLOT_Talk);

				return true;
			}
		}

		// Spawn dud flute fx, and rotate upward.
		FluteFX = flute.spawn(class'FluteNoteFx', flute, [SpawnRotation] rot(16384,0,0));
		FluteFX.AttachToOwner();

		// Play funny sound.
		playerHarry.playSound(sound'HPSounds.hub5_sfx.flute_song_miss', SLOT_Talk);
	}
	else
	{
		// Stop playing.
		//if( SleepyHead >= 0 )
		//	Heads[SleepyHead].StopSleeping();
		//SleepyHead = -1;

		//Let all the heads know we've stopped playing
		for (h=0; h<3; h++)
			Heads[h].StopSleeping();
	}

	return false;
}

//********************************************************************************************************
// set iOutVar to 1 if head is asleep, 0 if it's not
function float GetSpecialHealth(int iVar, out int iOutVar)
{
	iVar = Clamp( iVar, 0, 2 );
	return Heads[iVar].GetSpecialHealth( iOutVar );
}

//********************************************************************************************************
function bool PlayerAttackable()
{
	//return VSize2D(Location - P.Location) < P.CollisionRadius+AttackDist;
	//"linear" distance
	//playerHarry.ClientMessage("d:"$VSize2D(Location - playerHarry.Location)$" dist:"$(Vector(Rotation) dot (playerHarry.Location - Location)) $ " cr:"$playerHarry.CollisionRadius$" ad:"$AttackDist);
	return    VSize2D(Location - playerHarry.Location) < 1000
	       && (Vector(Rotation) dot (playerHarry.Location - Location)) < playerHarry.CollisionRadius + AttackDist + 5; //50;  with 5, you barely have to step back at all.
}

//********************************************************************************************************
function FluffyHead FindClosestHead()
{
	local FluffyHead    a;
	local float         d, ClosestDist;
	local vector        vDir;
	local vector        vHeadLoc;

	vDir = Vector(Rotation);
	ClosestDist = 100000;

	for( h = 0; h < 3; h++ )
	{
		vHeadLoc = Heads[h].Location;
		vHeadLoc = vHeadLoc - vDir * ( (vHeadLoc - Location) dot vDir ); //project onto plane lateral with the dogs location.

		d = Vsize2d( vHeadLoc - playerHarry.Location );

		if( d < ClosestDist )
		{
			ClosestDist = d;
			a = Heads[h];
		}
	}

	return a;
}

//********************************************************************************************************
auto state awake
{
	function Tick(float DeltaTime)
	{
		//If within attacking distance, dec our timer
		if( PlayerAttackable() )
			fAttackTimer -= DeltaTime;

		if( fAttackTimer <= 0 )
		{
playerHarry.ClientMessage("Fluffy attack");
			if( FindClosestHead().Attack() )
				fAttackTimer = fAttackTimerStart;     //If attack started, reset timer
			else
				fAttackTimer = fAttackTimerStart / 3; //If not, shorter timer.
		}

		// Are we all asleep?
		if (Heads[0].bSleeping && Heads[1].bSleeping && Heads[2].bSleeping)
		{
			gotoState('asleep');
		}
		//else if (SleepyHead >= 0 && Heads[SleepyHead].bSleeping)
		//{
		//	// Head fell asleep.
		//	SleepyHead = -1;
		//	if( FluteFX!=none )
		//	{
		//		FluteFX.Shutdown();
		//		FluteFX = none;
		//	}
		//}
	}

  begin:
	loopAnim('bodybreath', [Type] AT_Combine);
}

//********************************************************************************************************
//GotoState('attacking') called from FluffyHead::Attack()
state attacking
{
begin:
	// Transitional state, in order to return to waking anim.
	for (h=0; h<3; h++)
		Heads[h].bCanAttack = false;
	finishAnim();
	for (h=0; h<3; h++)
		Heads[h].bCanAttack = true;
	gotoState('awake');
}

//********************************************************************************************************
state asleep
{
	ignores TakeSpellEffect;

begin:
	for (h=0; h<3; h++)
		Heads[h].gotoState('all_asleep');
	// For some reason, the shake is delayed, so start it before Fluffy hits ground.
	playerHarry.ShakeView( 1.5, 150, 100 );

	// AE:
	// This sample now has the thump in it as well....
	playSound(sound'HPSounds.Fluffy_sfx.Fluffy_falls_over2');

	playAnim('fullfall', [Type] AT_Replace);
	finishAnim();

	// AE:
	// ...So no need for this one.
//	playSound(sound'HPSounds.critters2_sfx.Fluffy_falls_thump');

	loopAnim('fullonground', [Type] AT_Replace);
	SetCollision( false, false, false );
	bCollideWorld = false;
	TurnOffBlockPlayers();
	TriggerEvent( 'FluffySleep', self, self );
}

//********************************************************************************************************
function TurnOffBlockPlayers()
{
	local BlockPlayer a;

	foreach AllActors(class'BlockPlayer', a, 'BlockPlayerFluffyTag')
		a.Destroy();
}

//********************************************************************************************************

defaultproperties
{
     AttackDist=285
     fAttackTimerStart=5
     fAttackRearAnimRate=0.5
     fAttackLungeAnimRate=1
     ListenTimeL=11
     ListenTimeM=7
     ListenTimeR=4
     SleepTimeL=20
     SleepTimeM=9
     SleepTimeR=2
     CamStateName=Standardstate
     bShowBossHealth=False
     GroundSpeed=0
     Physics=PHYS_Walking
     Group="None,Fluffy"
     AnimSequence=bodybreath
     Mesh=SkeletalMesh'HarryPotter.skfluffyMesh'
     AmbientGlow=75
     CollisionRadius=115
     CollisionHeight=92
     RotationRate=(Pitch=0,Yaw=0,Roll=0)
}
