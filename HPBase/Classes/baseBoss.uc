class baseBoss expands baseChar;


var sound peevesVoice;

//var(Boss) float     fInnerRadius;
//var(Boss) float     fOuterRadius;

var   int iNumHits;
var() int iNumHitsToBeat;

var() name TrigEventWhenDefeated;
var() name TrigEventWhenVictor;

var(Movement) float         GroundSpeedEnd;

var() name CamStateName;

var   bool bShowBossHealth;

//*************************************************************************************************************************
function PostBeginPlay()
{
	Super.PostBeginPlay();

	SetPhysics(PHYS_Walking);

	SetCollision( true, true, true );
	//SetCollisionSize( CollisionRadius*0.75*DrawScale, 20 );//float NewRadius, float NewHeight );

}

//*************************************************************************************************************************
function float GetHealth()
{
	return 1 - iNumHits / iNumHitsToBeat;
}

//*************************************************************************************************************************
event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, name DamageType)
{
	//	playerHarry.clientMessage(self $":I've been shot!");
	//	gotostate ('shot');
}

//*************************************************************************************************************************
function SendDefeatedTrigger()
{
	if( TrigEventWhenDefeated != '' )
	{
		TriggerEvent(TrigEventWhenDefeated, self, self);
		playerHarry.ClientMessage("TrigEventWhenDefeated");
	}
}

function SendVictoriousTrigger()
{
	if( TrigEventWhenVictor != '' )
	{
		TriggerEvent(TrigEventWhenVictor, self, self);
		playerHarry.ClientMessage("TrigEventWhenVictor:"$TrigEventWhenVictor);
		Log("TrigEventWhenVictor:"$TrigEventWhenVictor);
	}
}

//*************************************************************************************************************************
//Called from BaseChar::TakeSpellEffect
function bool HandleFlipSpell()
{
//	PlaySound(sound 'HPSounds.peeves_sfx.pee_004', SLOT_Interact, 3.2, false, 2000.0, 1.0);
	
	GotoState('DoFlip');
}

//*************************************************************************************************************************
function rotator AdjustAim(float projSpeed, vector projStart, int aimerror, bool bLeadTarget, bool bWarnTarget)
{
	return Rotation;
}

//*************************************************************************************************************************
function rotator AdjustToss(float projSpeed, vector projStart, int aimerror, bool bLeadTarget, bool bWarnTarget)
{
	local vector loc;

	if(self!=playerHarry)
	{
		loc=playerHarry.location;
		loc.z-=30;
		return Rotator(loc - Location);
	}
	else
		return Rotation;
}

//*************************************************************************************************************************
function vector GetCameraOffset()
{
	//return vect(0,0,0);
	return Location;
}

//*************************************************************************************************************************
function name GetCamState()
{
	return CamStateName;
}

//*************************************************************************************************************************
state dieing
{
	function movearound()
	{
		local rotator direction;
		direction.pitch=000;
		direction.yaw=2000;
		direction.roll=-400;
	//		delta=delta<<direction;
	//		move(delta);
	//	p.clientmessage("delta is "$delta);
		drawscale=drawscale-0.01;
		direction.yaw=direction.yaw+100;
		direction.roll=direction.roll-100;

		if(drawscale<0)
		{
			destroy();
		}

	}

	function Tick(float DeltaTime)
	{
		movearound();
	}

  begin:

	//	delta.x=3;
	//	delta.y=0;
	//	delta.z=0;
//	PlaySound(sound 'HPSounds.peeves_sfx.pee_011', SLOT_Interact, 3.2, false, 2000.0, 1.0);
	//playerHarry.clientMessage(self $":I'm dieing!");

	//PlaySound(sound 'naughty', SLOT_Interact, 2.2, false, 1000.0, 1.0);

  spin:
	//drawscale=drawscale-0.01;
	//movearound();
	//p.clientmessage("in shot");
	sleep(1.5);
	goto 'spin';


}

//*************************************************************************************************************************
// Return a normalized vector of which way you should shoot to hit a moving target.
function vector AdjustAimLookAhead(vector vTargetLoc, vector vTargetVel, vector vProjLoc, float fProjSpeed)
{
	local vector Sn;   // vel normal of ship = vector(Rotation);
	local vector PS;   // vect from gun to ship = S.Loc - P.Loc;
	local float  PSlen;// length of PS
	local vector PSn;  // normal of PS
	local vector Pn;   // vel normal of bullet.  What we're trying to find
	local float  Vs;   // target speed
	local float  a,b,c,t;

	Vs = VSize( vTargetVel );

	//Target not moving?  Just shoot straight at it.
	if( Vs == 0 )
		return normal( vTargetLoc - vProjLoc );

	Sn = vTargetVel / Vs;
	PS = vTargetLoc - vProjLoc;
	PSlen = VSize( PS );
	PSn = PS / PSlen;
 
	a = fProjSpeed*fProjSpeed - Vs*Vs;
	b = 2 * PSlen * Vs * (Sn dot -PSn);
	c = -PSlen*PSlen;
 
	t = b*b - 4*a*c;
	if( t < 0 )
	{
		Log("******** AdjustAimLookAhead : Negative sqrt");
		return Sn;//negative square root
	}

	t = sqrt(t);
	if( -b + t <= 0 )
	{
		Log("******** AdjustAimLookAhead : Negative Time");
		//return Sn;//negative square root
	}

	t = ( -b + t ) / 2 / a;

	if( t == 0 )
	{
		Log("******** AdjustAimLookAhead : Final time is zero");
		return Sn;
	}
 
	//just adding vectors:
	// PS + Sn*Vs*t = Pn*Vp*t    so,
	Pn = ( PS + Sn*Vs*t ) / ( fProjSpeed*t );

	//Log("******** AdjustAimLookAhead : vTargetVel="$vTargetVel$"  PSn="$PSn$"  Pn="$Pn);

	return Pn;
} 

//*************************************************************************************************************************

defaultproperties
{
     iNumHitsToBeat=4
     GroundSpeedEnd=250
     CamStateName=BossState
     bShowBossHealth=True
     GroundSpeed=175
     AirSpeed=60
     AccelRate=4000
     MenuName="baseHalfoy"
     DrawType=DT_Mesh
     DrawScale=2
     Mass=130
}
