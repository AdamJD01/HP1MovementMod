class spellpeevesthrow extends BASESPELL;


#exec MESH  MODELIMPORT MESH=PeeveThrowAppleMesh MODELFILE=..\hprops\models\PeeveThrowAppleMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PeeveThrowAppleMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PeeveThrowAppleAnims ANIMFILE=..\hprops\models\PeeveThrowAppleAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PeeveThrowAppleMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PeeveThrowAppleMesh ANIM=PeeveThrowAppleAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PeeveThrowAppleAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PeeveThrowAppleTex0  FILE=TEXTURES\PeeveThrowAppleTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PeeveThrowAppleMesh NUM=0 TEXTURE=PeeveThrowAppleTex0



var vector SurfaceNormal;	
var bool bOnGround;
var bool bCheckedSurface;
var int numBio;
var float wallTime;
var float BaseOffset;
var vector	PreviousLocation;

#EXEC TEXTURE IMPORT NAME=ectoSpellIcon  FILE=TEXTURES\transSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

function PostBeginPlay()
{
	Super.PostbeginPlay();
	SetTimer(3.0, false);
	PreviousLocation = vect(0, 0, 0);
}

function Destroyed()
{
	Super.Destroyed();
}

function Timer()
{
//	local ut_GreenGelPuff f;

//	f = spawn(class'ut_GreenGelPuff',,,Location + SurfaceNormal*8); 
//	f.numBlobs = numBio;
//	if ( numBio > 0 )
//		f.SurfaceNormal = SurfaceNormal;	

	PlaySound (MiscSound,,3.0*DrawScale);	
	if ( (Mover(Base) != None) && Mover(Base).bDamageTriggered )
		Base.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
	
	HurtRadius(damage/* * Drawscale*/, FMin(250, DrawScale * 75), MyDamageType, MomentumTransfer * Drawscale, Location);

	Destroy();	
}
	
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

singular function TakeDamage( int NDamage, Pawn instigatedBy, Vector hitlocation, 
						vector momentum, name damageType )
{
	if ( damageType == MyDamageType )
		numBio = 3;
	GoToState('Exploding');
}

auto state Flying
{
	function ProcessTouch (Actor Other, vector HitLocation) 
	{ 
		if ( Pawn(Other)!=Instigator || bOnGround) 
			Global.Timer(); 
	}

	simulated function HitWall( vector HitNormal, actor Wall )
	{
		// Check to see if the object has stopped

		PlaySound(ImpactSound);
		if (PreviousLocation != location)
		{
			Velocity *= 0.5;
			Velocity = MirrorVectorByNormal( Velocity, HitNormal );
			PreviousLocation = Location;
		}
		else
		{
			SetPhysics(PHYS_None);		
			MakeNoise(0.3);	
			bOnGround = True;
			SetWall(HitNormal, Wall);
			PlayAnim('Hit');
			GoToState('OnSurface');
		}
	}


	function Timer()
	{
		GotoState('Exploding');	
	}

	function BeginState()
	{	
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

state Exploding
{
	ignores Touch, TakeDamage;

	function BeginState()
	{
		SetTimer(0.1+FRand()*0.2, False);
	}
}

state OnSurface
{
	function ProcessTouch (Actor Other, vector HitLocation)
	{
		GotoState('Exploding');
	}

	simulated function CheckSurface()
	{
		local float DotProduct;

		DotProduct = SurfaceNormal dot vect(0,0,-1);
		If( DotProduct > 0.7 )
			PlayAnim('Drip',0.1);
		else if (DotProduct > -0.5) 
			PlayAnim('Slide',0.2);
	}

	function Timer()
	{
		if ( Mover(Base) != None )
		{
			WallTime -= 0.2;
			if ( WallTime < 0.15 )
				Global.Timer();
			else if ( VSize(Location - Base.Location) > BaseOffset + 4 )
				Global.Timer();
		}
		else
			Global.Timer();
	}

	function BeginState()
	{
		wallTime =0.1;
		
		if ( Mover(Base) != None )
		{
			BaseOffset = VSize(Location - Base.Location);
			SetTimer(0.2, true);
		}
		else 
			SetTimer(wallTime, false);
	}

	simulated function AnimEnd()
	{
		if ( !bCheckedSurface && (DrawScale > 1.0) )
			CheckSurface();

		bCheckedSurface = true;
	}
}

defaultproperties
{
     Speed=400
     MaxSpeed=1500
     MomentumTransfer=20000
     MyDamageType=Corroded
     ImpactSound=None
     Physics=PHYS_Falling
     LifeSpan=12
     Mesh=SkeletalMesh'HPBase.PeeveThrowAppleMesh'
     DrawScale=2
     AmbientGlow=200
     bUnlit=False
     CollisionRadius=2
     CollisionHeight=2
     LightType=LT_None
     bBounce=True
     Buoyancy=170
}
