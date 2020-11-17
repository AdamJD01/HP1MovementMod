class BathroomClub	extends	HProps;

var()	actor	ClubTarget;		// Target of club
var()	float	TimeToHit;		// time taken (in secs) untill the club hit
var		float	RemainingTimeToHit;

var()	float	LevitatingSpeed;
var		vector	StartingLoc;
var		vector  _TargetLoc;
var     float   fDistance;
var		float	BobTime;

var		bool	bGoBackwards;
var()	float	TimeBackwards;
var()   float   fMoveBackwardsSpeed;
//var		float	CurrentTimeBackwards;
var		float	TimeRemainingBackwards;

var		BathroomRon	Ron;
var		int		OriginalPitch;

var float		LevWaitTime;

var PeevesTrail	LevFX;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	//CurrentTimeBackwards = 0;

	LevFX = none;
	foreach AllActors(class'BathroomRon', Ron)
	{
		break;
	}
	gotostate('Start');
}

function MoveBackwards()
{
	if (IsInState('MovingState'))
	{
		bGoBackwards = true;

		TimeRemainingBackwards = TimeBackwards;

		//if (RemainingTimeToHit + TimeRemainingBackwards + TimeBackwards > TimeToHit)
		//{
		//	CurrentTimeBackwards += TimeToHit - RemainingTimeToHit - TimeRemainingBackwards - TimeBackwards;
		//	TimeRemainingBackwards = TimeToHit - RemainingTimeToHit;
		//}
		//else
		//{
		//	CurrentTimeBackwards += TimeBackwards;
		//	TimeRemainingBackwards += TimeBackwards;
		//}
	}
}

auto state Start
{
}

state Levitating
{
	function BeginState()
	{
		PlaySound(sound'HPSounds.hub3_sfx.levitate_club_loop');

		BobTime = 0;
		OriginalPitch = rotation.pitch;

		if (ClubTarget != none)
			_TargetLoc = ClubTarget.Location + vec(0, 0, ClubTarget.collisionheight / 2 + collisionheight + 125);
		else
			_TargetLoc = ClubTarget.Location + vect(0,0,60);		// Some default value

		StartingLoc = location;
		Ron.gotostate('casting');
		LevWaitTime = 0;
	}

	//Slowly move the club in to the air and then move to the moving state
	function tick(float deltatime)
	{
		local rotator	lrot;

		LevWaitTime += deltatime;
		if (LevWaitTime < 2)
		{
			return;
		}

		if (LevFx == none)
		{
			LevFX = spawn(class'PeevesTrail', [spawnlocation] location);
			LevFX.SourceWidth.base = 70;
			LevFX.SourceHeight.base = 30;
			LevFX.SourceDepth.base = 30;
			LevFX.SetPhysics(PHYS_Trailer);
			LevFX.setowner(self);
			LevFX.AttachToOwner();
		}
		BobTime += deltatime;

		// rotate the club slightly
		lrot = rotation;
		lrot.yaw += 0x1fff * deltatime;
		lrot.pitch = OriginalPitch + 0x1fff * sin(6 * BobTime / 4);
		SetRotation(lrot);

		// raise the club until it reaches the required height
		if( location.z >= _TargetLoc.z - 50)
		{
			gotostate('movingState');
		}
		else
		{
			if( !Ron.IsInState( 'stateHurt' ) )
				move( vec(0, 0, LevitatingSpeed * deltatime) );
		}
	}
}

