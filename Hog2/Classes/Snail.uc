class Snail expands baseChar;

//enum eBehavior
//{
////	BEHAVE_RANDOM_WANDER,
//	BEHAVE_BACK_FORTH_NAV_POINT,
//	BEHAVE_PATROL,
//};

//var() eBehavior  Behavior;

var int hitCount;
var sound peevesVoice;

var ParticleFX ParticleFXActor;
var float SpawnGooColBoxTimer;
var vector vLastGooSpawnLoc;

//var	rotator vMoveDirRot;
var vector vMoveDir;

var bool    bLookForHarry;
var vector  vOriginalLoc;
var /*()*/ float WanderDistance;
var float   TetherCheckTimer;
var bool    bOutsideOfTether;

var int     iMovingToNode;
var vector  vNavigationPointLoc[2];

const MAX_ROT_VEL = 200.0;
var   float fRotVel;
var() float fStunTime;

var /*()*/ name NavigationPointTag;

var   Rotator TmpRot;

var() float   fSnailTrailLife;

var() bool    bOnlySendTriggerOnce;

function PostBeginPlay()
{
	local baseWand         weap;
	local NavigationPoint  a;
	local float            d, dBest;

//	Super.PostBeginPlay();

//	weap=spawn(class'baseWand');
//	weap.BecomeItem();
//	AddInventory(weap);
//	weap.WeaponSet(self);
//	weap.GiveAmmo(self);
//	weap.SelectSpell(Class'spellEcto');

//	bCollideWorld = true;

	//SetPhysics(PHYS_Walking);

//	SetCollision( true, true, true );
//	SetCollisionSize( 10*DrawScale, 10*DrawScale );   //float NewRadius, float NewHeight );

	vMoveDir.x = 1;
	vMoveDir.y = 0;
	vMoveDir.z = 0;
	//vMoveDirRot.yaw = 65536.0*FRand();
	//vMoveDirRot.pitch = 0;
	//vMoveDirRot.roll = 0;
	//vMoveDir = vMoveDir>>vMoveDirRot;

	//SetRotation( vMoveDirRot );

	vOriginalLoc = location;
	bOutsideOfTether = false;

	fRotVel = 0;

	SpawnGooColBoxTimer = 0;
	ParticleFXActor = spawn(class'SnailTrailFX',,,Location);

	ParticleFXActor.Lifetime.Base = fSnailTrailLife;
	
	//switch( Behavior )
	//{
	////case BEHAVE_RANDOM_WANDER:
	////	GotoState('stateRandomWander');
	////	break;
	//case BEHAVE_BACK_FORTH_NAV_POINT:
	//	//Find the matching nav point
	//	vNavigationPointLoc[1] = Location + vector(Rotation)*400;
	//	dBest = 100000;
	//	foreach AllActors(class'NavigationPoint', a, NavigationPointTag)
	//	{
	//		d = VSize(a.Location - Location);
	//		if( d < dBest)
	//		{
	//			dBest = d;
	//			vNavigationPointLoc[1] = a.Location;
	//		}
	//	}
	//
	//	vNavigationPointLoc[0] = vOriginalLoc;
	//
	//	SwitchDirections();
	//
	//	GotoState('stateBackAndForthNavPoint');
	//	break;
	//case BEHAVE_PATROL:
	//	GotoState('patrol');
	//	break;
	//}
	//

	SetTimer( RandRange(3.0, 8.0), true );
}

//*************************************************************************************************************************
function Timer()
{
	SetTimer( RandRange(3.0, 8.0), true );

	if( Rand(2) == 0 )
		PlaySound(sound'HPSounds.Snail_sfx.snail_slither1', SLOT_none, RandRange(0.8, 1.0), [Pitch]RandRange(0.8, 1.1) );
	else
		PlaySound(sound'HPSounds.Snail_sfx.snail_slither2', SLOT_none, RandRange(0.8, 1.0), [Pitch]RandRange(0.8, 1.1) );
}

////*************************************************************************************************************************
//event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, name DamageType)
//{
//	//	playerHarry.clientMessage(self $":I've been shot!");
//	//	gotostate ('shot');
//}

//function bool TakeSpellEffect(baseSpell spell)
//{
//	local vector spawnLoc;
//	local actor newSpawn;
//
//	//if(spell.class==class'spellVerd')
//	//{
//	//	hitCount--;
//	//	if(!IsInState('dieing'))
//	//		gotostate ('shot');
//	//}
//
//	GotoState('stateStunned');
//}

