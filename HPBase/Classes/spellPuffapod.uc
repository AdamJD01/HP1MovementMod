class spellPuffapod extends BASESPELL;

var vector SurfaceNormal;	
var bool bOnGround;
var bool bCheckedSurface;
var int numBio;
//var float wallTime;
var float BaseOffset;

var() float GravityBoost;
var() float LifeTimer;
var() float ExplosionRadius;

#EXEC TEXTURE IMPORT NAME=ectoSpellIcon  FILE=TEXTURES\transSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

//*********************************************************************************************************
function PostBeginPlay()
{
	Super.PostbeginPlay();

	LoopAnim('idle', 1);
}

//*********************************************************************************************************
function Destroyed()
{
	Super.Destroyed();
}

//*********************************************************************************************************
function AdjustLifeTimer(float NewLifeTimer)
{
	LifeTimer = NewLifeTimer;
}

//*********************************************************************************************************
function DoExplode()
{
	local int i, count;
	Playsound(sound 'HPSounds.magic_sfx.s_spell_hit1');
	//PlaySound (MiscSound,,3.0*DrawScale);	

	if ( (Mover(Base) != None) && Mover(Base).bDamageTriggered )
		Base.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
	
	HurtRadius(damage /* * Drawscale*/, ExplosionRadius, MyDamageType, MomentumTransfer * Drawscale, Location);

	//Spawn explode effect
	//spawn(class'FireCrackerExplode');

	PlaySound( sound'HPSounds.menu_sfx.s_menu_click', SLOT_Interact, 1.0, false, 1000.0, 1.0);

	//Spawn some confetti
	count = 20 + FRand()*20;

	for( i = 0; i < count; i++ )
	{
		spawn( class'cWizCrackerConfetti' );

	}

	Destroy();	
}
	
//*********************************************************************************************************
simulated function SetWall(vector HitNormal, Actor Wall)
{
	local vector TraceNorm, TraceLoc, Extent;
	local actor HitActor;
	local rotator RandRot;

	SurfaceNormal = HitNormal;
	//	if ( Level.NetMode != NM_DedicatedServer )
	//		spawn(class'ectoMark',,,Location, rotator(SurfaceNormal));
	RandRot = rotator(HitNormal);
	RandRot.Roll += 32768;
	SetRotation(RandRot);	
	if ( Mover(Wall) != None )
		SetBase(Wall);
}

//*********************************************************************************************************
event Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);

	if( IsInState('Flying') )
		Acceleration.z = -GravityBoost;

	LifeTimer -= DeltaTime;
/*
	if( LifeTimer < 2  &&  !bCrackerSwelling )
	{
		//idle, swell, and shake
		PlayAnim('swell', 2);
		bCrackerSwelling = true;
	}
	else
	if( LifeTimer <1  &&  !bCrackerThrobbing )
	{
		LoopAnim('shake', 1);
		bCrackerThrobbing = true;
	}

	if( LifeTimer < 0 )
		DoExplode();
*/
}

//*********************************************************************************************************
singular function TakeDamage( int NDamage, Pawn instigatedBy, Vector hitlocation, 
						vector momentum, name damageType )
{
	if ( damageType == MyDamageType )
		numBio = 3;
	DoExplode();
}

//*********************************************************************************************************
auto state Flying
{
	function ProcessTouch (Actor Other, vector HitLocation) 
	{ 
		if( Pawn(Other)!=Instigator || bOnGround) 
			DoExplode();
	}

	//* * * * * * * * * * * * * * * * * * * * * * *
	function bump(actor other)
	{
		ProcessTouch( other, vect(0,0,0) );
	}

	simulated function HitWall( vector HitNormal, actor Wall )
	{
		if( (HitNormal dot vect(0,0,1)) > 0.8 )
		{
			ProcessTouch( Wall, Location );

			SetPhysics(PHYS_None);		
			MakeNoise(0.3);	
			bOnGround = True;
			PlaySound(ImpactSound);
			SetWall(HitNormal, Wall);
			PlayAnim('Hit');
			GoToState('OnSurface');
		}
		else
		{
			Velocity *= 0.5;
			Velocity = MirrorVectorByNormal( Velocity, HitNormal );
		}
	}

	function BeginState()
	{	
//		PlaySound( sound'HPSounds.events_sfx.s_writing2', SLOT_Interact, 1.0, false, 1000.0, 1.0);

		if ( Role == ROLE_Authority )
		{
			Velocity = Vector(Rotation) * Speed;
			Velocity.z += 120;
			if( Region.zone.bWaterZone )
				Velocity=Velocity*0.7;
		}

		if ( Level.NetMode != NM_DedicatedServer )
			RandSpin(100000);

		LoopAnim('Flying',0.4);
		bOnGround=False;
		PlaySound(SpawnSound);
	}
}

