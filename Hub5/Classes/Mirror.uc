//===============================================================================
//  [Mirror] 
//===============================================================================

class Mirror extends Mover;

var() int rotateAccelaration;

var int startDirection;
var int targetDirection;

var int rotDistance;
var float rotateTime;
var float switchTime;

var baseHarry   playerHarry;
var BossQuirrel boss;

function PostBeginPlay()
{
	local float        d, cd;
	local BossQuirrel  a;

	foreach AllActors(class'baseHarry', playerHarry)
		break;

	cd = 100000000;

	foreach AllActors(class'BossQuirrel', a)
	{
		d = VSize(a.Location - Location);

		if( d < cd )
		{
			cd = d;
			boss = a;
		}
	}
}

function SetYaw (int yaw)
{
	local rotator newRotation;
	newRotation = rotation;
	newrotation.yaw = yaw;

	SetRotation (newRotation);
}

function int modulus (int value, int range)
{
	// Not a particularly efficient way to do modulus
	// but I don't know if UScript has bit-twiddling
	// and efficiency is not a concern here ...

	while (value < 0)
		value += range;

	while (value > range)
		value -= range;

	return value;
}

// the following function should be inside stationary, 
// but for some reason auto doesn't work with Movers

//Jesus, I'm a fuckin' idiot.  It's overridden in state Rotating.

function bool TakeSpellEffect(baseSpell spell)
{
	local rotator spellHitDirection;
	local bool bIsVoldemortSpell;
	local vector HitNormal;

	// Detect if the spell was from Voldemort
	if (spellVoldemortStraight(spell) != None)
		bIsVoldemortSpell = true;

	if( bIsVoldemortSpell )
	{
		// Reflect spell
		HitNormal = vector(rotation);

		Log("mirror rotation " $rotation $", Vector: " $HitNormal);

		Log("Spell Velocity " $spell.velocity);

		//Only reflect the spell if the mirror is facing the spell
		if( (spell.Velocity dot HitNormal) < 0 )
		{
			spell.Velocity = MirrorVectorByNormal( spell.Velocity, HitNormal );
			spell.Acceleration = vect(0,0,0);
			spell.SetRotation( rotator(spell.Velocity) );
			spell.target = none;
			Log("reflected " $spell.velocity);
		}

		//Set the instigator to none, so that it can collide with vold.
		spell.Instigator = none;

		return false;
	}

	if( spellVoldemortTracking(spell) != none )
		return false;

	//Dont' modify anything, if it's already rotating.
	if( IsInState( 'Rotating' ) )
		return true;

	Log("Mirror hit by spell ...");
	
	spellHitDirection = rotator( boss.Location - Location ); //rotator( -spell.velocity );

	startDirection = modulus (rotation.yaw, 65536);
	targetDirection = modulus (spellHitDirection.yaw, 65536); 

	gotostate ('Rotating');

	return true;
}



auto state Stationary
{
	function beginState()
	{
	}
}

state Rotating
{
	//function bool TakeSpellEffect(baseSpell spell)
	//{
	//	return false;
	//}

	function Tick (float deltaTime)
	{
		local float yy;
		local float tmpTime;

		rotatetime += deltaTime;

		// Are we at end of cycle ?
		if (rotateTime >= (switchTime*2))
		{
			SetYaw(targetDirection);
			gotostate ('Stationary');
		}

		// Calculate how far we are from the 0 point
		// this will be either start or end, depending on whether we are speeding up or slowing down

		if (rotateTime < switchTime)
			tmpTime = rotateTime;
		else
			tmpTime = (switchTime*2) - rotateTime;

		yy = tmpTime * tmpTime * rotateAccelaration;

		// Use this to rotate the mirror to the required distance from start or end,
		// again depending on whether we have reached the mid point
		
		if (rotateTime < switchTime)
		{
			yy += startDirection;
			if (yy > 65536)
				yy -= 65536;
		}
		else
		{
			yy = targetDirection - yy;
			if (yy < 0)
				yy += 65536;
		}

//		log("Mirror distance" $yy);
		SetYaw (yy);		
	}

	function beginState()
	{
		// Calculate how far the mirror will be rotating

		PlaySound( sound'HPSounds.Hub5_sfx.mirror_rotate', [Pitch]RandRange(0.925, 1.075) );

		log("Mirror start pt " $startDirection $", target pt " $targetDirection);
		rotDistance = targetDirection - startDirection;
		if (rotDistance < 0)
			rotDistance += 65536;

		rotateTime = 0;

		// calculate the time when to switch from speeding up to slowing down ...
		//  = sqrt ( D / A )

		switchTime = rotDistance;
		switchTime/= rotateAccelaration;
		switchTime/= 2; // Halfway point

		log("Mirror Distance " $rotDistance $", Accel " $rotateAccelaration $", d/2a= " $switchTime);

		switchTime = sqrt (switchTime);
	}
}

defaultproperties
{
     rotateAccelaration=10000
     eVulnerableToSpell=SPELL_Flipendo
     bDirectional=True
     CollisionRadius=80
     CollisionHeight=40
     bCollideWorld=True
     bProjTarget=True
}
