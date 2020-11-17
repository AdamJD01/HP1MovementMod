//=============================================================================
// baseSpell.
//=============================================================================
class baseSpell extends Projectile;

//Edited by- AdamJD (edited code will have AdamJD by it)

//#exec MESH IMPORT MESH=spellProj ANIVFILE=MODELS\SpellProj_a.3D DATAFILE=MODELS\Cross_d.3D X=0 Y=0 Z=0 //not needed -AdamJD

//#exec MESH ORIGIN MESH=spellProj X=0 Y=0 Z=0 YAW=64
//#exec MESH SEQUENCE MESH=spellProj SEQ=All    STARTFRAME=0   NUMFRAMES=1
//#exec MESH SEQUENCE MESH=spellProj SEQ=Still  STARTFRAME=0   NUMFRAMES=1
//#exec MESHMAP SCALE MESHMAP=spellProj X=0.2 Y=0.2 Z=0.2

//#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPBase.FXPackage //not needed -AdamJD


#EXEC TEXTURE IMPORT NAME=defaultSpellIcon  FILE=TEXTURES\transSpellIcon.bmp GROUP="Icons" FLAGS=2 MIPS=OFF

var Texture spellIcon;
var string spellName;
var Actor target;	//to seek too.       ouch!  not the best variable name!!
var vector InitialDir;

var baseChar  OriginallyCastedBy; //Added this so I dont mess with the "instigator" member.

var sound CastSound;
var string SpellIncantation;
var string QuietSpellIncantation;

//var float manaCost; //not needed -AdamJD

var (VisualEffects)	Mesh projectileMesh;
var (VisualEffects)	class<baseVisualEffect> hitEffect;

var (VisualEffects)ParticleFX flyParticleEffect;
var (VisualEffects)class<ParticleFX> flyParticleEffectClass;

var (VisualEffects)ParticleFX hitParticleEffect;
var (VisualEffects)class<ParticleFX> hitParticleEffectClass;

var (VisualEffects)ParticleFX reactParticleEffect;
var (VisualEffects)class<ParticleFX>reactParticleEffectClass;

// The gesture needed to learn/cast the spell.
var (VisualEffects) gesture Gesture;

// FX for the spell gesture
var (VisualEffects)class<ParticleFX>GestureParticleEffectClass;

//AdamJD vars
var vector		CurrentDir;	
var vector		TargetOffset;
var float 		SeekSpeed;	
var float 		SpellLifeTime;

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();
	PlaySpellCastSound();
	SetTimer(0.1, true);
	if(flyParticleEffectClass!=None)
		{
		flyParticleEffect=spawn(flyParticleEffectClass);
		flyParticleEffect.setRotation(flyParticleEffect.default.rotation);
		}
		
	CurrentDir = vector(rotation); //AdamJD
}

function PlaySpellCastSound()
{
	PlaySound(CastSound, SLOT_Interact,  1.0, false, 2000.0, 1);
}

// AE:
function PlayIncantateSound(bool bSneaking)
{
	// Nothing here.
}

event destroyed()
{
	//	super.destroyed();
	if( flyParticleEffect!=None )
	{
		flyParticleEffect.LifeSpan = 1;
		flyParticleEffect.bEmit = false;
	}
}

event Tick(float deltaTime)
{
	super.Tick(deltaTime);
	if(flyParticleEffect!=None)
		flyParticleEffect.SetLocation(location);
		
	if( (SpellLifeTime -= deltaTime) < 0 )
	{
		Destroy();
	}

}

function AdjustLifeTimer(float NewLifeTimer)
{
	//Implemented in derived class
}

//target offset -AdamJD
function InitSpell(Actor CastedAt, optional vector CastedAtOffset)
{
	target = CastedAt;
	TargetOffset = CastedAtOffset;
}

//spell direction -AdamJD
function SetSpellDirection( vector dir )
{
	CurrentDir	    = normal(dir);
	DesiredRotation = rotator(CurrentDir);
	SetRotation( DesiredRotation );
	flyParticleEffect.SetRotation( DesiredRotation );
}

//hit location -AdamJD
function vector GetTargetHitLocation()	
{ 
	return target.location + TargetOffset;
}

//*************************************************************************************************
auto state Flying
{

	function ProcessTouch (Actor Other, vector HitLocation)
	{
	local baseVisualEffect he;
	local bool             bSpawnHitEffects;
	local bool             bDestroy;

		bDestroy = true;

		Log("Spell ProcessTouch:"$Other);

		playerPawn(Instigator).clientMessage("Spell " $Self $" hit:" $other);

		if( baseProps(Other)!=None )
		{
			if(baseProps(Other).TakeSpellEffect(self))
			{
				bSpawnHitEffects = true;
			}
		}
		else if( baseChar(Other)!=None )
		{
			if(baseChar(Other).TakeSpellEffect(self))
				bSpawnHitEffects = true;

			if( baseChar(Other).bDoesntDestroySpell )
				bDestroy = false;
		}
		else if( baseHarry(Other)!=none && spellFire(self)!=none )
		{
			bSpawnHitEffects = true;
		}
		else if(Other.isa('spelltrigger') && other.bprojtarget == true)
		{
			bSpawnHitEffects = true;
		}

		//You can only derive one layer below a mover.  We're doing it differently anyways...
		//else if( Mirror(Other)!=None)
		//{
		//	if (Mirror(Other).TakeSpellEffect(self))
		//	{
		//		bSpawnHitEffects = true;
		//	}
		//	else
		//	{
		//		Target = None;
		//		return;
		//	}
		//}


		if( bSpawnHitEffects )
		{
			SpawnHitEffects( Other, HitLocation );
		}


		If( bDestroy  &&  Other!=Instigator )
		{
			Explode(HitLocation,Normal(HitLocation-Other.Location));
		}
	} 

	function BeginState()
	{
		Velocity = vector(Rotation) * speed;
		Acceleration = vector(Rotation) * 1000;
	}
}