//*************************************************************************************************************************
//Called from BaseChar::TakeSpellEffect
function bool HandleFlipSpell()
{
	//PlaySound(sound 'HPSounds.peeves_sfx.pee_004', SLOT_Interact, 3.2, false, 2000.0, 1.0);
	
	//if( --iNumSpellHitsToFlip <= 0 )
	//{
	//	GotoState('DoFlip');
	//}
	//else
	//{
	//	// Play some sort of a temp hit anim
	//	GotoState('stateHitBySpell');
	//}

	if( Event != '' )
	{
		TriggerEvent(Event, self, self);

		if( bOnlySendTriggerOnce )
			Event = '';
	}

	GotoState('stateStunned');

	//Stay a flip target
	bFlipTarget = true;
}

//*********************************************************
function touch(actor other)
{
	//If the snail hit anything other than his own collision objects, or a spell
	if( SnailTrailColObj(other) == none  &&  baseSpell(other) == none  &&  other.bBlockActors )
	{
		//SwitchDirections();
		if( bFollowPatrolPoints )
		{
			Log("Snail " $ self $ " turn around from touching " $ other);
			//Dont know how to break out of the latent MoveTo, so go to a new state, and then back to patrol
			bGoBackToLastNavPoint = true;
			GotoState('stateGotoPatrol');
		}

		//PlayerHarry.ClientMessage("hit:"@other);
	}

	//If hit harry, do some damage to him
	if( baseHarry(other) != none )
	{
		if( !baseHarry(other).IsInState('hit') )
		{
			baseHarry(other).Acceleration = vect(0,0,0);
			baseHarry(other).TakeDamage( 5, none, vect(0,0,0), Vect(0,0,0), '');
		}

		GotoState('stateStunned');
	}
}

//****************************
state stateGotoPatrol
{
  Begin:
	GotoState('Patrol');
}

//*********************************************************
function bump(actor other)
{
	touch( other );
}

//*********************************************************
function HitWall(vector HitNormal, actor Wall)
{
	//SetLocation( OldLocation );//+ (HitNormal * 50));
	//Find a new vMoveDir
	touch(Wall);
}


//*********************************************************
//function PawnAtStation()
//{
//	//SetLocation( Location + vect(0,0,50) );
//}


//state stateBackAndForthNavPoint
//{
//	//* * * * * * * * * * * * * * * * * * * * * * *
//	function touch(actor other)
//	{
//		if( SnailTrailColObj(other) == none )
//		{
//			SwitchDirections();
//			PlayerHarry.ClientMessage("hit:"@other);
//		}
//	}
//
//	//* * * * * * * * * * * * * * * * * * * * * * *
//	function bump(actor other)
//	{
//		touch( other );
//	}
//
//	//* * * * * * * * * * * * * * * * * * * * * * *
//	function HitWall(vector HitNormal, actor Wall)
//	{
//		//SetLocation( OldLocation );//+ (HitNormal * 50));
//		//Find a new vMoveDir
//		touch(Wall);
//	}
//
//	event Tick(float DeltaTime)
//	{
//		local vector v;
//		local float  d;
//
//		Global.Tick(DeltaTime);
//
//		v = vNavigationPointLoc[iMovingToNode] - Location;
//		v.z = 0;
//		d = VSize(v);
//		v = normal(v);//v /= d;
//		if( d <= GroundSpeed * DeltaTime )
//		{
//			SwitchDirections();
//		}
//		else
//		{
//			MoveSmooth( v * GroundSpeed * DeltaTime );
//			//SetRotation
//		}
//	}
//
//  Begin:
//
//	//	loopAnim('idleslow');
//  actionloop:
//	sleep(1);
//	goto 'actionloop';
//
//}
//

//// *************************************************************
//function SwitchDirections()
//{
//	iMovingToNode = (iMovingToNode+1)%2;
//	//vMoveDirRot = rotator( vNavigationPointLoc[iMovingToNode] - Location );
//	vMoveDir = Normal( vNavigationPointLoc[iMovingToNode] - Location );
//	gotostate( 'TurnToNewDir' );
//}