//***********************************************************************************************************
//state Exploding
//{
//	ignores Touch, TakeDamage;
//
//	function BeginState()
//	{
//		DoExplode();
//	}
//}

//***********************************************************************************************************
state OnSurface
{
	function ProcessTouch (Actor Other, vector HitLocation)
	{
		//Check for it hitting Harry
		if( baseHarry(other) != None  &&  baseHarry(other).CarryingActor == none )
		{
			baseHarry(other).SetCarryingActor(self);

			SetCollision(false, false, false);
			GotoState('HarryCarrying');

		//	PlaySound( sound'HPSounds.critters_sfx.owl_wing_flap', SLOT_Interact, 1.0, false, 1000.0, 1.0);
		}
		else //Check for it hitting malfoy
		if( baseBoss(other) != None )
		{
			SetCollision(false, false, false);

		}
	}

	//* * * * * * * * * * * * * * * * * * * * * * *
	function bump(actor other)
	{
		ProcessTouch( other, vect(0,0,0) );
	}

	//simulated function CheckSurface()
	//{
	//	local float DotProduct;
	//
	//	DotProduct = SurfaceNormal dot vect(0,0,-1);
	//	If( DotProduct > 0.7 )
	//		PlayAnim('Drip',0.1);
	//	else if (DotProduct > -0.5) 
	//		PlayAnim('Slide',0.2);
	//}

	//function Timer()
	//{
	//	if ( Mover(Base) != None )
	//	{
	//		WallTime -= 0.2;
	//		if ( WallTime < 0.15 )
	//			Global.Timer();
	//		else if ( VSize(Location - Base.Location) > BaseOffset + 4 )
	//			Global.Timer();
	//	}
	//	else
	//	{
	//		Global.Timer();
	//	}
	//}

	//function BeginState()
	//{
	//	wallTime = CRACKER_LIFE_SPAN;
	//
	//	//Every now and then make a cracker that is about to go off
	//	if( FRand() < 0.5 )
	//		wallTime = 2;
	//	
	//	if ( Mover(Base) != None )
	//	{
	//		BaseOffset = VSize(Location - Base.Location);
	//		SetTimer(0.2, true);
	//	}
	//	else
	//	{
	//		SetTimer(wallTime, false);
	//		wallTime = 0;
	//	}
	//}

	//simulated function AnimEnd()
	//{
	//	if ( !bCheckedSurface && (DrawScale > 1.0) )
	//		CheckSurface();
	//
	//	bCheckedSurface = true;
	//}
}

//*********************************************************************************
state HarryCarrying
{
	//function Timer()
	//{
	//	local baseHarry a;
	//
	//	foreach AllActors(class'baseHarry', a)
	//	{
	//		SetLocation( a.Location );
	//		break;
	//	}
	//
	//	Global.Timer();
	//}

}

//*********************************************************************************

// For more difficult
//     speed=450.000000
//     MaxSpeed=450.000000
//     GravityBoost=1650;

//     speed=375.000000
//     MaxSpeed=375.000000
//	   GravityBoost=750;

defaultproperties
{
     numBio=9
     GravityBoost=1100
     LifeTimer=4.5
     ExplosionRadius=100
     spellName="EctoMatic"
     Speed=450
     MaxSpeed=450
     MomentumTransfer=20000
     MyDamageType=Corroded
     ImpactSound=None
     Physics=PHYS_Falling
     LifeSpan=12
     AnimSequence=Flying
     Mesh=SkeletalMesh'HPModels.skwizardcrackerMesh'
     DrawScale=0.75
     AmbientGlow=255
     LightBrightness=100
     LightHue=91
     LightRadius=3
     bBounce=True
     Buoyancy=170
}