state MovingState
{
	// Move slowly towards the target

	// everytime when hot, move backwards

	// When reached target, drop and go in to the falling state

	function BeginState()
	{
		StartingLoc = location;
		fDistance = VSize( _TargetLoc - StartingLoc );
		RemainingTimeToHit = 0;
		bGoBackwards = false;
	}

	//Slowly move the club in to the air and then move to the moving state
	function tick(float deltatime)
	{
		// slowly bounce the club

		local vector	Bob;
		local vector	TargetLoc;
		local float		height;
		local float     t;
		local rotator	lrot;

		local vector	tv1, tv2;

		BobTime += deltatime;
		height = sin(6 * BobTime / 4) * fBobAmount;

		// rotate the club slightly
		lrot = rotation;
		lrot.yaw += 0x1fff * deltatime;
		lrot.pitch = OriginalPitch + 0x1fff * sin(6 * BobTime / 4);
		SetRotation(lrot);

		// work out distance to target

		//TargetLoc = ClubTarget.location;
		//TargetLoc.z += ClubTarget.collisionheight / 2 + collisionheight + 150;
		TargetLoc = _TargetLoc;

		if (bGoBackwards)
		{
			//TargetLoc = (RemainingTimeToHit - CurrentTimeBackwards + TimeRemainingBackwards ) * (TargetLoc - StartingLoc) / TimeToHit;
			TimeRemainingBackwards -= deltatime;
			if( TimeRemainingBackwards > 0 )
			{
				//Take off the appropriate time to hit, so that we move at speed fMoveBackwardsSpeed.
				RemainingTimeToHit -= (fMoveBackwardsSpeed * deltatime) / fDistance * TimeToHit;
				if( RemainingTimeToHit < 0 )
					RemainingTimeToHit = 0;
			}
			else
			{
				bGoBackwards = false;
			}
		}
		else //If we're still moving forwards
		if (RemainingTimeToHit < TimeToHit)
		{
			RemainingTimeToHit += deltatime;
			if( RemainingTimeToHit > TimeToHit )
				RemainingTimeToHit = TimeToHit;
		}
		else //We made it to _TargetLoc
		{
			RemainingTimeToHit = TimeToHit;
			//TargetLoc = ClubTarget.location;
			//TargetLoc = vec(0, 0, 0);
			//TargetLoc = TargetLoc - StartingLoc;
			//TargetLoc = Location;

			gotostate('FallingState');
		}

		TargetLoc = StartingLoc + (TargetLoc - StartingLoc) * RemainingTimeToHit/TimeToHit;

		TargetLoc += vec(0, 0, height);
		move( TargetLoc - Location );//StartingLoc + vec(0, 0, height) + TargetLoc - location);

		tv1 = location - _TargetLoc;
		tv2 = StartingLoc - _TargetLoc;
		tv1.z = 0;
		tv2.z = 0;

		BathroomTroll(ClubTarget).ThrowRate = 1 + (1 - vsize(tv1) / vsize(tv2));
	}
}

state FallingState
{
	// fall on top of target

	function BeginState()
	{
		StopSound();
		LevFx.Shutdown();
		SetCollision(true, true, true);
		bCollideWorld = true;
		SetPhysics(PHYS_Falling);
		Ron.gotostate('endcast');
	}

	function HitWall( vector HitNormal, actor Wall )
	{
		Velocity *= 0.25;
		Velocity = MirrorVectorByNormal( Velocity, HitNormal );

		if (wall == ClubTarget)
		{
			// Make sure its not just bouncing up and down on actor, add some translation
			if (velocity.x == 0 && velocity.y == 0)
			{
				velocity.x = rand(25) + 200;

				if (rand(2) == 1)
				{
					velocity.x = -velocity.x;
				}

				velocity.y = rand(25) + 200;

				if (rand(2) == 1)
				{
					velocity.y = -velocity.y;
				}
			}

			// Make the target fall over

			if (ClubTarget.isa('BathroomTroll'))
			{
				BathroomTroll(ClubTarget).gotostate('Concussed');
			}
		}
	}
}

defaultproperties
{
     TimeToHit=40
     LevitatingSpeed=5
     TimeBackwards=1
     fMoveBackwardsSpeed=100
     fBobAmount=2
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.TrollClubMesh'
     CollisionHeight=5
     bCollideActors=False
     bBounce=True
}