//*************************************************************
state stateStunned
{
	function touch(actor other)
	{
		//Do nothing for a touch.
	}

  Begin:

	if( Rand(2) == 0 )
		PlaySound(sound'HPSounds.Snail_sfx.snail_ouch1', SLOT_none, RandRange(0.8, 1.0), [Pitch]RandRange(0.8, 1.1) );
	else
		PlaySound(sound'HPSounds.Snail_sfx.snail_ouch2', SLOT_none, RandRange(0.8, 1.0), [Pitch]RandRange(0.8, 1.1) );

	Velocity = vect(0,0,0);
	Acceleration = vect(0,0,0);
	loopanim('idlefast');
	TurnTo(location + vector(Rotation + rot(0,21845,0)));
	TurnTo(location + vector(Rotation + rot(0,21845,0)));
	TurnTo(location + vector(Rotation + rot(0,21846,0)));
	PlayAnim('idle2stun');
	FinishAnim();
	Sleep( fStunTime );
	PlayAnim('stun2idle');
	FinishAnim();
	loopanim('idleslow');

	//You might get stunned in mid turn
	//TurnTo( location + vMoveDir );

	//switch( Behavior )
	//{
	////case BEHAVE_RANDOM_WANDER:
	////	GotoState('stateRandomWander');
	////	break;
	//case BEHAVE_BACK_FORTH_NAV_POINT:
	//	GotoState('stateBackAndForthNavPoint');
	//	break;
	//case BEHAVE_PATROL:
		GotoState('patrol');
	//	break;
	//}

	goto 'Begin';
}


//state stateRandomWander
//{
//
//}
//auto state patrol
//{
//	//	//* * * * * * * * * * * * * * * * * * * * * * *
//	//	function touch(actor other)
//	//	{
//	//		//	PlaySound(sound 'filch', SLOT_Interact, 3.2, false, 2000.0, 1.0);
//	//		//	playerHarry.clientMessage(self $":" $other $" touched me!");
//	//		//playerHarry.clientMessage(self $":touch");
//	//		//gotostate('attackHarry');
//	//		playerHarry.clientMessage(self $":touch");
//	//	}
//	//
//	//	//* * * * * * * * * * * * * * * * * * * * * * *
//	//	function bump(actor other)
//	//	{
//	//		touch( other );
//	//	}
//
//	//* * * * * * * * * * * * * * * * * * * * * * *
//	function HitWall(vector HitNormal, actor Wall)
//	{
//		SetLocation( OldLocation );//+ (HitNormal * 50));
//		//Find a new vMoveDir
//
//		vMoveDir.x = 1;
//		vMoveDir.y = 0;
//		vMoveDir.z = 0;
//		vMoveDirRot = rotator(HitNormal);
//		vMoveDirRot.yaw += 65536.0*(8.0/20.0)/2.0*((FRand()*2.0)-1.0);
//		vMoveDirRot.pitch = 0;
//		vMoveDirRot.roll = 0;
//		vMoveDir = vMoveDir>>vMoveDirRot;
//
//		fRotVel = 0;
//
//		//PlaySound(sound 'HPSounds.peeves_sfx.pee_004', SLOT_Interact, 3.2, false, 2000.0, 1.0);
//		//playerHarry.clientMessage(self $":HitWall");
//		gotostate('TurnToNewDir');
//		//vMoveDir = -vMoveDir;
//	}
//
	//* * * * * * * * * * * * * * * * * * * * * * *
	//function Tick(float DeltaTime)
	event Tick(float DeltaTime)
	{
		local vector newloc;
		local actor  a;

		//	fRotVel += DeltaTime * 1000.0 * (FRand()*1.98 - 1.0); //FRand tends towards 1 rather than 0
		//	fRotVel = FClamp( fRotVel, -MAX_ROT_VEL, MAX_ROT_VEL );
		//	vMoveDirRot.yaw += fRotVel;
		//	//playerHarry.clientMessage(fRotVel);
		//	vMoveDir = vector( vMoveDirRot );
		//	SetRotation( vMoveDirRot );
		//
		//	MoveSmooth( vMoveDir * GroundSpeed * DeltaTime);
		//	//Acceleration = vMoveDir * 500;
		//	//Velocity = vMoveDir * 1000; //*speed;
		//	//AirSpeed=500;
		//	//AutonomousPhysics( DeltaTime );

		ParticleFXActor.SetLocation( Location - vec(0, 0, CollisionHeight*1.0) );

		//	//Now, check and see if we've gone past our tether distance
		//	TetherCheckTimer += DeltaTime;
		//	if( TetherCheckTimer > 0.5 )
		//	{
		//		TetherCheckTimer = 0;
		//		if( VSize( location - vOriginalLoc ) > WanderDistance )
		//		{
		//			if( !bOutsideOfTether )
		//			{
		//				bOutsideOfTether = true;
		//
		//				//For now, just turn and face back to the tether
		//				vMoveDir = Normal( vOriginalLoc - Location );
		//				vMoveDirRot = rotator( vMoveDir );
		//				gotostate('TurnToNewDir');
		//				fRotVel = 0;
		//			}
		//		}
		//		else
		//		{
		//			bOutsideOfTether = false;
		//		}
		//	}

		//Inc our spawn goo col box timer
		SpawnGooColBoxTimer += DeltaTime;
		if( SpawnGooColBoxTimer > 0.5 )
		{
			SpawnGooColBoxTimer = 0;
		
			// if '20' changes, change the radius in SnailTrailColObj.uc
			//   I really should grab it from the default props somehow
			if( VSize(Location - vLastGooSpawnLoc) > 20 )
			{
				vLastGooSpawnLoc = Location;
				//Let SnailTrailColObj have a mesh to see how long it's lasting
				a=spawn( class'SnailTrailColObj',,,Location );
				a.LifeSpan = ParticleFXActor.Lifetime.Base;
				a.LifeSpan *= 0.9;
				//playerHarry.clientMessage(self $":Lifespan:"$a.LifeSpan);
			}
		}
	}

