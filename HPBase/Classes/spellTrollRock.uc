class spellTrollRock extends BASESPELL;
/*
#exec MESH  MODELIMPORT MESH=HagridHutRockMesh MODELFILE=..\HProps\models\HagridHutRock.PSK LODSTYLE=10
//#exec MESH  ORIGIN MESH=HagridHutRockMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HagridHutRockAnims ANIMFILE=..\HProps\models\HagridHutRock.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
//#exec MESHMAP   SCALE MESHMAP=HagridHutRockMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HagridHutRockMesh ANIM=HagridHutRockAnims
// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HagridHutRockAnims VERBOSE
#EXEC TEXTURE IMPORT NAME=HagridHutRockTex0  FILE=..\HProps\TEXTURES\hutstne1_128.bmp  GROUP=Skins
#EXEC MESHMAP SETTEXTURE MESHMAP=HagridHutRockMesh NUM=0 TEXTURE=HagridHutRockTex0
*/

#exec MESH  ORIGIN MESH=HagridHutRockMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0

var vector SurfaceNormal;	
//var bool bOnGround;
var bool bCheckedSurface;
var int numBio;
//var float wallTime;
var float BaseOffset;

var int   NumLives;

var() float GravityBoost;

var()  float LifeTimer;

var() float ExplosionRadius;

var   actor shadow;

var   class<actor>  ShadowClass;

var()   float         ShadowDrawScaleFactor;

var   float         FloorZ;

#EXEC TEXTURE IMPORT NAME=ectoSpellIcon  FILE=TEXTURES\transSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

//*********************************************************************************************************
function PostBeginPlay()
{
	local vector  HitLoc, HitNorm;

	Super.PostbeginPlay();

	SetCollisionSize(CollisionRadius*DrawScale, CollisionHeight*DrawScale);
	LoopAnim('idle', 1);

	shadow = spawn(ShadowClass);//class'HProps.LevShadow');
	shadow.SetRotation( rot(0,0,0) );

	Trace( HitLoc, HitNorm, Location + vect(0,0,-200), Location, false );
	shadow.SetLocation( HitLoc );

	shadow.Style = STY_Modulated;//STY_Translucent;


	FloorZ = HitLoc.z;
}

//*********************************************************************************************************
function Destroyed()
{
	Super.Destroyed();
}

//*********************************************************************************************************
function SetShadowScale()
{
	if( NumLives == 1 )
		ShadowDrawScaleFactor *= 0.5;
	else
	if( NumLives == 0 )
		ShadowDrawScaleFactor *= 0.25;
}

//*********************************************************************************************************
function AdjustLifeTimer(float NewLifeTimer)
{
	LifeTimer = NewLifeTimer;
}

//*********************************************************************************************************
function DoExplode()
{
	local int             i, count;
	local spellTrollRock  a;
	local float           volume;

	volume = 0;

	if( NumLives == 2 )
		volume = 1;
	else
	if( NumLives == 1 )
		volume = 0.3;

	Playsound(sound 'HPSounds.magic_sfx.s_spell_hit1',, volume);
	//PlaySound (MiscSound,,3.0*DrawScale);	

	if ( (Mover(Base) != None) && Mover(Base).bDamageTriggered )
		Base.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
	
	if( NumLives > 0 )
		HurtRadius(damage /* * Drawscale*/, ExplosionRadius, MyDamageType, MomentumTransfer * Drawscale, Location);

	//Spawn explode effect
	//spawn(class'FireCrackerExplode');

	if( NumLives == 2 )
		PlaySound( sound'HPSounds.menu_sfx.s_menu_click', SLOT_Interact, 1.0, false, 1000.0, 1.0);

	//Spawn some chunks
	if( NumLives > 0 )
	{
		if( NumLives == 2 )
			count = 4 + Rand(5);
		else
			count = Rand(4);

		for( i = 0; i < count; i++ )
		{
			a = spawn( class'spellTrollRock' );
			a.Speed = Speed / 2;
			a.Velocity = VRand() * RandRange(0.8, 1.2);
			a.Velocity.z = abs( a.Velocity.z ) * 3;
			a.Velocity *= a.Speed;
			a.NumLives = NumLives - 1;
			a.GravityBoost = GravityBoost;
			a.DrawScale = DrawScale * 0.4;
			a.SetCollisionSize(a.CollisionRadius*a.DrawScale, a.CollisionHeight*a.DrawScale);
			a.Damage = Damage / 3;
			a.SetShadowScale();
		}
	}

	Destroy();	
	shadow.Destroy();
}
	
//*********************************************************************************************************
event Tick(float DeltaTime)
{
	local vector  v;

	Super.Tick(DeltaTime);

	if( IsInState('Flying') )
		Acceleration.z = -GravityBoost;

	v = shadow.Location;
	v.x = Location.x;
	v.y = Location.y;
	shadow.SetLocation( v );//vect(shadow.Location.x, shadow.Location.y, Location.z) );

	shadow.DrawScale = ( 1 / (1 + (FMax(0,Location.z - FloorZ)/1500)) ) * ShadowDrawScaleFactor;
}

//*********************************************************************************************************
auto state Flying
{
	function ProcessTouch (Actor Other, vector HitLocation) 
	{ 
		if(   Pawn(Other) != Instigator
		   && spellTrollRock(Other)==none
		   // || bOnGround) 
		  )
		{
			DoExplode();
		}
	}

	//* * * * * * * * * * * * * * * * * * * * * * *
	function bump(actor other)
	{
		ProcessTouch( other, vect(0,0,0) );
	}

	simulated function HitWall( vector HitNormal, actor Wall )
	{
		ProcessTouch( Wall, Location );

		SetPhysics(PHYS_None);		
		MakeNoise(0.3);	
		//bOnGround = True;
		//PlaySound(ImpactSound);
		//SetWall(HitNormal, Wall);
		//PlayAnim('Hit');
		//GoToState('OnSurface');
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
		//bOnGround=False;
		PlaySound(SpawnSound);
	}
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
     NumLives=2
     GravityBoost=1100
     LifeTimer=4.5
     ExplosionRadius=70
     ShadowClass=Class'HPModels.LevShadow'
     ShadowDrawScaleFactor=1
     spellName="EctoMatic"
     Speed=450
     MaxSpeed=450
     Damage=15
     MomentumTransfer=20000
     MyDamageType=Corroded
     ImpactSound=None
     Physics=PHYS_Falling
     LifeSpan=12
     AnimSequence=Flying
     Mesh=SkeletalMesh'HPModels.skboulderMesh'
     DrawScale=0.5
     AmbientGlow=255
     CollisionRadius=40
     CollisionHeight=35
     LightBrightness=100
     LightHue=91
     LightRadius=3
     bBounce=True
     Buoyancy=170
}
