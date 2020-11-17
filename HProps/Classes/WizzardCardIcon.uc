//===============================================================================
//  [WizzardCardIcon] 
//===============================================================================

class WizzardCardIcon extends HProps;
#exec MESH  MODELIMPORT MESH=WizzardCardIconMesh MODELFILE=models\WizzardCardIconMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=WizzardCardIconMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=WizzardCardIconAnims ANIMFILE=models\WizzardCardIconAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=WizzardCardIconMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=WizzardCardIconMesh ANIM=WizzardCardIconAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=WizzardCardIconAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=WizzardCardIconTex0  FILE=TEXTURES\WizzardCardIconTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=WizzardCardIconMesh NUM=0 TEXTURE=WizzardCardIconTex0

// Original material [0] is [SKIN00.MASKED.TWOSIDED] SkinIndex: 0 Bitmap: WizzardCardIcon.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 

var rotator newrot;

var vector	StartPoint;
var float	fHeight;
var	float	fTimeToTargetPoint;
var float	fTimeToWait;
var	float	fStartTimeToTargetPoint;

var string	WizardName;
var int		ID;

var WizCardSpin		SpinFX;

var vector	PreviousLocation;
var bool	bBouncingState;

function PreBeginPlay()
{
	Super.PreBeginPlay ();
}

function Spawned()
{
	local ParticleFX	explosion;

//	log("Wizardcard spawned!");
	SetPhysics(PHYS_Falling);
	bBouncingState = true;
	PlaySound(sound'HpSounds.magic_sfx.pickup_wizardcard', SLOT_TALK);
	PlaySound(sound'HpSounds.magic_sfx.wizardcard_rotate');
	explosion = spawn(class'WizCard_explo', [spawnlocation] location);
	explosion = spawn(class'Spawn_Flash_1', [spawnlocation] location);

	gotostate('bouncing');
}

function PostBeginPlay()
{
	Super.PostBeginPlay ();
	log("PostbeginPlay Card"@self@Name@Class@ WizardName @"Id"@ ID);
}

state Rising
{
	function BeginState()
	{
		StartPoint = location;
		fStartTimeToTargetPoint = fTimeToTargetPoint;
		bcollideworld = false;
		SetCollision(false, false, false);
		SetPhysics(PHYS_None);

		StopSound(sound'HpSounds.magic_sfx.wizardcard_rotate');
		PlaySound(sound'HpSounds.magic_sfx.pickup_wizardcard2');

		SpinFX = spawn(class'WizCardSpin', [spawnlocation] location);
		SpinFX.SetPhysics(PHYS_Trailer);
		SpinFX.setowner(self);
		SpinFX.AttachToOwner();
	}

	function tick(float deltatime)
	{
		local float				NewHeight;
		local vector			NewTargetPoint;
		local WizCard_explo2	explosion;

		if (fTimeToTargetPoint > 0)
		{
			fTimeToTargetPoint -= deltatime;
			NewHeight = fHeight * (fStartTimeToTargetPoint - fTimeToTargetPoint) / fStartTimeToTargetPoint;
			NewTargetPoint = StartPoint;
			NewTargetPoint.z = NewTargetPoint.z + NewHeight;
			SetLocation(NewTargetPoint);
		}
		else if (fTimeToWait > 0)
		{
			fTimeToWait -= deltatime;
		}
		else
		{
			explosion = spawn(class'WizCard_explo2', [spawnlocation] location);
			SpinFX.Shutdown();
			destroy();
		}

		newrot = rotation;
		newrot.yaw = newrot.yaw + (200000 * deltatime * (fStartTimeToTargetPoint - fTimeToTargetPoint) / fStartTimeToTargetPoint);
		setrotation(newrot);
	}
}

state bouncing
{
	function HitWall( vector HitNormal, actor Wall )
	{
		log("WizardIcon: Hit wall");
		Velocity *= 0.5;
		Velocity = MirrorVectorByNormal( Velocity, HitNormal );
		
		if (vsize(previousLocation - location) < 0.1)
		{
			log("WizardIcon: Hit wall, move to state wait");
			gotostate('wait');
		}
		previousLocation = location;
	}

	function tick (float delta)
	{
		newrot=rotation;
		newrot.yaw=newrot.yaw+(50000*delta);
	
		setrotation(newrot);
	}

	function touch(actor other)
	{
		if (other.isa('baseharry'))
		{
			Velocity *= 0.5;
			Velocity = -Velocity;
		}

//		Velocity = MirrorVectorByNormal( Velocity, HitNormal );
	}
}

auto state wait
{

	function HitWall( vector HitNormal, actor Wall )
	{
/*		Velocity *= 0.5;
		Velocity = MirrorVectorByNormal( Velocity, HitNormal );*/
	}
		
function Touch (actor other)
{
	local baseHarry harry;
	local baseConsole c;

	harry = baseHarry(other);

	if (other.isa('broomharry'))
	{
		Harry.addcard(ID);
		Destroy();
	}
	else if (harry != None)
	{
//		HPConsole(Harry.player.console).ShowMenuBook("FOLIO");
		Harry.addcard(ID);
		Harry.SaveStateName();
		Harry.DesiredRotation = rotator(location - Harry.Location);
		Harry.GotoState('PickingUpWizardCard');
		GotoState('Rising');
	}
}

function tick (float delta)
{
	if (bBouncingState)
	{
		bBouncingState = false;
		gotostate('bouncing');
	}

	newrot=rotation;
	newrot.yaw=newrot.yaw+(50000*delta);
	
	setrotation(newrot);
}

	begin:
	sleep(1);
	goto 'begin';
}

defaultproperties
{
     fHeight=50
     fTimeToTargetPoint=3.2
     fTimeToWait=3
     WizardName="Unknown"
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.WizzardCardIconMesh'
     DrawScale=2
     AmbientGlow=100
     bCollideWorld=True
     bBounce=True
}
