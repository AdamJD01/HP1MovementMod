//===============================================================================
//  [ColumnShard] 
//===============================================================================

//class ColumnShard extends hprops;
class ColumnShard extends projectile;

// Vars ...
//-----------

var rotator randSpin;
var(ColumnShard) int velocityMult;

var int      NumBounces;

var int      PlaySoundTimer;

// Fns ....
//-----------


auto state isFalling
{
	function beginState ()
	{
		local rotator randRotVelocity;
		local int randMesh;
		randMesh = 4 *FRand();

		Mesh = SkeletalMesh'HProps.voldChallengePillarBit1Mesh';

		if (randMesh == 1)
			Mesh=SkeletalMesh'HProps.voldChallengePillarBit2Mesh';
		if (randMesh == 2)
			Mesh=SkeletalMesh'HProps.voldChallengePillarBit3Mesh';
		if (randMesh == 3)
			Mesh=SkeletalMesh'HProps.voldChallengePillarBit4Mesh';

		DrawScale *= 0.5 + (3.0-0.5)*FRand();

		// setup initial velocity and spin

		randSpin = rotRand() / 4;
		randRotVelocity = rotRand ();
		velocityMult *= 1.25;
		velocity=vector(randRotVelocity)*velocityMult;
		velocity.z += 2.0*velocityMult;	

		NumBounces = 1 + Rand(2);

//		log("column shard initial velocity " $velocity);
	}

	function Tick (float deltaTime)
	{
		SetRotation(rotation + (randSpin*deltaTime*3));

		velocity.z -= (deltaTime*1000);
	}

	function Timer()
	{
		if( FRand() > 0.5 )
			PlaySound( sound'HPSounds.hub5_sfx.rock_breaking', Slot_none, [Volume]0.75, [Radius]100000, [Pitch]RandRange(0.9, 1.1) );
		else
			PlaySound( sound'HPSounds.hub5_sfx.troll_smasher', Slot_none, [Volume]0.75, [Radius]100000, [Pitch]RandRange(0.9, 1.1) );
	}

	function HitWall( vector HitNormal, actor Wall )
	{
		//local float fVelocity;

		//fVelocity = VSize(Velocity);
		Velocity.z *= 0.20 + FRand()*0.3;
		Velocity = MirrorVectorByNormal( Velocity, HitNormal );

		if( Rand(1000) > 500 )
			Spawn(class'SmokeExplo_01',,, location,rot(0,0,0));

		//if (fVelocity < 2*velocityMult)
		if( NumBounces == 0 )
			destroy ();

		NumBounces--;

	//	log("column shard velocity " $velocity $", =int " $fVelocity);
	}


	function Landed( vector HitNormal )
	{
		//		Velocity *= 0.5;
		Velocity = MirrorVectorByNormal( Velocity, HitNormal );
	}

  Begin:
	if( PlaySoundTimer > 0 )
		SetTimer( PlaySoundTimer, false );

}

defaultproperties
{
     velocityMult=200
     Physics=PHYS_Falling
     CollisionRadius=1
     CollisionHeight=1
     bBounce=True
}
