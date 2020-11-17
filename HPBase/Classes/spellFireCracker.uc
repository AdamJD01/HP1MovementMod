class spellFireCracker extends BASESPELL;

/*
#exec MESH IMPORT MESH=BioGelm ANIVFILE=MODELS\nGel_a.3D DATAFILE=MODELS\nGel_d.3D X=0 Y=0 Z=0
#exec MESH ORIGIN MESH=BioGelm X=-45 Y=0 Z=0 YAW=0 PITCH=-64 ROLL=0
#exec MESH SEQUENCE MESH=BioGelm SEQ=All     STARTFRAME=0   NUMFRAMES=56
#exec MESH SEQUENCE MESH=BioGelm SEQ=Flying  STARTFRAME=0   NUMFRAMES=13
#exec MESH SEQUENCE MESH=BioGelm SEQ=Still   STARTFRAME=13  NUMFRAMES=1
#exec MESH SEQUENCE MESH=BioGelm SEQ=Hit     STARTFRAME=14  NUMFRAMES=10
#exec MESH SEQUENCE MESH=BioGelm SEQ=Drip    STARTFRAME=24  NUMFRAMES=13
#exec MESH SEQUENCE MESH=BioGelm SEQ=Slide   STARTFRAME=37  NUMFRAMES=7
#exec MESH SEQUENCE MESH=BioGelm SEQ=Shrivel STARTFRAME=44  NUMFRAMES=12
#exec TEXTURE IMPORT NAME=Jgreen FILE=MODELS\green.PCX
#exec MESHMAP SCALE MESHMAP=BioGelm X=0.04 Y=0.04 Z=0.08
#exec MESHMAP SETTEXTURE MESHMAP=BioGelm NUM=1 TEXTURE=Jgreen
#exec MESH NOTIFY MESH=BioGelm SEQ=Drip TIME=0.6 FUNCTION=DropDrip
*/

var vector SurfaceNormal;	
var bool bOnGround;
var bool bCheckedSurface;
var int numBio;
//var float wallTime;
var float BaseOffset;

var() float GravityBoost;

var  bool bExplodeOnContact;

var()  float LifeTimer;

var  bool  bCrackerSwelling;
var  bool  bCrackerThrobbing;

var() float ExplosionRadius;

var   int    iKeepResettingVel;
var   vector vInitialVelSave;

var   baseHarry  playerHarry;

#EXEC TEXTURE IMPORT NAME=ectoSpellIcon  FILE=TEXTURES\transSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

//*********************************************************************************************************
function PostBeginPlay()
{
	Super.PostbeginPlay();

	LoopAnim('idle', 1);

	foreach AllActors(class'baseHarry', playerHarry)
		break;

	switch( Rand(3) )
	{
		case 0:    Mesh = Mesh'HPModels.skwizardcrackergreenMesh';    break;
		case 1:    Mesh = Mesh'HPModels.skwizardcrackerpurpleMesh';   break;
		case 2:    Mesh = Mesh'HPModels.skwizardcrackeryellowMesh';   break;
	}
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
	local int          i, count;
	local FireCracker  a;

	Playsound(sound 'HPSounds.hub1_sfx.MAL_candy_explodes', SLOT_none, [Radius]3000, [Pitch]RandRange(0.9, 1.1) );
	//PlaySound (MiscSound,,3.0*DrawScale);	

	if ( (Mover(Base) != None) && Mover(Base).bDamageTriggered )
		Base.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
	
	HurtRadius(damage /* * Drawscale*/, ExplosionRadius, MyDamageType, MomentumTransfer * Drawscale, Location);

	//Spawn explode effect
	//spawn(class'FireCracker');//FireCrackerExplode');

	//PlaySound( sound'HPSounds.menu_sfx.s_menu_click', SLOT_Interact, 1.0, false, 1000.0, 1.0);

	//Spawn some confetti
	//count = 20 + FRand()*20;

	for( i = 0; i < 5/*count*/; i++ )
	{
		a = spawn( class'FireCracker' );//cWizCrackerConfetti' );

		count = Rand(3);
	
		switch( count )
		{
			case 0:
				a.ColorStart.Base.r = 29;
				a.ColorStart.Base.g = 17;
				a.ColorStart.Base.b = 255;
				a.ColorEnd.Base.r = 255;
				a.ColorEnd.Base.g = 128;
				a.ColorEnd.Base.b = 0;
				break;
			case 1:
				a.ColorStart.Base.r = 254;
				a.ColorStart.Base.g = 18;
				a.ColorStart.Base.b = 24;
				a.ColorEnd.Base.r = 24;
				a.ColorEnd.Base.g = 218;
				a.ColorEnd.Base.b = 3;
				break;
			case 2:
				a.ColorStart.Base.r = 255;
				a.ColorStart.Base.g = 213;
				a.ColorStart.Base.b = 15;
				a.ColorEnd.Base.r = 175;
				a.ColorEnd.Base.g = 11;
				a.ColorEnd.Base.b = 255;
				break;
		}

		a.Gravity.z = -(30 + Rand(4)*30);
	}

	Destroy();	
}