//*************************************************************************************************
function SpawnHitEffects( Actor Other, vector HitLocation )
{
	PlaySound(ImpactSound, SLOT_Interact,  1.0, false, 2000.0, 1);
	//				playerPawn(Instigator).clientMessage("Spell " $Self $" Effected:" $other);

	if(true)
	{
		hitParticleEffect=Spawn(hitParticleEffectClass,,, HitLocation,rot(0,0,0));
		hitParticleEffect.setRotation(hitParticleEffect.default.rotation);
//		hitParticleEffect.SourceWidth.Base = 20;
//		hitParticleEffect.SourceHeight.Base = 20;
//		hitParticleEffect.SourceWidth.Base=baseProps(Other).collisionRadius;
//		hitParticleEffect.SourceHeight.Base=baseProps(Other).collisionHeight;
		reactParticleEffect=Spawn(reactParticleEffectClass,,, HitLocation,rot(0,0,0));
		reactParticleEffect.setRotation(reactParticleEffect.default.rotation);
		reactParticleEffect.SetOwner(other);
		reactParticleEffect.SourceWidth.Base=baseProps(Other).collisionRadius;

//		log("SpellFX " $string(hitParticleEffect.name) $" " $string(reactParticleEffect.name) $" " $string(other.name));

		//					he=Spawn(hitEffect,,, HitLocation,rot(0,0,0));
		//					if(he.bFollowsOwner)
		//						he.SetOwner(other);
	}
}

//*************************************************************************************************
simulated function Timer()
{
	local vector SeekingDir;
	local float MagnitudeVel;
	local vector aimPoint;
	local BoundingBox	TargetArea;

	//////local baseHarry p;

	//////foreach allactors(class'baseHarry',p)
	//////	break;
	//////p.Clientmessage("*** 1");

	if ( InitialDir == vect(0,0,0) )
		InitialDir = Normal(Velocity);

	//	playerPawn(Instigator).clientMessage("Tracking to:"$target);

	if( (Target != None) && (Target != Instigator) ) 
	{
		//p.Clientmessage("*** 2");
			//target the Middle of the Object.
		//		aimPoint=Target.Location;
		TargetArea = Target.GetWorldCollisionBox(true);
		aimPoint = ((TargetArea.Max -  TargetArea.Min) / 2) + TargetArea.Min + Target.CentreOffset;


		//@PAB removed this, as this caused the spell to go upwards far too much
				//aimPoint.Z+=(target.CollisionHeight)+2;

		SeekingDir = Normal(aimPoint - Location);
		if ( (SeekingDir Dot InitialDir) > 0 )
		{
			//////p.Clientmessage("*** 3");
			MagnitudeVel = VSize(Velocity);
			SeekingDir = Normal(SeekingDir * 0.5 * MagnitudeVel + Velocity);
			Velocity =  MagnitudeVel * SeekingDir;	
			Acceleration = 25 * SeekingDir;	
			//			SetRotation(rotator(Velocity));
		}
	}

		//drop off puffs as it flys
		//b = Spawn(class'ut_SpriteSmokePuff');
}


function Explode(vector HitLocation,vector HitNormal)
{
Log("******** Explode:"$self);	
//	PlaySound(ImpactSound, SLOT_Interact,  1.0, false, 2000.0, 1);
//	HurtRadius(Damage, 70, 'jolted', MomentumTransfer, Location );

	
//	Spawn(class'SpellHit',,, HitLocation+HitNormal*8,rotator(HitNormal));

	Destroy();
}

//not needed -AdamJD
// function static Texture GetSpellIcon()
// {
	// return(default.spellIcon);
// }

//Mover::IsRelevant calls this
function bool IsRelevantToMover()
{
	if( spellFlip(self) != none )
		return true;
	else
		return false;
}

defaultproperties
{
     spellIcon=Texture'HPBase.Icons.defaultSpellIcon'
     spellName="baseSpell"
     CastSound=Sound'HPSounds.magic_sfx.spell_cast'
     //manaCost=10 //not needed -AdamJD
     projectileMesh=LodMesh'HPBase.spellProj'
     GestureParticleEffectClass=Class'HPParticle.Les_SpellShape'
     Speed=170
     Damage=5
     ImpactSound=Sound'HPSounds.magic_sfx.spell_hit'
     bNetTemporary=False
     RemoteRole=ROLE_SimulatedProxy
     LifeSpan=10
     //Mesh=LodMesh'HPBase.spellProj' //not needed -AdamJD
     DrawScale=0.3
     bUnlit=True
     CollisionRadius=5
     CollisionHeight=5
     bProjTarget=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightBrightness=201
     LightHue=165
     LightSaturation=72
     LightRadius=10
     bFixedRotationDir=True
	 SeekSpeed=7.0f //AdamJD
	 SpellLifeTime=8.0 //AdamJD
}
