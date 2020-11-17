// Voldemort's Tracking Spell...
//	authored by:  Paul J. Furio

class spellVoldemortTracking extends BASESPELL;

#exec MESH  MODELIMPORT MESH=SPELLLEVMesh MODELFILE=models\LevProjectile.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SPELLLEVMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SPELLLEVAnims ANIMFILE=models\LevProjectile.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SPELLLEVMesh X=2.0 Y=2.0 Z=2.0
#exec MESH  DEFAULTANIM MESH=SPELLLEVMesh ANIM=SPELLLEVAnims

var baseHarry  playerHarry;

// We also have to kill this early...  It can only live for a few seconds...

function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('all', 2.0, 0.0);
	SetTimer(3.0, false);

	foreach allActors(class'baseHarry', playerHarry)
		if( playerHarry.bIsPlayer && playerHarry!=Self)
			break;
}

//****************************************************************************************************
function Touch(Actor Other)
{
	super.Touch(Other);

	if( baseHarry(Other) != none )
		baseHarry(Other).TakeDamage( Damage, none, Vect(0,0,0), Vect(0,0,0), '');
}

//****************************************************************************************************
function Destroyed()
{
	Super.Destroyed();
}

function Timer()
{
	PlaySound (MiscSound,,3.0*DrawScale);	
	if ( (Mover(Base) != None) && Mover(Base).bDamageTriggered )
		Base.TakeDamage( Damage, instigator, Location, MomentumTransfer * Normal(Velocity), MyDamageType);
	
	HurtRadius(damage/* * Drawscale*/, FMin(250, DrawScale * 75), MyDamageType, MomentumTransfer * Drawscale, Location);

	Destroy();	
}

// Do the turning stuff here...
function Tick(float fDeltaTime)
{
	// Reorient it to face Harry...
	local rotator NewRotation;

	// This is all stolen from a tutorial on making a laser guided Razorgun
	NewRotation = rotator ( playerHarry.Location - Location );
	SetRotation(Rotation + Normalize(NewRotation - Rotation) * fDeltaTime * 6 );
	Velocity = Speed * vector(Rotation);
	
	super.Tick(fDeltaTime);
}

defaultproperties
{
     spellIcon=None
     spellName="VTrack"
     flyParticleEffectClass=Class'HPParticle.SpellVoldTrackingFX'
     hitParticleEffectClass=Class'HPParticle.Repairo_hit'
     Speed=250
     Damage=15
     DrawType=DT_None
     Style=STY_Translucent
     Mesh=None
}