//  Begin:
//	AirSpeed=500;
//	loopAnim('idleslow');
//	//loopAnim('idlefast');
//
//  actionloop:
//
//	if( 0==1 )//CanSee(playerHarry))
//	{
//		playerHarry.clientMessage(self $":I see harry!");
//		PlaySound(sound 'HPSounds.peeves_sfx.pee_004', SLOT_Interact, 3.2, false, 2000.0, 1.0);
//
//		loopAnim('seeharry');
//		finishAnim();
//		gotostate('attackHarry');
//	}
//	
//	if( 0==1 )//FRand()<0.2)
//	{
//		if(FRand()<0.5)
//			loopAnim('look');
//		else
//			loopAnim('scheming');
//		finishAnim();
//	}
//
//	//Velocity = vMoveDir * 1000; // *speed;
//
//	sleep(1);
//	goto 'actionloop';
//
//}

//*************************************************************************************************************************
state TurnToNewDir
{
  begin:

	//loopAnim('attackfloat');

  wait:
	sleep( 0.5 );
		
	TurnTo( location + vMoveDir );

	//switch( Behavior )
	//{
	////case BEHAVE_RANDOM_WANDER:
	////	GotoState('stateRandomWander');
	////	break;
	//case BEHAVE_BACK_FORTH_NAV_POINT:
	//	GotoState('stateBackAndForthNavPoint');
	//	break;
	//case BEHAVE_PATROL:
		GotoState('patrol');
	//	break;
	//}

	goto 'wait';

}

//	PlaySound(sound 'own_good', SLOT_Interact, 3.2, false, 2000.0, 1.0);
//	PlaySound(sound 'please', SLOT_Interact, 3.2, false, 2000.0, 1.0);
//	PlaySound(sound 'own_good', SLOT_Interact, 3.2, false, 2000.0, 1.0);
//	PlaySound(sound 'student', SLOT_Interact, 3.2, false, 2000.0, 1.0);

//state attackHarry
//{
//
//  begin:
//
//	loopAnim('attackfloat');
//	//		AirSpeed=+00200.000000;
//	//		playerHarry.clientMessage(self $":I see harry!");
//
//  wait:
//	//sleep(3);
//		
//	TurnToward(playerHarry);
//	gotostate('throwing');
//	//		MoveToward(playerHarry);
//	goto 'wait';
//
//}

//state throwing
//{
//  begin:
//		loopAnim('throwobject1');
//		finishanim();
//		target=playerHarry;
//		baseWand(weapon).CastSpell(playerHarry);
//		loopAnim('throwobject2');
//		finishanim();
//
//		//gotostate('attackHarry');
//
//		gotostate('patrol');
//}

defaultproperties
{
     hitCount=4
     WanderDistance=175
     fStunTime=1.5
     fSnailTrailLife=2
     bOnlySendTriggerOnce=True
     bFlipTarget=True
     walkAnimName=idleslow
     idleAnimName=idleslow
     GroundSpeed=110
     AirSpeed=80
     AccelRate=4000
     MaxStepHeight=1
     MenuName="OrangeSnail"
     Physics=PHYS_Walking
     eVulnerableToSpell=SPELL_Flipendo
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skorangesnailMesh'
     DrawScale=2.5
     bProjTarget=True
     Mass=130
}