//*********************************************************************************************************
// If HurtRadius hits harry, and the cracker was thrown by Malfoy, then tell malfoy to play his "Hit Harry" sounds.
function bool HurtRadiusCallBack( Actor a )
{
	if( baseHarry(a) != none )
	{
		baseHarry(a).TakeDamage( 7, none, Location, vect(0,0,0), '');
		return false;  //dont let HurtRadius hurt this actor
	}

	return true;
}

//*********************************************************************************************************
function ActorPickedUp()
{
	Playsound(sound 'HPSounds.hub1_sfx.MAL_candy_pickup');
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

	if( LifeTimer < 2  &&  !bCrackerSwelling )
	{
		// AE:
		PlaySound(sound'HPSounds.Hub1_sfx.Cracker_Stretch_01');

		//idle, swell, and shake
		PlayAnim('swell', 2);
		bCrackerSwelling = true;
	}
	else
	if( LifeTimer < 1  &&  !bCrackerThrobbing )
	{
		LoopAnim('shake', 1);
		bCrackerThrobbing = true;
	}
	else
	if( LifeTimer < 1 )
	{
		//If held by harry, just force the timer to 1 second.  This'll happen every tick, that's what we want, biznatch.
		if( playerHarry.CarryingActor == self )
			LifeTimer = 1;
		else
		if( LifeTimer < 0 )
			DoExplode();
	}

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
		Log("************ Cracker ProcessTouch:"$Other);
		if( Pawn(Other)!=Instigator || bOnGround)
			DoExplode();
	}

	function Touch(Actor Other)
	{
		Log("************ Cracker Touch:"$Other);
		super.Touch(Other);
		
	}

	//* * * * * * * * * * * * * * * * * * * * * * *
	function bump(actor other)
	{
		ProcessTouch( other, vect(0,0,0) );
	}

	function Tick(float dtime)
	{
		Global.Tick(dtime);

		//This is my feeble attempt to try and figure out what's wrong with the wizard cracker
		if( iKeepResettingVel > 0 )
		{
			Velocity = vInitialVelSave;
			iKeepResettingVel--;
		}
	}

	simulated function HitWall( vector HitNormal, actor Wall )
	{
		//Frick this, I'm getting a HitWall event on Harry.
		if( baseHarry(Wall) != none )
		{
			Log("************ Cracker HitWall:"$Wall$" vel:"$Velocity);
			return;//
		}

		//See if we're on a 'flat' surface.
		if( (HitNormal dot vect(0,0,1)) > 0.8 )
		{
			if( bExplodeOnContact )
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
			Log("************ Cracker V.x.y=0:"$Wall);
			//Velocity *= 0.5;
			//Velocity = MirrorVectorByNormal( Velocity, HitNormal );
			Velocity.x = 0;
			Velocity.y = 0;
		}
	}

	function BeginState()
	{	
		PlaySound( sound'HPSounds.hub1_sfx.Malfoy_throws', SLOT_Interact, 1.0, false, 1000.0, 1.0);

		if ( Role == ROLE_Authority )
		{
			Log("********** in BeginState, ROLE_Authority");
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

			//PlaySound( sound'HPSounds.critters_sfx.owl_wing_flap', SLOT_Interact, 1.0, false, 1000.0, 1.0);
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
     Damage=20
     MomentumTransfer=20000
     MyDamageType=Corroded
     ImpactSound=Sound'HPSounds.Hub1_sfx.MAL_candy_hits_floor'
     Physics=PHYS_Falling
     LifeSpan=0
     AnimSequence=Flying
     Mesh=SkeletalMesh'HPModels.skwizardcrackerMesh'
     DrawScale=0.75
     AmbientGlow=100
     bUnlit=False
     LightType=LT_None
     LightEffect=LE_None
     LightBrightness=100
     LightHue=91
     LightRadius=3
     bBounce=True
     Buoyancy=170
}
