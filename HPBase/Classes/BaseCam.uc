// HARRY POTTER camera code 
//________________________________________________________________________________________
class BaseCam extends Pawn;

//Edited by- AdamJD (edited code will have AdamJD by it)

// Enumeration of camera types, some of these are not currently used
enum ECameraType
{
	CAM_Standard,
	CAM_Quiditch,
	CAM_Far,
//	CAM_Combat,
	CAM_Boss,
	CAM_High,
	CAM_Reverse,
//	CAM_Fixed,
//	CAM_Rotate,
//	CAM_Free,
	CAM_FreeCam,
	CAM_Cut,
	CAM_TrollChase,
	CAM_Patrol,
	CAM_TopDown,
	CAM_Test,
	CAM_Test2,
	CAM_Test3,
	CAM_LockAroundHarry,
};

 var vector TrackingPoint;	//vector to the player
 var baseharry p;		// the pawn the camera is tracking
 var rotator lastRot;	// what the last rotation was
 var vector previousLocations[16];	// buffer of previous player locations
 var int currentLocation;			// index into the location buffers
 var int trackingDistance;		//which index is the one we are aiming for as a default
 var rotator locRot;			// rotation of the camera
 var bool cameraLock;			// camera mode, follow path or have the camera lock on
 var rotator prevPlayerRotation;
 var int campitch;				//pitch of the camera
 var float returnPitchTime;

 var bool hasPoints;			// any interpolation points available in this level?


	var actor realgoal;
	var actor start;
	var actor end;
	var NavigationPoint navP;
	var baseStation destP;
	var actor next;
	var float dis;


 var float CameraDistance;
 var float CameraHeight;
 var float CameraSpeed;
 var float lockBias;
 var float cameraRotSpeed;

 var float RealCameraDistance;
 var float CanSeeCountdown;

 var(camera) vector CameraOffset;
 var(camera) actor DirectionActor;
 var(camera) actor PositionActor;

 var(camera) actor HeightActor;

 var(camera) rotator	TargetRot;

 var rotator			CurrentRot;
 var float				fCurrentDist;

// Used to see if should go in to strafing mode or not during Boss Cam
 var(camera) bool	bUseStrafing;

	var	vector	CameraAimOffsetState;
	var bool	bUseTargetingCamera;

	var (patrol) name stationDestination;
	var (patrol) int stationNumber;
	var (patrol) name pathType;
	var (patrol) name firstPath;

var InterpolationPoint i;

var vector	CamAimOffset[5];
var vector	BattleCamAimOffset[5];
var int		CamIndex;
var	float	CamCountdown;
var bool	bWasAiming;
var bool	bUseBattleCam;

var int	TargetRoll;
//var rotator trot;
var int	PitchIncrease;

var bool	bTurnToward;

//@PAB used to determine if Harry is moving
var vector	HarrysPreviousPosition;

// Boss target

var vector	OldBossDirection;
var vector	OldGoalPoint;

var(camera) rotator BossCamBox;

var (PatrolPoints) name firstPatrolPointTag;

var vector preCutLocation;
var rotator preCutRotation;

// For reverse cam, check the current yaw mod due to collisions

var int YawMod;

var bool		bCollide;

var bool		bShake;
var float		fShakeDuration;
var float		fStartShakeDuration;
var float		fShakeMagnitude;

var(camera) ECameraType CameraType;

// Used to save and restore states

var ECameraType SavedCameraType[10];
var float		SavedCameraSpeed[10];
var float		SavedCameraRotSpeed[10];
var vector		SavedCameraOffset[10];
var actor		SavedDirectionActor[10];
var actor		SavedPositionActor[10];
var basechar	SavedBossTarget[10];
var vector		SavedPosition[10];
var rotator		SavedRotation[10];
var rotator		SavedHarryRotation[10];
var rotator		SavedDesiredRotation[10];
var rotator		SavedRotationRate[10];

var int			StackPointer;

// Cut scene camera used by the cut scene script

var Actor CutWalkDest;
var name CutAnimName;
var baseScript CutNotifyScript;
var string CutCueString;
const NORMAL_PROXIMITY=15;
var float CutCameraProx;	//used for tuning camera movement in CutScenes.

var NavigationPoint tempNavP, LastNavP;

var float NormalCameraSpeed;		//used by SetCameraSpeed to set the speed as a  fraction of full speed.
var rotator NormalCameraRotSpeed;		//  ""


//AdamJD vars
// var float rotvalX; //old -AdamJD
// var float rotvalY; //old -AdamJD

var Target rectarget;

//mouse data (comments copied from HP2 proto) 
var float			fMouseDeltaX;				// saved mouse deltaX and deltaY playerHarry
var float			fMouseDeltaY;	

var bool			bSyncRotationWithTarget;	// Sync our curr rotation to always face target
var bool			bSyncPositionWithTarget;	// Sync cam position with CamTarget's position at a fixed distance

var CamTarget   	camTarget;					// camera's target (seperate pawn so we can use flyto interpolation )
var vector			vForward;					// The forward vector (for refrence outside the camera)
var rotator			rRotationStep;				// Rotation Step ( rotation step will be applied over time)

var rotator			rDestRotation;				// Rotation Destination
var vector			vDestPosition;				// Position Destination
var rotator			rCurrRotation;				// Rotation Current 
var vector			vCurrPosition;				// Position Current

var float			fCurrLookAtDistance;		// Current LookAt Distance will change
var float			fMoveBackTightness;			// Current MoveBack tightness (used when camera moves back from hitting a wall or a bBlockCamera actor )

var float			fCurrentMinPitch;			// Current Min pitch the camera can have
var float			fCurrentMaxPitch;			// Current Max pitch the camera can have

var rotator         rBossRotationOffset;        // This is always centered around a zero rotation, then as you move the mouse, it stays within a narrow cone, and is
                                                //  added to rDestRotation.  Gives player ability to 'aim' while in boss cam.
var rotator         rExtraRotation;             // An additional rotation which can be added to the final rotation, say, for camera shake.  Is zero'd every tick.

//standard cam specific (comments copied from HP2 proto) 
var rotator		rSavedRotation;				// saved when you leave standard mode and reloaded when you come back
var vector		vSavedPosition;				// saved when you leave standard mode and reloaded when you come back
var float		fPitchMovingInThreshold;	// set by the constant PITCH_MOVING_IN_THRESHOLD
var float		fPitchMovingInSpread;		// set by the constant PITCH_MOVING_IN_SPREAD
var float		fDistanceScalar;			// obtained by comparing the current pitch with the spread (once you attain the threshold)
var float       fDistanceScalarMin;         // min for fDistanceScalar.  around 0.15.  set by DISTANCE_SCALAR_MIN
var vector		vLookAtOffset;		// Current Offset applyed to our lookAt point
var float		fLookAtDistance;	// How far away from the lookAt point is the camera?
var float		fRotTightness;		// The higher the tighness the faster our curLocation == targetLocation
var float		fRotSpeed;			// How fast are we (per sec) at moving.
var float		fMoveTightness;		// The higher the tighness the faster our curRotation == targetRotation
var float		fMoveSpeed;			// How fast are we (per sec) at rotating.

//mouseDelta min and max constants (comments copied from HP2 proto)
const	MIN_MOUSE_DELTA_X			= -20000.0f;	
const	MAX_MOUSE_DELTA_X			=  20000.0f;
const	MIN_MOUSE_DELTA_Y			= -10000.0f;
const	MAX_MOUSE_DELTA_Y			=  10000.0f;

//standard cam pitch/moving in constants (comments copied from HP2 proto) 
const	PITCH_MOVING_IN_THRESHOLD	= 0.0f;			
const	PITCH_MOVING_IN_SPREAD		= 10000.0f;		
const   DISTANCE_SCALAR_MIN         = 0.15;


/*------------------------------------------------------*/
/* LOCAL FUNCTIONS										*/
/*------------------------------------------------------*/
//AdamJD
function PreBeginPlay()
{
	SetCollision(false, false, false);
	bCollideWorld = false;
	
	fPitchMovingInThreshold	= PITCH_MOVING_IN_THRESHOLD;
	fPitchMovingInSpread	= PITCH_MOVING_IN_SPREAD;
	fDistanceScalarMin      = DISTANCE_SCALAR_MIN;
}

//AdamJD
function PostBeginPlay()
{
	local int count;
	local vector tloc;
	local vector targetoffset;

	Super.PostBeginPlay();
	
	foreach AllActors(class'baseharry', p)
	{
		break;
	}
	
	foreach AllActors(class'Target', rectarget)
	{
		break;
	}
	
	if( camTarget == None )
		camTarget = spawn( class'CamTarget' ); 		
	
    SetOwner( camTarget );
	camTarget.Cam = self;      

	rectarget.victim.eVulnerableToSpell=SPELL_None; 	
	
	//old code by me -AdamJD
	// p.cam=self; 
	// camTarget.vOffset.x= p.SmoothMouseX; 
	// camTarget.vOffset.y= p.SmoothMouseY; 
	// camTarget.vOffset.z= 0; 
	// camTarget.aAttachedTo.IsA('baseHarry');
	
	//org retail code -AdamJD
	CameraDistance=80.000000; 
    CameraHeight=120.000000;
	CameraSpeed=2.000000;
	NormalCameraSpeed=CameraSpeed;

	CameraRotSpeed=10.000000;
    NormalCameraRotSpeed=RotationRate;

    RealCameraDistance = CameraDistance;
	CanSeeCountdown = 4;

	SetCutCameraProx(NORMAL_PROXIMITY);

	count=0;
	StackPointer = 0;

	while(count<16)
	{
		previousLocations[count] = vect(0, 0, 0);
		count+=1;
	}
	currentLocation=0;

	bUseStrafing = true;
	bUseBattleCam = false;

	HarrysPreviousPosition = vect(0, 0, 0);

	//@PAB
	trackingDistance=cameraDistance/20;
	setPhysics(PHYS_Rotating);
	
	SetCamera();
}

//old retail PostBeginPlay -AdamJD
/*function PostBeginPlayIP()
{
	local int count;
	
	Super.PostBeginPlay();

     CameraDistance=80.000000;
     CameraHeight=120.000000;
	 CameraSpeed=2.000000;
	 NormalCameraSpeed=CameraSpeed;

	 CameraRotSpeed=10.000000;
     NormalCameraRotSpeed=RotationRate;

     RealCameraDistance = CameraDistance;
	 CanSeeCountdown = 4;

	SetCutCameraProx(NORMAL_PROXIMITY);


	count=0;
	StackPointer = 0;

	while(count<16)
	{
		previousLocations[count] = vect(0, 0, 0);
		count=count+1;
	}
	currentLocation=0;

	bUseStrafing = true;
	bUseBattleCam = false;

	HarrysPreviousPosition = vect(0, 0, 0);

	//@PAB
	trackingDistance=cameraDistance/20;
//	trackingDistance=cameraDistance/10;
	setPhysics(PHYS_Rotating);*/

/*	CamAimOffset[0] = vect(0, 50, -45);
	CamAimOffset[1] = vect(0, -50, -45);
	CamAimOffset[2] = vect(0, 50, 45);
	CamAimOffset[3] = vect(0, -50, 45);
	CamAimOffset[4] = vect(0, 0, 50);
*/
/*	CamAimOffset[0] = vect(0, 50, 50);
	CamAimOffset[1] = vect(0, 25, 50);
	CamAimOffset[2] = vect(0, 0, 50);
	CamAimOffset[3] = vect(0, -25, 50);
	CamAimOffset[4] = vect(0, -50, 50);

	BattleCamAimOffset[0] = vect(0, 50, 50);
	BattleCamAimOffset[1] = vect(0, 25, 50);
	BattleCamAimOffset[2] = vect(0, 0, 50);
	BattleCamAimOffset[3] = vect(0, -25, 50);
	BattleCamAimOffset[4] = vect(0, -50, 50);
*/

/*	CamAimOffset[0] = vect(0, 0, 0);
	CamAimOffset[1] = vect(0, 0, 0);
	CamAimOffset[2] = vect(0, 0, 0);
	CamAimOffset[3] = vect(0, 0, 0);
	CamAimOffset[4] = vect(0, 0, 0);

	BattleCamAimOffset[0] = vect(0, 0, 0);
	BattleCamAimOffset[1] = vect(0, 0, 0);
	BattleCamAimOffset[2] = vect(0, 0, 0);
	BattleCamAimOffset[3] = vect(0, 0, 0);
	BattleCamAimOffset[4] = vect(0, 0, 0);

	CamIndex = 4;
	bWasAiming = false;
	CamCountdown = 0;

	CameraAimOffsetState = vect(0, 0, 0);

	OldBossDirection = vect(0,0,0);
	OldGoalPoint = vect(0,0,0);
	TargetRoll = 0;
	YawMod = 0;

	foreach AllActors(class'baseharry', p)
	{
		break;
	}

	bUseTargetingCamera = true;

	bShake = false;
	p.BossTarget = none;
	SetCamera();
}*/

function SetCameraSpeed(float Speed)
{
	CameraSpeed = NormalCameraSpeed*Speed;
}
function SetCameraRotSpeed(float Speed)
{
	RotationRate = NormalCameraRotSpeed*Speed;
}

function ShakeCamera(float fDuration, float fMagnitude)
{
/*	bShake = true;
	fShakeDuration = fDuration;
	fStartShakeDuration = fDuration;
	fShakeMagnitude = fMagnitude;

	p.ClientMessage("Camera shake!");
*/
}

function DoMove(vector Offset, float fDeltaTime)
{
	local float fHeight;

/*		if (bShake)
		{
			fShakeDuration -= fDeltaTime;

			if (fShakeDuration < 0)
			{
				bShake = false;
			}

			fHeight = sin(20 * fShakeDuration) * fShakeDuration / fStartShakeDuration;
			Offset.z += fHeight;

			if (vsize(Offset) > (300 * fDeltaTime))
			{
				Offset = normal(Offset) * (300 * fDeltaTime);
			}
			SetLocation(Offset + location);
		}
		else
		{*/
			throttleTrack(fDeltaTime);
			MoveSmooth(Offset);
//		}
}


/*-----------------------------------------------------*/
// Helper function for debugging

function NextCamera()
{
	switch(CameraType)
	{
		case CAM_Standard:
			CameraType = CAM_Test2;
			break;

		case CAM_Test2:
			CameraType = CAM_Test3;
			break;

		case CAM_Test3:
			CameraType = CAM_Quiditch;
			break;

		case CAM_Quiditch:
			CameraType = CAM_Far;
			break;

		case CAM_Far:
			CheckForBoss();
			if (p.BossTarget != none)
			{
				CameraType = CAM_Boss;
			}
			else
			{
				CameraType = CAM_High;
			}
			break;

		case CAM_Boss:
			CameraType = CAM_High;
			break;

		case  CAM_High:
			CameraType = CAM_Reverse;
			break;

		case CAM_Reverse:
			CameraType = CAM_Cut;

		// temp assignemt
			PositionActor = none;
			DirectionActor = p;
			break;

		case CAM_Cut:
/*			CheckForBoss();
			CameraType = CAM_TrollChase;*/
//			CameraType = CAM_Patrol;
			CameraType = CAM_TopDown;
			break;

		case CAM_Patrol:
			CameraType = CAM_TopDown;
			break;

/*		case CAM_TrollChase:
			CameraType = CAM_Test;
			break;*/

		case CAM_TopDown:
			CameraType = CAM_Test;
			break;

		case CAM_Test:
			CameraType = CAM_LockAroundHarry;
			break;

		case CAM_LockAroundHarry:
			CameraType = CAM_Standard;
			break;

		default:
			break;
	}

	SetCamera();
}

/*-----------------------------------------------------*/

// Helper function for debugging
function SetCamera()
{
	p.BossTarget = none;
	p.clientMessage("baseCam::SetCamera '"$CameraType$"' BossTarget set to none");

	switch (CameraType)
	{
		case CAM_Standard:
			gotostate('StandardState');
			break;

		case CAM_Quiditch:
			gotostate('QuidditchState');
			break;

		case CAM_Far:
			gotostate('FarState');
			break;

		case CAM_Boss:
			CheckForBoss();
			if (p.BossTarget != none)
			{
				p.clientMessage("baseCam::SetCamera    BossTarget set to"$p.BossTarget);
				gotostate('BossState');
			}
			else
			{
				gotostate('StandardState');
			}
			break;

		case CAM_High:
			gotostate('HighState');
			break;

		case CAM_Reverse:
			gotostate('ReverseState');
			break;
		
		case CAM_Cut:
			gotostate('CutState');
			break;

		case CAM_TrollChase:
			gotostate('TrollChaseState');
			break;

		case CAM_Patrol:
			gotostate('PatrolState');
			break;

		case CAM_TopDown:
			gotostate('TopDownState');
			break;

		case CAM_Test:
			// Special test state
			gotostate('TestState');
			break;

		case CAM_Test2:
			// Special test state
			gotostate('Test2State');
			break;

		case CAM_Test3:
			// Special test state
			gotostate('Test3State');
			break;

		case CAM_LockAroundHarry:
			// Special test state
			gotostate('LockAroundHarry');
			break;

		default:
			break;
	}
}


/*-----------------------------------------------------*/

function setCutCamera (actor cLocation, actor Clookat)
{
}

/*-----------------------------------------------------*/


function exitCutCamera()
{

	SetCutCameraProx(NORMAL_PROXIMITY);
	
	setlocation(preCutLocation);
	setRotation(preCutRotation);
	p.gotostate('playerwalking');

	gotostate('StartState');
//	gotostate('StandardState');


}
function SetCutCameraProx(float value)
{
	CutCameraProx=value;
}
/*-----------------------------------------------------*/

function smoothRotate(rotator goalrot, out rotator dest,float deltatime)
{
	local int dist;


	dist=goalrot.yaw-dest.yaw;
	dist=(dist*cameraRotspeed)*deltatime;
	if(dist>1024)
	{
		dist=1024;
	}
	if(dist<-1024)
	{
		dist=-1024;
	}
	dest.yaw = dest.yaw+dist;
//	dest.roll = goalrot.roll;
}

/*-----------------------------------------------------*/

function SmoothPitch(float deltatime)
{

	if(campitch != 0)
	{
		if(campitch > 0)
		{
			campitch = campitch - (10 * deltatime);
			if(campitch < 0)
			{
				campitch = 0;
			}
		}

		if (campitch < 0)
		{
			campitch = campitch - (10 * deltatime);
			if(campitch > 0)
			{
				campitch = 0;
			}
		}
	}
}

/*-----------------------------------------------------*/

function throttleTrack(float deltatime)
// scales the tracking speed of the camera
{
	local float camTotal;

	camTotal = cameraSpeed * deltatime;
	
// @PAB increase speed of camera when going backwards or in boss mode
	if (p.bmovingbackwards || p.BossTarget != none || CameraType == CAM_Reverse)
	{
		camTotal=camTotal * 3;
	}

	if (camTotal > 1)
		camTotal = 1;
	trackingPoint *= camtotal;
}


/*-----------------------------------------------------*/

function CheckForBoss()
{
	local baseChar TargetActor;
	local int	iDistance;

	// If the Current Boss is still there and in range, then keep this
	// as the target
	if (p.BossTarget != none)
	{
		if (VSize(p.BossTarget.location - p.location) < 2048)
		{
			return;
		}
	}

	p.BossTarget = none;

	iDistance = 65535;

	foreach VisibleActors( class 'BASECHAR', TargetActor)
	{
		if(TargetActor.bprojtarget)
		{
			if (VSize(TargetActor.Location - p.Location) < iDistance)
			{
				p.BossTarget = TargetActor;
				iDistance = VSize(TargetActor.Location - p.Location);
			}
		}
	}

//	HPHUD(Harry(p).MyHUD).DebugString2 = string(Harry(p).BossTarget.Name);
}

/*-----------------------------------------------------*/

function bool CanSeeTarget(vector StartLocation)
{
	local bool bCanSeeTarget;
	local actor PossibleVictim;
	local vector HitLocation;
	local vector HitNormal;
	local actor  HitActor;

	// @PAB we need to find a good camera angle

	bCanSeeTarget = true;
			
/*	PossibleVictim = Trace(HitLocation, HitNormal, p.rectarget.Location, StartLocation, true);

	if (PossibleVictim.bBlockPlayers)*/
/*	if (PossibleVictim != none && !possiblevictim.isa('levelinfo') 
			&& !possiblevictim.isa('trigger') && !possiblevictim.isa('mover')
			 && !possiblevictim.isa('basescript'))*/
/*	{
		if (HitLocation != p.rectarget.Location && possibleVictim != p.rectarget.victim)
		{
			bCanSeeTarget = false;
		}
	}
	else
	{*/

	PossibleVictim = none;
	foreach TraceActors(class 'actor', HitActor, HitLocation, HitNormal, p.rectarget.Location, StartLocation)
	{
//		log(string(HitActor.name) $" " $vsize(HitLocation - TraceStart));

		if (HitActor.bBlockActors || HitActor.isa('levelinfo') || HitActor.isa('target'))
		{
			// Found target, 
			PossibleVictim = HitActor;
			break;
		}
	}

//		PossibleVictim = Trace(HitLocation, HitNormal, p.rectarget.Location, StartLocation);
		if (PossibleVictim != none && !HitActor.isa('target'))
		{
			bCanSeeTarget = false;
		}
//	}

	return bCanSeeTarget;

//	return CameraCanSee(p.rectarget);
}

function bool CameraCanSee(actor Target)
{
	local bool bCanSeeTarget;
	local actor PossibleVictim;
	local vector HitLocation;
	local vector HitNormal;

/*	if (PossibleVictim != none && !possiblevictim.isa('levelinfo') && !possiblevictim.isa('basescript')
			 && !possiblevictim.isa('trigger'))*/

	// @PAB we need to find a good camera angle

	bCanSeeTarget = true;
			
	PossibleVictim = Trace(HitLocation, HitNormal, Target.Location, Location, true);

	if (PossibleVictim.bBlockPlayers)
	{
		if (HitLocation != Target.Location && possibleVictim != Target)
		{
			bCanSeeTarget = false;
		}
	}
	else
	{
		PossibleVictim = Trace(HitLocation, HitNormal, Target.Location, Location);
		if (PossibleVictim != none && HitLocation != Target.Location && possibleVictim != Target)
		{
			bCanSeeTarget = false;
		}
	}

	return bCanSeeTarget;
}

/*------------------------------------------------------*/

function NextTargetCam()
{
	CamIndex = CamIndex + 1;
	if (CamIndex > 4)
	{
		CamIndex = 0;
	}
}

/*------------------------------------------------------*/

function SetCollisionState()
{
	bCollide = false;

	if (bCollide)
	{
		SetCollision(true, true, true);
		bCollideWorld = true;
	}
	else
	{
		SetCollision(false, false, false);
		bCollideWorld = false;
	}
}

/*------------------------------------------------------*/

function CheckCollisionState(float deltatime)
{
//	if (!CameraCanSee(p))
	if(!CanSee(p))
	{
		bCollide = false;
		// move the camera closer until it can see Harry!
//		RealCameraDistance = 30;
//		CanSeeCountdown = 4;
	}
/*	else
	{
		bCollideWorld=true;
		bCollideActors=true;
*/
/*		CanSeeCountdown -= deltatime;

		if (CanSeeCountdown <= 0)
		{
			RealCameraDistance = CameraDistance;
		}*/
//	}

	RealCameraDistance = CameraDistance;
}

/*------------------------------------------------------*/

function GeneralMoveModeCamera(float deltatime)
{
	local int		offset;
	local vector	goalPoint;
	local vector	targetpoint;
	local vector	CamDistance;
	local float		fHeight;

	offset = (currentLocation - trackingDistance) & 15;
	goalPoint = previousLocations[offset];

	goalPoint.z = goalpoint.z + p.TargetEyeHeight + (cameraHeight / 2);

	if (CheckForCameraCollision(goalPoint))
	{
		//@PAB temp removal collision
//		goalPoint.z = p.Location.z + p.TargetEyeHeight;
		bCollide = false;
	}

	trackingPoint = goalPoint - Location;
	
	TargetPoint = Normal(trackingpoint);
//	TargetPoint = TargetPoint * CameraDistance;
	TargetPoint = TargetPoint * RealCameraDistance;
	CamDistance = CameraOffset >> locRot;
	TargetPoint = TargetPoint - CamDistance;

	trackingPoint = trackingPoint - TargetPoint;

	if(camPitch<-300)
	{
		camPitch=campitch+100;
	}

	if(camPitch>300)
	{
		camPitch=campitch-100;
	}
	locRot.pitch=campitch;	

	throttleTrack(DeltaTime);
	MoveSmooth(trackingPoint);
//	DoMove(trackingPoint, deltatime);
}

function GeneralStationaryModeCamera(float deltatime, optional bool bMoveQuick)
{
	local vector	TargetPoint;
	local vector	goalPoint;
	local vector	SavedGoalPoint;
	local vector	camDistance;

	local rotator	CamRot;
	local int		CamSize;
	local int		MoveCamDir;
	local int		TestCamera;

	local vector	PositionDif;
	local bool		bMoved;
	local bool		bFoundGoodCamera;

	local float		fHeight;

	PositionDif = HarrysPreviousPosition - p.Location;

	if (PositionDif.x != 0 || PositionDif.y != 0 || PositionDif.z != 0)
	{
		p.bStationary = false;
		HarrysPreviousPosition = p.Location;
	}
	else
	{
		p.bStationary = true;
	}

	if(cameraLock != True)
	{
		currentLocation = 0;
	}
	cameraLock = TRUE;

	if (p.bStationary)
	{
		if(p.SmoothMouseY > 64)
		{
			campitch = campitch + p.SmoothMouseY / 32;
			if(campitch > 12000)
			{
				campitch = 12000;
			}
		}

		if(p.SmoothMouseY < -64)
		{
			campitch = campitch + p.SmoothMouseY / 32;
			if(campitch < -12000)
			{
				campitch = -12000;
			}
		}
	}
    else
    {
        camPitch = 0;
    }
		
	if(p.SmoothMouseY == 0 || !p.bStationary)
	{
		SmoothPitch(deltatime);
	}

	locRot.pitch = campitch;
        BaseHUD(p.MyHUD).DebugvalA = campitch;

/*	if (bMoveQuick)
	{
		locRot = rotator(p.standardTarget.location - location);
	}
*/		
			// @PAB new goal point

/*	if (p.bStationary)
	{
		TargetPoint = p.Location;
		TargetPoint.z = p.TargetEyeHeight + TargetPoint.z + cameraHeight;
		TargetPoint = Normal(TargetPoint - p.StandardTarget.Location);
		TargetPoint = TargetPoint * RealCameraDistance;
	}
	else
	{
		TargetPoint = Location;
		TargetPoint.z = p.TargetEyeHeight + TargetPoint.z + cameraHeight;
		TargetPoint = Normal(TargetPoint - p.StandardTarget.Location);
		TargetPoint = TargetPoint * (RealCameraDistance + vsize(p.Location - p.StandardTarget.Location));
	}*/
	TargetPoint = p.Location;
	TargetPoint.z = p.TargetEyeHeight + TargetPoint.z + cameraHeight;

	if (bMoveQuick)
	{
/*		CamDistance = vec(-CameraDistance, 0, p.TargetEyeHeight + cameraHeight) >> p.rotation;
		goalPoint = p.Location + CamDistance;*/

		if (!p.bStationary)
		{
//			TargetPoint.z -= 10;
		}
		TargetPoint = Normal(TargetPoint - p.StandardTarget.Location);
		TargetPoint = TargetPoint * RealCameraDistance;
		CamDistance = CameraOffset >> locRot;
		goalPoint = TargetPoint + p.Location + CamDistance;

		BaseHUD(p.MyHUD).DebugValZ = goalPoint.z;
	}
	else
	{
		TargetPoint = Normal(TargetPoint - p.StandardTarget.Location);
//	TargetPoint = TargetPoint * CameraDistance;
		TargetPoint = TargetPoint * RealCameraDistance;
		if (p.bMovingBackwards)
		{
			TargetPoint *= 1.5;
		}
		CamDistance = CameraOffset >> locRot;
		goalPoint = TargetPoint + p.Location + CamDistance;
	}


	SavedGoalPoint = goalPoint;
	bFoundGoodCamera = false;

	for (TestCamera = 0; TestCamera < 6 && !bFoundGoodCamera; TestCamera++)
	{
		if(/*p.IsInState('playeraiming') &&*/ bUseTargetingCamera) //AdamJD
		{
			if (p.Bosstarget != none || bUseBattleCam)
			{
				CamDistance = (BattleCamAimOffset[CamIndex]) >> locRot;
			}
			else
			{
				CamDistance = (CamAimOffset[CamIndex] + CameraAimOffsetState) >> locRot;
			}
			goalPoint = goalPoint + CamDistance;
		}

		if (goalPoint.z < p.Location.z)
		{
			goalPoint.z = p.Location.z;
		}

		if (!p.bStationary)
		{
			if (goalPoint.z < p.Location.z + cameraHeight + p.TargetEyeHeight)
			{
				goalPoint.z = p.Location.z + cameraHeight + p.TargetEyeHeight;
			}
		}

		if (IsInState('ReverseState'))
		{
	//PAB use only for the reverse cam

			CamSize = VSize(goalPoint - p.Location);
			CamRot = Rotator(goalPoint - p.Location);
			CamRot.Yaw += YawMod;
			CamRot.Yaw = CamRot.Yaw & 0xffff;
			goalPoint = vector(CamRot) * CamSize + p.Location;

			MoveCamDir = CheckForCameraCollisionSides(goalPoint);

			CamSize = VSize(goalPoint - p.Location);
			CamRot = Rotator(goalPoint - p.Location);

			if (MoveCamDir != 0)
			{
		// move the camera the appropriate direction

				YawMod += MoveCamDir * 512;

//				BaseHUD(p.MyHUD).DebugString2 = "Collision";

			}
			else
			{
//				BaseHUD(p.MyHUD).DebugString2 = "No Collision";
			}

			CamRot.Yaw += YawMod;
			CamRot.Yaw = CamRot.Yaw & 0xffff;
			goalPoint = vector(CamRot) * CamSize + p.Location;
//			log(YawMod);
		}
		else
		{
			if (CheckForCameraCollision(goalPoint))
			{
				// PAB temporary (hopefully) removal of lowering camera
				// Testing the ability of the camera to go through walls instead
				goalPoint.z = p.Location.z + p.TargetEyeHeight;

//				bCollide = false;
			}
		}

		goalpoint = CheckPosition(goalPoint);

		// if (p.IsInState('playeraiming')) //AdamJD
		// {
			// @PAB we need to find a good camera angle

			if (!CanSeeTarget(goalPoint) && TestCamera != 5)		// Don't increment last camera
			{
				if (CanSeeCountdown < 0)
				{
					NextTargetCam();
					goalPoint = SavedGoalPoint;
				}
				else if (TestCamera == 0)
				{
					CanSeeCountdown -= deltatime;
					bFoundGoodCamera = true;
				}
			}
			//AdamJD
			// else
			// {
				// CanSeeCountdown = 1.5;
				// bFoundGoodCamera = true;
			// }
		//}
		// else //AdamJD
		// {
			CanSeeCountdown = 1.5;
			bFoundGoodCamera = true;
		//}
	}

	if (vsize(goalpoint - p.location) < 50)
	{
		goalpoint.z += (50 - vsize(goalpoint - p.location));
	}

	trackingPoint = goalPoint - Location;

/*	if (bShake)
	{
		fShakeDuration -= deltatime;

		if (fShakeDuration < 0)
		{
			bShake = false;
		}
		else
		{
			fHeight = sin(20 * fShakeDuration) * fShakeMagnitude * fShakeDuration / fStartShakeDuration;
			trackingPoint.z += fHeight;
		}
	}
*/
	// if (p.IsInState('playeraiming')) //AdamJD
	// {
		if (vsize(trackingpoint) > 50)
		{
			trackingpoint = (vsize(trackingpoint) - 50) * normal(trackingpoint);
			if (bMoveQuick)
			{
/*				if (vsize(trackingPoint) > 50 )
				{
					if (abs(trackingPoint.z) > 50)
					{
						if (trackingPoint.z > 0)
						{
							trackingPoint.z -= 50;
						}
						else
						{
							trackingPoint.z += 50;
						}
					}
				}*/

				if (vsize(trackingPoint) > (300 * deltatime))
				{
					trackingPoint = normal(trackingpoint) * 300 * deltatime;
				}
//				throttleTrack(deltatime);
//				MoveSmooth(trackingPoint);
				SetLocation(trackingPoint + location);
			}
			else
			{
				throttleTrack(deltatime);
				MoveSmooth(trackingPoint);
			}
		}
	//}
	else
	{
		if (bMoveQuick || bShake)
		{
/*			if (vsize(trackingPoint) > 50 )
			{
				if (abs(trackingPoint.z) > 50)
				{
					if (trackingPoint.z > 0)
					{
						trackingPoint.z -= 50;
					}
					else
					{
						trackingPoint.z += 50;
					}
				}
			}*/

			if (vsize(trackingPoint) > (300 * deltatime))
			{
				trackingPoint = normal(trackingpoint) * (300 * deltatime);
			}
			SetLocation(trackingPoint + location);
		}
		else
		{
			throttleTrack(deltatime);
			MoveSmooth(trackingPoint);
		}
	}
	
}

/*------------------------------------------------------*/

function vector CheckPosition(vector StartPoint)
{
	local bool bCanSeeTarget;
	local actor PossibleVictim;
	local vector HitLocation;
	local vector HitNormal;
	local vector TraceEnd;
	local vector lvect;
	local actor  HitActor;

	// @PAB we need to find a good camera angle

	TraceEnd = p.Location;
	TraceEnd.z = StartPoint.z;

	bCanSeeTarget = true;
			
/*	PossibleVictim = Trace(HitLocation, HitNormal, StartPoint, TraceEnd, true);

//	if (PossibleVictim != none && !possiblevictim.isa('levelinfo') && !possiblevictim.isa('basescript'))
	if (PossibleVictim != none)
	{
		if (PossibleVictim.bBlockPlayers)
//		if (!possiblevictim.isa('levelinfo') && !possiblevictim.isa('trigger') && !possiblevictim.isa('basescript'))
		{
			baseHUD(p.MyHUD).DebugString2 = string(PossibleVictim.Name);
			return HitLocation;
		}
	}
*/

	PossibleVictim = none;
	foreach TraceActors(class 'actor', HitActor, HitLocation, HitNormal, StartPoint, TraceEnd)
	{
//		log(string(HitActor.name) $" " $vsize(HitLocation - StartPoint));
		baseHud(p.MyHUD).DebugString2 = string(HitActor.Name);

		if ((HitActor.bBlockActors || HitActor.isa('levelinfo')) && !HitActor.isa('basecam'))
		{
			// Found target, 
			PossibleVictim = HitActor;
			break;
		}
	}

	baseHud(p.MyHUD).DebugString = string(PossibleVictim.Name);

/*	PossibleVictim = Trace(HitLocation, HitNormal, StartPoint, TraceEnd);*/
	if (PossibleVictim != none)
	{
//		baseHud(p.MyHUD).DebugString2 = string(PossibleVictim.Name);

		lvect = HitLocation - StartPoint;

		lvect = normal(lvect) * 10 + HitLocation;

		StartPoint = lvect;
		PossibleVictim = none;
		TraceEnd = p.Location;

		foreach TraceActors(class 'actor', HitActor, HitLocation, HitNormal, StartPoint, TraceEnd)
		{
//			log(string(HitActor.name) $" " $vsize(HitLocation - StartPoint));
			baseHud(p.MyHUD).DebugString2 = string(HitActor.Name);

			if ((HitActor.bBlockActors || HitActor.isa('levelinfo')) && !HitActor.isa('basecam') && !HitActor.isa('baseharry'))
			{
			// Found target, 
				PossibleVictim = HitActor;
				break;
			}
		}

		if (PossibleVictim != none)
		{
//		baseHud(p.MyHUD).DebugString2 = string(PossibleVictim.Name);

			lvect = HitLocation - StartPoint;

			lvect = normal(lvect) * 10 + HitLocation;
		}

		return lvect;
//		return HitLocation;
	}
	else
	{
//		baseHud(p.MyHUD).DebugString2 = "None";
	}

//	baseHUD(p.MyHUD).DebugString2 = "none";

	return StartPoint;
}

/*------------------------------------------------------*/


function StoreMove()
{
	local int camTotal;

	camTotal = VSize(previousLocations[currentLocation] - p.Location);
	if(abs(camTotal) > 5.0)
	{
		prevPlayerRotation = p.ViewRotation;
		currentLocation = (currentLocation + 1) & 15;
		previousLocations[currentLocation] = p.Location;
		if(cameraLock)
		{
			if(currentLocation == 0)
			{
				cameraLock = False;
			}
		}
	}
}

/*------------------------------------------------------*/

function EnterCutState(optional actor inP, optional actor inD)
{
	p.ClientMessage("baseCam: Entered cut state");
	SaveState();
	if(inP!=None)
		PositionActor = inP;
	if(inD!=None)
		DirectionActor = inD;

//    RotationRate.Yaw = 20000;

	GotoState('CutState');
}

/*------------------------------------------------------*/

function ExitCutState(optional bool bRestorePostion)
{
	p.ClientMessage("baseCam: Exit cut state");
		
	SetCutCameraProx(NORMAL_PROXIMITY); //back to normal proximity
	RestoreState(bRestorePostion);

}

/*------------------------------------------------------*/

function SaveState()
{
	SavedCameraType[StackPointer] = CameraType;
	SavedCameraSpeed[StackPointer] = CameraSpeed;
	SavedCameraRotSpeed[StackPointer] = CameraRotSpeed;
	SavedCameraOffset[StackPointer] = CameraOffset;
	SavedDirectionActor[StackPointer] = DirectionActor;
	SavedPositionActor[StackPointer] = PositionActor;
	SavedBossTarget[StackPointer] = p.BossTarget;
	SavedPosition[StackPointer] = location - p.location;
	SavedRotation[StackPointer] = Rotation;
	SavedDesiredRotation[StackPointer] = DesiredRotation;
	SavedRotationRate[StackPointer] = RotationRate;
	SavedHarryRotation[StackPointer] = p.Rotation;

	StackPointer ++;

	log("Saved Rotation yaw " $Rotation.yaw);
	log("Save stackpointer set to " $stackpointer);
	if (StackPointer > 9)
	{
		log("camera stack OVERFLOW!!!!!!!!!!!!!!!!!!!!");
	}
}

/*------------------------------------------------------*/

function RestoreState(optional bool bRestorePostion)
{
	if (StackPointer < 0)
	{
		log("camera stack UNDERFLOW!!!!!!!!!!!!!!!!!!!!");
	}

	RestoreStateWithoutPop(bRestorePostion);
	StackPointer --;
	log("Restore stackpointer set to " $stackpointer);
}

function RestoreStateWithoutPop(optional bool bRestorePostion)
{
	CameraType = SavedCameraType[StackPointer - 1];
	p.ClientMessage("baseCam restored to state:"$CameraType);
	CameraSpeed= SavedCameraSpeed[StackPointer - 1];
	CameraRotSpeed =  SavedCameraRotSpeed[StackPointer - 1];

	CameraOffset = SavedCameraOffset[StackPointer - 1];
	DirectionActor = SavedDirectionActor[StackPointer - 1];
	PositionActor = SavedPositionActor[StackPointer - 1];
	p.BossTarget = SavedBossTarget[StackPointer - 1];
	if (bRestorePostion)
	{
		SetLocation((SavedPosition[StackPointer - 1] >> (SavedHarryRotation[StackPointer - 1] - p.Rotation)) + p.location);
		SetRotation(SavedRotation[StackPointer - 1]);
		DesiredRotation = SavedDesiredRotation[StackPointer - 1];
//		log("Restored Rotation yaw " $SavedRotation[StackPointer - 1].yaw);
//		log("Restored Desired Rotation yaw " $DesiredRotation.yaw);
	}
	RotationRate = SavedRotationRate[StackPointer - 1];
	SetCamera();
	log("Restore without pop, RestorePos " $bRestorePostion);
}

function bool CheckForCameraCollision(vector TraceStart)
{
	// check to see if the camera is about to collide with something, if it is, drop down to Harry's level

	local rotator	MoveRot;
	local vector	TraceEnd;
	local vector	VectorToHarry;
	local vector	OldTraceStart;

	local vector	HitLocation;
	local vector	HitNormal;
	local actor		PossibleVictim;
	local int		DistanceToHarry;

	MoveRot = p.rotation;

	MoveRot.pitch = 512;
	MoveRot.Roll = 0;
	TraceStart.z += 5;

	TraceEnd = Vector(MoveRot);

	VectorToHarry = p.Location - TraceStart;
	VectorToHarry.z = 0;

	DistanceToHarry = VSize(VectorToHarry);

	TraceEnd = TraceEnd * DistanceToHarry;

	TraceEnd = TraceEnd + TraceStart;

	PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

	if (possiblevictim == none || possiblevictim.IsA('BaseHarry') || possiblevictim.IsA('BaseChar'))
	{
//		BaseHUD(p.MyHUD).DebugString = "none";
//		BaseHUD(p.MyHUD).DebugString2 = "No collision";
		return false;
	}

	// check to see if the problem still exists lower down, if not then ignore
	// and let the other collision routines sort it out.

	OldTraceStart = TraceStart;

	TraceStart.z = p.Location.z + p.TargetEyeHeight;
	OldTraceStart = TraceStart;

	TraceStart = CheckPosition(TraceStart);

/*	BaseHUD(p.MyHUD).DebugValx = TraceStart.x;
	BaseHUD(p.MyHUD).DebugValy = TraceStart.y;
	BaseHUD(p.MyHUD).DebugValz = TraceStart.z;

	BaseHUD(p.MyHUD).DebugValx2 = OldTraceStart.x;
	BaseHUD(p.MyHUD).DebugValy2 = OldTraceStart.y;
	BaseHUD(p.MyHUD).DebugValz2 = OldTraceStart.z;
*/
	if (OldTraceStart == TraceStart)
	{
//		BaseHUD(p.MyHUD).DebugString2 = string(possiblevictim.name);
		return true;
	}
	else
	{
//		BaseHUD(p.MyHUD).DebugString2 = "Other Collision";
		return false;
	}

//	BaseHUD(p.MyHUD).DebugString = "Should not get here";
//	BaseHUD(p.MyHUD).DebugString2 = "Collision";
	return true;
}

function int CheckForCameraCollisionSides(vector TraceStart)
{
	// check to see if the camera is about to collide with something, if it is, drop down to Harry's level

	local rotator	MoveRot;
	local vector	TraceEnd;
	local vector	VectorToHarry;

	local vector	HitLocation;
	local vector	HitNormal;
	local actor		PossibleVictim;
	local int		DistanceToHarry;
	local int		OldYawMod;

	DistanceToHarry = 50;
	MoveRot = p.rotation;

	MoveRot.pitch = 0;
	MoveRot.Roll = 0;
	OldYawMod = YawMod;

	if (YawMod > 0)
	{
		YawMod -= 512;
	}
	else if (YawMod < 0)
	{
		YawMod += 512;
	}

	MoveRot.yaw += YawMod;
	MoveRot.yaw = MoveRot.yaw & 0xffff;

	TraceEnd = Vector(MoveRot);

	VectorToHarry = p.Location - TraceStart;
	VectorToHarry.z = 0;

//	DistanceToHarry = VSize(VectorToHarry);

	TraceEnd = TraceEnd * DistanceToHarry;

	TraceEnd = TraceEnd + TraceStart;

	PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

	if (possiblevictim == none || possiblevictim.IsA('BaseHarry'))
	{
		return 0;
	}

//	log("Trace start" $TraceStart.x $" " $TraceStart.y $" " $TraceStart.z $" ");
//	log("Trace End" $TraceEnd.x $" " $TraceEnd.y $" " $TraceEnd.z $" ");
	MoveRot.yaw -= YawMod;
	YawMod = OldYawMod;

	MoveRot.yaw += YawMod;
	MoveRot.yaw = MoveRot.yaw & 0xffff;

	TraceEnd = Vector(MoveRot);

	VectorToHarry = p.Location - TraceStart;
	VectorToHarry.z = 0;

//	DistanceToHarry = VSize(VectorToHarry);

	TraceEnd = TraceEnd * DistanceToHarry;

	TraceEnd = TraceEnd + TraceStart;

	PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

	if (possiblevictim == none || possiblevictim.IsA('BaseHarry'))
	{
		return 0;
	}
	// Collision, see if we can find a good spot to move

	MoveRot.Yaw += 512;

	MoveRot.yaw = MoveRot.yaw & 0xffff;

	TraceEnd = Vector(MoveRot);

	VectorToHarry = p.Location - TraceStart;
	VectorToHarry.z = 0;

//	DistanceToHarry = VSize(VectorToHarry);

	TraceEnd = TraceEnd * DistanceToHarry;

	TraceEnd = TraceEnd + TraceStart;

	PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

	if (possiblevictim == none || possiblevictim.IsA('BaseHarry'))
	{
		// this direction is OK
		return 1;
	}

	MoveRot.Yaw += 4096;

	MoveRot.yaw = MoveRot.yaw & 0xffff;

	TraceEnd = Vector(MoveRot);

	VectorToHarry = p.Location - TraceStart;
	VectorToHarry.z = 0;

//	DistanceToHarry = VSize(VectorToHarry);

	TraceEnd = TraceEnd * DistanceToHarry;

	TraceEnd = TraceEnd + TraceStart;

	PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

	if (possiblevictim == none || possiblevictim.IsA('BaseHarry'))
	{
		// this direction is OK
		return 2;
	}

	MoveRot.Yaw -= (4096 + 512 + 512);

	MoveRot.yaw = MoveRot.yaw & 0xffff;

	TraceEnd = Vector(MoveRot);

	VectorToHarry = p.Location - TraceStart;
	VectorToHarry.z = 0;

//	DistanceToHarry = VSize(VectorToHarry);

	TraceEnd = TraceEnd * DistanceToHarry;

	TraceEnd = TraceEnd + TraceStart;

	PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

	if (possiblevictim == none || possiblevictim.IsA('BaseHarry'))
	{
		// this direction is OK
		return -1;
	}

	MoveRot.Yaw -= 4096;

	MoveRot.yaw = MoveRot.yaw & 0xffff;

	TraceEnd = Vector(MoveRot);

	VectorToHarry = p.Location - TraceStart;
	VectorToHarry.z = 0;

//	DistanceToHarry = VSize(VectorToHarry);

	TraceEnd = TraceEnd * DistanceToHarry;

	TraceEnd = TraceEnd + TraceStart;

	PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

	if (possiblevictim == none || possiblevictim.IsA('BaseHarry'))
	{
		// this direction is OK
		return -2;
	}

	return 0;
}

function bool CheckForReverseCameraCollision(vector TraceStart)
{
	// check to see if the camera is about to collide with something, if it is, drop down to Harry's level

	local rotator	MoveRot;
	local vector	TraceEnd;
	local vector	VectorToHarry;
	local vector	OldTraceStart;

	local vector	HitLocation;
	local vector	HitNormal;
	local actor		PossibleVictim;
	local int		DistanceToHarry;

	MoveRot = p.rotation;

	MoveRot.pitch = 512;
	MoveRot.Roll = 0;
	TraceStart.z += 5;

	TraceEnd = Vector(MoveRot);

	VectorToHarry = p.Location - TraceStart;
	VectorToHarry.z = 0;

	DistanceToHarry = VSize(VectorToHarry);

//	TraceEnd = TraceEnd * DistanceToHarry;
	TraceEnd = TraceEnd * 128;

	TraceEnd = TraceEnd + TraceStart;

	PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

	if (possiblevictim == none || possiblevictim.IsA('BaseHarry') || possiblevictim.IsA('BaseChar'))
	{
//		BaseHUD(p.MyHUD).DebugString = "No collision";

		// check forward as well

		TraceEnd = TraceEnd - TraceStart;
		TraceEnd = TraceStart - TraceEnd - TraceEnd;

		PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

		if (possiblevictim == none || possiblevictim.IsA('BaseHarry') || possiblevictim.IsA('BaseChar'))
		{
//			BaseHUD(p.MyHUD).DebugString = "No collision";
			return false;
		}
	}

	return true;


	// check to see if the problem still exists lower down, if not then ignore
	// and let the other collision routines sort it out.

	OldTraceStart = TraceStart;

	TraceStart.z = p.Location.z + p.TargetEyeHeight;
	OldTraceStart = TraceStart;

	TraceStart = CheckPosition(TraceStart);

/*	BaseHUD(p.MyHUD).DebugValx = TraceStart.x;
	BaseHUD(p.MyHUD).DebugValy = TraceStart.y;
	BaseHUD(p.MyHUD).DebugValz = TraceStart.z;

	BaseHUD(p.MyHUD).DebugValx2 = OldTraceStart.x;
	BaseHUD(p.MyHUD).DebugValy2 = OldTraceStart.y;
	BaseHUD(p.MyHUD).DebugValz2 = OldTraceStart.z;
*/
	if (OldTraceStart == TraceStart)
	{
//		BaseHUD(p.MyHUD).DebugString = string(possiblevictim.name);
		return true;
	}
	else
	{
//		BaseHUD(p.MyHUD).DebugString = "Other Collision";
		return false;
	}

//	BaseHUD(p.MyHUD).DebugString = "Should not get here";
//	BaseHUD(p.MyHUD).DebugString2 = "Collision";
	return true;
}


/*------------------------------------------------------*/
/* STATES												*/
/*------------------------------------------------------*/

state Teststate
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;



/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

function Tick(float DeltaTime)
{
	if (bInSpecialPause)
	{
		SaveState();
		gotostate('FreeCamState');
	}
	else
	{
		PositionCamera(DeltaTime);
	}
}

function PositionCamera(float DeltaTime)
{
	local float		camTotal;

	local vector	PositionDif;

	bCollide = true;

	locRot.pitch = camPitch;
	smoothRotate(p.ViewRotation, locRot, deltatime);

	// if(p.IsInState('playeraiming')) //AdamJD
	// {
		// cameraLock = true; //AdamJD
		if (!bWasAiming)
		{
			bWasAiming = true;
			NextTargetCam();
		}
	//}
	else
	{
		bWasAiming = false;
	}

	GeneralStationaryModeCamera(deltatime);
			
	StoreMove();

	CheckCollisionState(deltatime);

	// @PAB remove when you wish to go back to a colliding camera
//	bCollide = false;
	SetCollisionState();

}

	function BeginState()
	{
		CameraType = CAM_Test;
		p.clientmessage("Camera switch to Test state");
		p.StandardTarget.TargetOffset = vect(75, 0 ,50);
	    CameraHeight	= 100.000000;
		CameraDistance	= 140.000;
//		CameraAimOffsetState = vect(80, 0, 0);
//		CameraAimOffsetState = vect(40, 0, 0);
		CameraAimOffsetState = vect(0, 0, 0);
//		CameraOffset = vect(140, -100, 0);
	}

	begin:
	loop:
		sleep (0.0005);
		if(!bShake)
		{
			turntoward(p.StandardTarget);
		}

		goto 'loop';
}

/*-----------------------------------------------------*/

state FarState
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;


/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

function Tick(float DeltaTime)
{
	if (bInSpecialPause)
	{
		SaveState();
		gotostate('FreeCamState');
	}
	else
	{
		PositionCamera(DeltaTime);
	}
}

function PositionCamera(float DeltaTime)
{
	local float		camTotal;

	local vector	PositionDif;
	local bool		bMoved;

	bCollide = true;

	locRot.pitch = camPitch;
	smoothRotate(p.ViewRotation, locRot, deltatime);

	// if(p.IsInState('playeraiming')) //AdamJD
	// {
		// cameraLock = true; //AdamJD
		if (!bWasAiming)
		{
			bWasAiming = true;
			NextTargetCam();
		}
	//}
	else
	{
		bWasAiming = false;
	}

	PositionDif = HarrysPreviousPosition - p.Location;

	if (PositionDif.x != 0 || PositionDif.y != 0 || PositionDif.z != 0)
	{
		bMoved = true;
		HarrysPreviousPosition = p.Location;
	}
	else
	{
		bMoved = false;
	}

	if((bMoved && !cameraLock) && !p.bmovingbackwards)
	{
//		BaseHUD(p.MyHUD).DebugString = "Moving";
		GeneralMoveModeCamera(deltatime);
	}
	else		//Harry more or less stationary
	{
//		BaseHUD(p.MyHUD).DebugString = "Not moving";
		GeneralStationaryModeCamera(deltatime);
	}
			
	CheckCollisionState(deltatime);

		// @PAB remove when you wish to go back to a colliding camera
//		bCollide = false;
		SetCollisionState();
}

	function BeginState()
	{
		CameraType = CAM_Far;
		p.clientmessage("Camera switch to Far state");
		p.StandardTarget.TargetOffset = vect(100, 0 ,50);
	    CameraHeight	= 60.000000;
		CameraDistance	= 200.000;
		CameraAimOffsetState = vect(0, 0, 0);
	}

	begin:

	loop:
		sleep (0.0005);
		if(!bShake)
		{
			turntoward(p.StandardTarget);
		}

		goto 'loop';
}

/*-----------------------------------------------------*/

state Highstate
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;


/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

function Tick(float DeltaTime)
{
	if (bInSpecialPause)
	{
		SaveState();
		gotostate('FreeCamState');
	}
	else
	{
		PositionCamera(DeltaTime);
	}
}

function PositionCamera(float DeltaTime)
{
	local float		camTotal;

	local vector	PositionDif;
	local bool		bMoved;

	bCollide = true;

	locRot.pitch = camPitch;
	smoothRotate(p.ViewRotation, locRot, deltatime);

	// if(p.IsInState('playeraiming')) //AdamJD
	// {
		// cameraLock = true; //AdamJD
		if (!bWasAiming)
		{
			bWasAiming = true;
			NextTargetCam();
		}
	//}
	else
	{
		bWasAiming = false;
	}

	PositionDif = HarrysPreviousPosition - p.Location;

	if (PositionDif.x != 0 || PositionDif.y != 0 || PositionDif.z != 0)
	{
		bMoved = true;
		HarrysPreviousPosition = p.Location;
	}
	else
	{
		bMoved = false;
	}

//	if((bMoved && !cameraLock) && !p.bmovingbackwards)
//	{
//		BaseHUD(p.MyHUD).DebugString = "Moving";
		GeneralMoveModeCamera(deltatime);
//	}
//	else		//Harry more or less stationary
//	{
//		BaseHUD(p.MyHUD).DebugString = "Not moving";
		GeneralStationaryModeCamera(deltatime);
//	}
			
	StoreMove();

	CheckCollisionState(deltatime);
		// @PAB remove when you wish to go back to a colliding camera
//		bCollide = false;
		SetCollisionState();
}


	function BeginState()
	{
		CameraType = CAM_High;
		p.clientmessage("Camera switch to High state");
		p.StandardTarget.TargetOffset = vect(150, 0 ,50);
		CameraHeight	= 320.000000;
		CameraDistance	= 320.000;
		CameraAimOffsetState = vect(0, 0, 0);
	}

	begin:
	loop:
		sleep (0.0005);
		if(!bShake)
		{
			turntoward(p.StandardTarget);
		}

		goto 'loop';
}

/*-----------------------------------------------------*/

state ReverseState
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;


/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

function Tick(float DeltaTime)
{
	if (bInSpecialPause)
	{
		SaveState();
		gotostate('FreeCamState');
	}
	else
	{
		PositionCamera(DeltaTime);
	}
}

function PositionCamera(float DeltaTime)
{
	local float		camTotal;

	local vector	PositionDif;
	local bool		bMoved;

	bCollide = true;

	locRot.pitch = camPitch;
	smoothRotate(p.ViewRotation, locRot, deltatime);

	// if(p.IsInState('playeraiming')) //AdamJD
	// {
		//cameraLock = true; //AdamJD
		if (!bWasAiming)
		{
			bWasAiming = true;
			NextTargetCam();
		}
	//}
	else
	{
		bWasAiming = false;
	}

//	BaseHUD(p.MyHUD).DebugString = "Not moving";
	GeneralStationaryModeCamera(deltatime);
			
	CheckCollisionState(deltatime);
		// @PAB remove when you wish to go back to a colliding camera
		bCollide = false;
		SetCollisionState();
}

	function BeginState()
	{
		CameraType = CAM_Reverse;
		p.clientmessage("Camera switch to Reverse state");
	    CameraHeight	= 60.000000;
		CameraDistance	= 300.000;
		p.StandardTarget.TargetOffset = vect(-100, 0 ,50);
		CameraAimOffsetState = vect(0, 0, 0);
	}

	begin:
	loop:
		sleep (0.0005);
		if(!bShake)
		{
			turntoward(p.StandardTarget);
		}

		goto 'loop';
}

//rotation function for the boss cam because the standard rotation is bugged for boss fights -AdamJD
function UpdateRotationForBoss( float fTimeDelta )
{
	local float		fTravelScalar;
	local vector	vDestRotation; 
	local vector 	vCurrRotation;

	vDestRotation = normal(vector(rDestRotation));
	vCurrRotation = vForward;

	//update Rotation
	if( bSyncRotationWithTarget )
	{	
		//always face CamTarget
		vDestRotation = CamTarget.location - location;
		vCurrRotation = vDestRotation;
	}
	
	else
	{
		//clamp travel scalar
		if( fRotTightness > 0.0f )
		{
			fTravelScalar = FMin( 1.0f, fRotTightness * fTimeDelta );
		}
		
		else
		{
			fTravelScalar = 1.0f;
		}
		
		vCurrRotation += ( vDestRotation - vCurrRotation ) * fTravelScalar;	
	}
	
	vCurrRotation = normal(vCurrRotation);
	rCurrRotation = rotator(vCurrRotation);

	vForward = vCurrRotation;
	
	//set rotation
	SetFinalRotation( rotator(vCurrRotation) );
} 

/*-----------------------------------------------------*/

state BossState
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;
	
	function BeginState()
	{
		 CameraType = CAM_Boss;
		 
		//not needed -AdamJD
		/*
		p.StandardTarget.gotostate('BossFollow');
		p.StandardTarget.TargetOffset = vect(100, 0 ,50);
		p.clientmessage("Camera switch to Boss state " $string(p.bosstarget.name) $" "  $string(directionactor.name));
		p.StandardTarget.BossCamBox = BossCamBox;
		p.StandardTarget.TargetOffset = vect(100, 0 ,50);
	    CameraHeight	= 120.000000;
		CameraDistance	= 80.000;
		CameraAimOffsetState = vect(0, 0, 0);
		*/
		
		//AdamJD
		InitSettings( true, false );
		InitTarget( p );
		InitPositionAndRotation( false );
		
		//not needed -AdamJD
		// if (bUseStrafing)
		// {
			// p.MovementMode(true);
		// }
		
		//not needed -AdamJD
		//FT: Hack for voldemort, unless we figure out the real problem, this should work.
		// if( p.BossTarget.IsA( 'BossQuirrel' ) )
		// {
			// p.ClientMessage("BaseCam::BossState - Setting DirectionActor to none for Voldemort battle");
			// DirectionActor = none;
		// }
	}
	
	function EndState()
	{
		//p.MovementMode(false); //not needed -AdamJD
		p.BossTarget = none;
		DirectionActor = none;
		p.StandardTarget.gotostate('seeking'); 
		CameraType = CAM_Standard; //go back to standard cam -AdamJD
	}


	function Tick(float DeltaTime)
	{
		local vector v;

		ApplyMouseXToDestYaw(DeltaTime);
		ApplyMouseYToDestPitch(DeltaTime);
		
		//update camera -AdamJD
		if( baseBoss(p.BossTarget) != none )
		{
			v = baseBoss(p.BossTarget).GetCameraOffset();
		}
		else
		{
			v = p.BossTarget.Location;
		}

		rDestRotation = rotator(normal( v - location ));
		//add boss offset -AdamJD
		rDestRotation += rBossRotationOffset;
		
		//update rotation -AdamJD
		UpdateRotationForBoss( DeltaTime );
		
		//update position -AdamJD
		UpdatePosition( DeltaTime );
		
		if (bInSpecialPause)
		{
			//not smooth but it does the job... -AdamJD
			SaveState();
			gotostate('FreeCamState');
		}
		
		//not needed -AdamJD
		/*
		else
		{
			CheckForBoss();
			if (p.BossTarget == none)
			{
				CameraType = CAM_Standard;
				SetCamera();
			}

			PositionCamera(DeltaTime);
		}
		*/
	}
	
	//not needed -AdamJD
	/*
	function PositionCamera(float DeltaTime)
	{
		local vector goalPoint;
		local vector camDistance;
		local vector TargetPoint;

//		BaseHUD(p.MyHUD).DebugString = "Boss CAM";

		bCollide = true;
		p.bStationary = true;

		if(cameraLock!=True)
		{
			currentLocation=0;
		}
		cameraLock=TRUE;

		// Smoothly change the pitch of the camera
		returnPitchTime=returnPitchTime-deltaTime;
		SmoothPitch(deltatime);
		locRot.pitch=campitch;
	
		// Get the vector to the target via Harry
		TargetPoint = p.Location;
		TargetPoint.z = p.TargetEyeHeight + TargetPoint.z + cameraHeight;

		if (DirectionActor == none)
		{
//			TargetPoint = Normal(TargetPoint - p.BossTarget.Location + vect(0, 0, 50));
			TargetPoint = Normal(TargetPoint - p.StandardTarget.Location + vect(0, 0, 50));
		}
		else
		{
			TargetPoint = Normal(TargetPoint - DirectionActor.Location + vect(0, 0, 50));
		}

		// Move the camera out slightly to get a better view
//		TargetPoint = TargetPoint * CameraDistance * 2;
		TargetPoint = TargetPoint * RealCameraDistance * 2;

		camDistance = CameraOffset >> locRot;

		goalPoint = TargetPoint + p.Location + camDistance;*/
		
		
		// If we are in aiming mode, see if we need to switch target CAM
		//if(/*p.IsInState('playeraiming') &&*/ bUseTargetingCamera)
		/*{
			// Give the camera some variety, change cam each time the player starts aiming
			if (!bWasAiming)
			{
				bWasAiming = true;
				NextTargetCam();
			}

			if (!CanSeeTarget(location))
			{
				CamCountDown = CamCountDown + deltatime;
				if (CamCountdown > 1.5)
				{
					NextTargetCam();
					CamCountDown = 0;
				}
			}
			else
			{
				CamCountDown = 0;
			}
			if (p.Bosstarget != none || bUseBattleCam)
			{
				CamDistance = (BattleCamAimOffset[CamIndex]) >> Rotator(-TargetPoint);
			}
			else
			{
				CamDistance = (CamAimOffset[CamIndex] + CameraAimOffsetState) >> Rotator(-TargetPoint);
			}
			goalPoint = goalPoint + CamDistance;
		}
		else
		{
			CamCountDown = 0;
			bWasAiming = false;
		}

		goalpoint = CheckPosition(goalPoint);

		// Make sure the target point is not below Harry
		if (goalPoint.z < p.Location.z)
		{
			goalPoint.z = p.Location.z;
		}

		trackingPoint = goalPoint - Location;

	throttleTrack(DeltaTime);
	MoveSmooth(trackingPoint);
//		DoMove(trackingPoint, deltatime);

		CheckCollisionState(deltatime);

		// @PAB remove when you wish to go back to a colliding camera
//		bCollide = false;
		SetCollisionState();
	}*/

	//begin:

/*		if (p != none)
		{
			log("P is valid!");
		}
		else
		{
			log("Harry is invalid!");
		}
*/
	
	//not needed -AdamJD
	// loop:
		// sleep (0.0005);
		// if(!bShake)
		// {
			// turntoward(p.StandardTarget);
		// }
		// goto 'loop';
}

/*-----------------------------------------------------*/

state RotateAroundHarry
{
	function tick(float deltatime)
	{
		local Rotator	YawRate;
		local vector	CurrentVector;
		local float		fDist;

		bCollide = false;
		SetCollisionState();

		CurrentVector = location - p.location;
		fDist = vsize(CurrentVector);
		if (fDist > (CameraDistance * 0.75))
		{
			fDist = fDist - (CameraDistance * deltatime * 0.35);

			if (fDist < (CameraDistance * 0.75))
			{
				fDist = (CameraDistance * 0.75);
			}
			CurrentVector = Normal(CurrentVector) * fDist;
		}

		YawRate = RotationRate;
		YawRate.Pitch = 0;
		YawRate.roll = 0;
		CurrentVector = CurrentVector >> (YawRate * deltatime / 3.0);

		CurrentVector = CheckPosition(p.location + CurrentVector);

		SetLocation(CurrentVector);
	}

	begin:
		sleep (0.0005);

		// Check bounding box for camera
		turntoward(p);
		goto 'begin';
}
/*-----------------------------------------------------*/

state LockAroundHarry
{
	function BeginState()
	{
		CurrentRot = rotator(location - p.location) - p.rotation;
		fCurrentDist = vsize(location - p.location);
/*		SetRotation(CurrentRot);
		DesiredRotation = CurrentRot;
		ViewRotation = CurrentRot;*/
//		CurrentRot -= p.Rotation;
/*		log("CAMDEBUG currentDistance " $fCurrentDist);
		log("CAMDEBUG currentrotation " $CurrentRot.pitch $" " $CurrentRot.yaw $" " $CurrentRot.roll);
		log("CAMDEBUG targetrotation " $TargetRot.pitch $" " $TargetRot.yaw $" " $TargetRot.roll);*/
	}

	function tick(float deltatime)
	{
		local Rotator	YawRate, DifRot;
		local vector	CurrentVector;
//		local float		fDist;

		bCollide = false;
		SetCollisionState();

//		CurrentVector = location - p.location;
//		fCurrentDist = vsize(CurrentVector);
		if (fCurrentDist > CameraDistance)
		{
			fCurrentDist = fCurrentDist - (CameraDistance * deltatime * 0.35);

			if (fCurrentDist < (CameraDistance))
			{
				fCurrentDist = (CameraDistance);
			}
//			CurrentVector = Normal(vec(CurrentRot)) * fCurrentDist;
		}
		else if (fCurrentDist < CameraDistance)
		{
			fCurrentDist = fCurrentDist - (CameraDistance * deltatime * 0.35);

			if (fCurrentDist > (CameraDistance))
			{
				fCurrentDist = (CameraDistance);
			}
		}

		DifRot = TargetRot - CurrentRot;

		DifRot.yaw = DifRot.yaw & 0xffff;
		if (DifRot.yaw > 0x7fff)
		{
			DifRot.yaw = DifRot.yaw - 0x10000;
			if (abs(DifRot.yaw) > RotationRate.yaw)
			{
				if (DifRot.yaw > 0)
				{
					DifRot.yaw = RotationRate.yaw;
				}
				else
				{
					DifRot.yaw = -RotationRate.yaw;
				}
			}
		}

		DifRot.pitch = DifRot.pitch & 0xffff;
		if (DifRot.pitch > 0x7fff)
		{
			DifRot.pitch = DifRot.pitch - 0x10000;
			if (abs(DifRot.pitch) > RotationRate.pitch)
			{
				if (DifRot.pitch > 0)
				{
					DifRot.pitch = RotationRate.pitch;
				}
				else
				{
					DifRot.pitch = -RotationRate.pitch;
				}
			}
		}

		DifRot.roll = 0;

		CurrentRot = CurrentRot + DifRot * deltatime / 2.5;
		CurrentVector = normal(vector(CurrentRot + p.Rotation)) * fCurrentDist;

/*		SetRotation(CurrentRot + p.rotation);
		DesiredRotation = CurrentRot + p.rotation;
		ViewRotation = CurrentRot + p.rotation;*/
/*		log("CAMDEBUG currentDistance " $fCurrentDist);
		log("CAMDEBUG currentvector " $CurrentVector.x $" " $CurrentVector.y $" " $CurrentVector.z);
		log("CAMDEBUG currentrotation " $CurrentRot.pitch $" " $CurrentRot.yaw $" " $CurrentRot.roll);
		log("CAMDEBUG targetrotation " $TargetRot.pitch $" " $TargetRot.yaw $" " $TargetRot.roll);*/
//		CurrentVector = CurrentVector >> (DifRot * deltatime / 2.5);

		movesmooth(p.location + CurrentVector - location);
		//		SetLocation(p.location + CurrentVector);
	}

	begin:
//		fCurrentVector = location - p.location;
	loop:
		sleep (0.0005);
		turntoward(p);
		goto 'loop';
}
/*-----------------------------------------------------*/

state TrollChaseState
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;


	function Tick(float DeltaTime)
	{
		if (bInSpecialPause)
		{
			SaveState();
			gotostate('FreeCamState');
		}
		else
		{
			CheckForBoss();
			if (p.BossTarget == none)
			{
				CameraType = CAM_Standard;
				SetCamera();
			}

			PositionCamera(DeltaTime);
		}
	}

	function PositionCamera(float DeltaTime)
	{
		local vector goalPoint;
		local vector camDistance;
		local vector TargetPoint;

//		BaseHUD(p.MyHUD).DebugString = "Boss CAM";

		p.bStationary = true;

		bCollide = false;

		RealCameraDistance = CameraDistance;

		if(cameraLock!=True)
		{
			currentLocation=0;
		}
		cameraLock=TRUE;

		// Smoothly change the pitch of the camera
		returnPitchTime=returnPitchTime-deltaTime;
		SmoothPitch(deltatime);
		locRot.pitch=campitch;
	
		// Get the vector to the target via Harry
		TargetPoint = p.Location;
		TargetPoint.z = p.TargetEyeHeight + TargetPoint.z + cameraHeight;

		if (DirectionActor == none)
		{
			TargetPoint = Normal(TargetPoint - p.BossTarget.Location);
		}
		else
		{
			TargetPoint = Normal(TargetPoint - DirectionActor.Location);
		}


		// Move the camera out slightly to get a better view
//		TargetPoint = TargetPoint * CameraDistance * 2;
		TargetPoint = TargetPoint * RealCameraDistance;

		camDistance = CameraOffset >> locRot;

		goalPoint = TargetPoint + p.Location + camDistance;

		goalPoint.z = p.Location.z + p.TargetEyeHeight + cameraHeight;

		CamCountDown = 0;
		bWasAiming = false;

		if (CheckForReverseCameraCollision(goalPoint) || !CameraCanSee(p))
		{
			// @PAB temp removal collision
//			goalPoint.z = p.Location.z + p.TargetEyeHeight;

			bCollide = false;
		}

		// make sure the goal point is halfway between the walls

		goalpoint = CentreCameraBetweenWalls(goalpoint);

//		CentreCameraBetweenWalls(goalpoint);

		trackingPoint = goalPoint - Location;

	throttleTrack(DeltaTime);
	MoveSmooth(trackingPoint);
//		DoMove(trackingPoint, deltatime);

		// @PAB remove when you wish to go back to a colliding camera
//		bCollide = false;
		SetCollisionState();
	}

	function vector CentreCameraBetweenWalls(vector TraceStart)
	{
	// check to see if the camera is about to collide with something, if it is, drop down to Harry's level

		local rotator	SideRot;
		local vector	TraceEnd;
		local vector	VectorToHarry;
		local vector	OldTraceStart;

		local vector	HitLocation;
		local vector	HitNormal;
		local actor		PossibleVictim;
		local int		DistanceToHarry;
		local float		DistanceLeft;
		local float		DistanceRight;

		local vector	NewGoalPoint;

		SideRot.yaw = rotation.yaw;

		SideRot.Yaw += 0x4000;		// Move yaw off to 90 degrees
		SideRot.pitch = 0;
		SideRot.roll  = 0;

		TraceEnd = Vector(SideRot);

		TraceEnd = TraceEnd * 512;

		TraceEnd = TraceEnd + TraceStart;

		PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

//		BaseHUD(p.MyHUD).DebugString = string(possiblevictim.name);

		if (possiblevictim != none)
		{
			DistanceRight = abs(vsize(HitLocation - TraceStart));
		}
		else
		{
			DistanceRight = 512;
		}

		// Go the other way

		TraceEnd = TraceEnd - TraceStart;
		TraceEnd = TraceStart - TraceEnd;

		PossibleVictim = Trace(HitLocation, HitNormal, TraceEnd, TraceStart);

//		BaseHUD(p.MyHUD).DebugString2 = string(possiblevictim.name);

		if (possiblevictim != none)
		{
			DistanceLeft = abs(vsize(HitLocation - TraceStart));
		}
		else
		{
			DistanceLeft = 512;
		}

/*			BaseHUD(p.MyHUD).DebugValA = DistanceLeft;
			BaseHUD(p.MyHUD).DebugValX = LocRot.Roll;
			BaseHUD(p.MyHUD).DebugValY = LocRot.Pitch;
			BaseHUD(p.MyHUD).DebugValZ = LocRot.Yaw;

			BaseHUD(p.MyHUD).DebugValA2 = DistanceRight;*/
/*			BaseHUD(p.MyHUD).DebugValX2 = p.Rotation.Roll;
			BaseHUD(p.MyHUD).DebugValY2 = p.Rotation.Pitch;
			BaseHUD(p.MyHUD).DebugValZ2 = p.Rotation.Yaw;
*/
		// Adjust the camera along this path

		NewGoalPoint = ((TraceEnd - TraceStart) * (DistanceLeft - DistanceRight) / (2 * 512));

/*			BaseHUD(p.MyHUD).DebugValX = NavP.location.x;
			BaseHUD(p.MyHUD).DebugValY = NavP.location.y;
			BaseHUD(p.MyHUD).DebugValZ = NavP.location.z;
*/
		NewGoalPoint += TraceStart;

		return NewGoalPoint;
	}

	function EndState()
	{
		p.MovementMode(false);
		p.BossTarget = none;
		DirectionActor = none;
		p.StandardTarget.gotostate('seeking');
	}

	function BeginState()
	{
		CameraType = CAM_TrollChase;
		p.clientmessage("Camera switch to Troll chase state");
		p.StandardTarget.gotostate('BossFollow');
		p.StandardTarget.TargetOffset = vect(100, 0 ,50);
	    CameraHeight	= 150.000000;
		CameraDistance	= 240.000;
		CameraAimOffsetState = vect(0, 0, 0);
	}

	begin:
	loop:
		sleep (0.0005);

		// Check bounding box for camera
		turntoward(p);
		goto 'loop';
}

/*-----------------------------------------------------*/

state CutState
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;


/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

function Tick(float DeltaTime)
{
/*	log("-------------------------------------------------------");
	log ("Position actor " $string(PositionActor.name));
	log ("Direction actor " $string(DirectionActor.name));*/
	PositionCamera(DeltaTime);
}

function PositionCamera(float DeltaTime)
{
	local vector	Speed;

	bCollide = false;

	if (PositionActor != none)
	{
//		BaseHUD(p.MyHUD).DebugString = string(positionactor.name);
	}
	
	if (DirectionActor != none)
	{
//		BaseHUD(p.MyHUD).DebugString2 = string(directionactor.name);
	}

	if (PositionActor != none)
	{
		trackingPoint = PositionActor.location - Location;

//		SetLocation(PositionActor.location);

	throttleTrack(DeltaTime);
	MoveSmooth(trackingPoint);
//		DoMove(trackingPoint, deltatime);

		if (vsize(location - PositionActor.location) < CutCameraProx)
		{

			if (CutNotifyScript != None)
			{
				//p.clientMessage(self $" Notifying:" $CutNotifyScript $" Cue:" $CutCueString);
				CutNotifyScript.CutCue(CutCueString);
	
				CutCueString = "";
				CutNotifyScript = None;
			}
		}
	}
	
		// @PAB remove when you wish to go back to a colliding camera
		bCollide = false;
		SetCollisionState();
}

	function EndState()
	{
//		setPhysics(PHYS_Rotating);

/*	    RotationRate.Pitch = 20000;
		RotationRate.Yaw = 20000;
		RotationRate.Roll = 20000;
	    GroundSpeed = 320.000000;
	    AirSpeed = 320.000000;
*/
		CameraType = CAM_Standard; //fixes issue where the camera locks sometimes after a cutscene -AdamJD
	}

	function BeginState()
	{
		CameraType = CAM_Cut;
//		setPhysics(PHYS_Interpolating);
		p.clientmessage("Camera switch to Cut state");
		p.StandardTarget.TargetOffset = vect(100, 0 ,50);
	    CameraHeight	= 120.000000;
		CameraDistance	= 80.000;
		CameraAimOffsetState = vect(0, 0, 0);

/*	    RotationRate.Pitch = 5000;
		RotationRate.Yaw = 5000;
		RotationRate.Roll = 5000;

	    GroundSpeed = 8.000000;
	    AirSpeed = 8.000000;
		MaxDesiredSpeed = 8;
		DesiredSpeed = 8;
		CameraSpeed = 0.1;
*/
		if (DirectionActor != none)
		{
			DesiredRotation = Rotator(DirectionActor.Location - Location);
			ViewRotation = DesiredRotation;
//			SetRotation(Rotator(DirectionActor.Location - Location));
//			ViewRotation = Rotation;
		}
		if (PositionActor != none)
		{
			SetLocation(PositionActor.location);
		}
	}

	begin:
	loop:
		sleep (0.0005);
		if (DirectionActor != none)
		{
			if(!bShake)
			{
				DesiredRotation = Rotator(DirectionActor.Location - Location);
				ViewRotation = DesiredRotation;
//			turntoward(DirectionActor);
			}
		}

		goto 'loop';
}

state QuidditchStateRot
{
//ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;


/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

function Tick(float DeltaTime)
{
	if (bInSpecialPause)
	{
		SaveState();
		gotostate('FreeCamState');
	}
	else
	{
		PositionCamera(DeltaTime);
	}
}

function Bump( Actor Other )
{
}

function HitWall( vector HitNormal, actor HitWall )
{
}

function Touch( Actor Other )
{
}

function PositionCamera(float DeltaTime)
{
	local vector	TargetPoint;
	local vector	goalPoint;
	local vector	camDistance;

	local float		camTotal;

	local vector	PositionDif;
	local bool		bMoved;

	local Rotator	LocRot;
	local int		DiffRoll;
	local int		TRoll;
	local int		TPitch;

	bCollide = false;

//	locRot.pitch = camPitch;
//	smoothRotate(p.ViewRotation, locRot, deltatime);

	// if(p.IsInState('playeraiming')) //AdamJD
	// {
		//cameraLock = true; //AdamJD
		if (!bWasAiming)
		{
			bWasAiming = true;
			NextTargetCam();
		}
	// }
	else
	{
		bWasAiming = false;
	}

//	log("Harry " $p.location.x $" " $p.location.y $" " $p.location.z);
//	log("camera " $location.x $" " $location.y $" " $location.z);
//	log("camera rotation " $rotation.pitch $" " $rotation.yaw $" " $rotation.roll);
/*	PositionDif = HarrysPreviousPosition - p.Location;

	if (PositionDif.x != 0 || PositionDif.y != 0 || PositionDif.z != 0)
	{
		bMoved = true;
		HarrysPreviousPosition = p.Location;
	}
	else
	{
		bMoved = false;
	}
*/
//	BaseHUD(p.MyHUD).DebugString = "Not moving";

//	LocRot = Rotation;
//	LocRot = Rotator(p.StandardTarget.Location - Location);

// @PAB rotation moved from here
	LocRot = Rotator(p.Location - location);
	
//	camPitch = LocRot.Pitch;

	TRoll = p.Rotation.roll & 0xFFFF;

	if (TRoll > 0x8000)
	{
		TRoll -= 0x10000;
	}

	DiffRoll = TargetRoll - TRoll;

	if (abs(DiffRoll) < 128)
	{
		TargetRoll = TRoll;
	}
	else
	{
		if (DiffRoll < 0)
		{
			TargetRoll += 128;
		}
		else
		{
			TargetRoll -= 128;
		}
	}
	LocRot.roll = TargetRoll;

//	BaseHUD(p.MyHUD).DebugValA = TRoll;
//	BaseHUD(p.MyHUD).DebugValA2 = TargetRoll;

//	log(Rotation.roll $"  " $p.Rotation.roll $"  " $TargetRoll);

/*	if (DiffRoll != 0)
	{
		if (DiffRoll < -32767)
		{
			TargetRoll += 65536;
			DiffRoll = TargetRoll - p.Rotation.roll;
		}
		else if (DiffRoll > 32767)
		{
			TargetRoll -= 65536;
			DiffRoll = TargetRoll - p.Rotation.roll;
		}


		if (abs(DiffRoll) < 256)
		{
			TargetRoll = p.Rotation.roll;
		}
		else
		{
			if (DiffRoll < 0)
			{
				TargetRoll += 128;
			}
			else
			{
				TargetRoll -= 128;
			}
		}
	}
*/

// Start move section

//	SmoothPitch(deltatime);
			
//	locRot.pitch = campitch;
			
			// @PAB new goal point
	TargetPoint = p.Location;
	TargetPoint.z = p.TargetEyeHeight + TargetPoint.z + cameraHeight;

	TargetPoint = Normal(TargetPoint - p.Location);
	TargetPoint = TargetPoint * RealCameraDistance;

	CamDistance = CameraOffset >> locRot;
	goalPoint = TargetPoint + p.Location + CamDistance;

//	CamDistance = vec(CameraDistance, 0, 0) >> locRot;
//	CamDistance = vec(-CameraDistance, 0, 0) >> locRot;
//	goalPoint = TargetPoint + CamDistance;

//	if (goalPoint.z < p.Location.z)
//	{
//		goalPoint.z = p.Location.z;
//	}

// @PAB rotation

	trackingPoint = goalPoint - Location;

	throttleTrack(DeltaTime);
	MoveSmooth(trackingPoint);
//	DoMove(trackingPoint, deltatime);

	LocRot = Rotator(p.Location - trackingPoint - Location);

	TPitch = p.Rotation.pitch & 0xffff;

	if (TPitch > 0x7fff)
	{
		TPitch -= 0x8000;
	}

	if (TPitch > 8000 || TPitch < -8000)
	{
		LocRot.Pitch = ((camPitch - LocRot.Pitch) / 2) + LocRot.Pitch;
		camPitch = LocRot.Pitch;
	}
	else if (abs(camPitch - LocRot.Pitch) > 1024)
	{
		if (camPitch > LocRot.Pitch)
		{
			LocRot.Pitch = camPitch - 4 * PitchIncrease;
		}
		else
		{
			LocRot.Pitch = camPitch + 4 * PitchIncrease;
		}
		camPitch = LocRot.Pitch;
	}
	else if (abs(camPitch - LocRot.Pitch) > 512)
	{
		if (camPitch > LocRot.Pitch)
		{
			LocRot.Pitch = camPitch - 2 * PitchIncrease;
		}
		else
		{
			LocRot.Pitch = camPitch + 2 * PitchIncrease;
		}
		camPitch = LocRot.Pitch;
	}
	else if (abs(camPitch - LocRot.Pitch) > 256)
	{
		if (camPitch > LocRot.Pitch)
		{
			LocRot.Pitch = camPitch - PitchIncrease;
		}
		else
		{
			LocRot.Pitch = camPitch + PitchIncrease;
		}
		camPitch = LocRot.Pitch;
	}
	else
	{
		LocRot.Pitch = camPitch;
	}
	
	LocRot.roll = TargetRoll;

//	log("camera new rotation " $locrot.pitch $" " $locrot.yaw $" " $locrot.roll);
	log("camera new rotation " $locrot.pitch $" " $campitch);

// End move section

		bRotateToDesired = true;
//		DesiredRotation = LocRot;
		SetRotation(LocRot);			
//		ViewRotation.Roll = TargetRoll;
		ViewRotation = LocRot;
//	}

/*			BaseHUD(p.MyHUD).DebugValA = Location.z;
			BaseHUD(p.MyHUD).DebugValX = LocRot.Roll;
			BaseHUD(p.MyHUD).DebugValY = LocRot.Pitch;
			BaseHUD(p.MyHUD).DebugValZ = LocRot.Yaw;

			BaseHUD(p.MyHUD).DebugValA2 = p.Location.z;
			BaseHUD(p.MyHUD).DebugValX2 = p.Rotation.Roll;
			BaseHUD(p.MyHUD).DebugValY2 = p.Rotation.Pitch;
			BaseHUD(p.MyHUD).DebugValZ2 = p.Rotation.Yaw;
*/
//	StoreMove();

//	CheckCollisionState(deltatime);

	// @PAB this one needs to be here, do not remove
	bCollide = false;

		SetCollisionState();
}

	function EndState()
	{
		setPhysics(PHYS_Rotating);
	}

	function BeginState()
	{
//		bCollideBox = false;
		SetPhysics(PHYS_None);
		CameraType = CAM_Quiditch;
		PitchIncrease = 16;
		p.clientmessage("Camera switch to Quiditch state");
		p.StandardTarget.TargetOffset = vect(100, 0 ,50);
	    CameraHeight	= 150.000000;
		CameraDistance	= 80.000;
		CameraAimOffsetState = vect(0, 0, 0);
	}

	begin:
loop:
		sleep (0.0005);
//		turntoward(p.StandardTarget);
/*		trot = Rotation;
		trot.Roll = TargetRoll;
		SetRotation(LocRot);			*/
//		ViewRotation = LocRot;			

//		goto 'loop';
}

/*-----------------------------------------------------*/


auto state() StartState
{
	function BeginState()
	{
		//not needed -AdamJD
		//PostBeginPlayIP();
		// p.gotostate('playerwalking');
		// p.ClientMessage("Going to state" $CameraType);
	}

	begin:
	//AdamJD
	InitSettings(true, false);
	InitTarget(p);
	InitPositionAndRotation( true );
	
	CameraType = CAM_Standard;
	SetCamera();
}

//AdamJD
state StateIdle
{
	//don't do anything
}

state Test3state
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;



/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

function Tick(float DeltaTime)
{
	if (bInSpecialPause)
	{
		SaveState();
		gotostate('FreeCamState');
	}
	else
	{
		PositionCamera(DeltaTime);
	}
}

function PositionCamera(float DeltaTime)
{
	local float		camTotal;

	local vector	PositionDif;
	local bool		bMoved;
	local rotator	viewrot;
	local float		PitchDif;

	bCollide = true;

/*	locRot.pitch = camPitch;
	smoothRotate(p.ViewRotation, locRot, deltatime);
*/
	// if(p.IsInState('playeraiming')) //AdamJD
	// {
		//cameraLock = true; //AdamJD
		if (!bWasAiming)
		{
			bWasAiming = true;
			NextTargetCam();
		}
	//}
	else
	{
		bWasAiming = false;
	}

/*	PositionDif = HarrysPreviousPosition - p.Location;

	if (PositionDif.x != 0 || PositionDif.y != 0 || PositionDif.z != 0)
	{
		bMoved = true;
		HarrysPreviousPosition = p.Location;
	}
	else
	{
		bMoved = false;
	}
*/
//	bMoved = false;

/*	if((bMoved && !cameraLock) && !p.bmovingbackwards)
	{
//		BaseHUD(p.MyHUD).DebugString = "Moving";
		GeneralMoveModeCamera(deltatime);
	}
	else		//Harry more or less stationary
	{*/
//		BaseHUD(p.MyHUD).DebugString = "Not moving";
		GeneralStationaryModeCamera(deltatime);
//	}
			
	StoreMove();

	CheckCollisionState(deltatime);

	// @PAB remove when you wish to go back to a colliding camera
//	bCollide = false;
	SetCollisionState();

	// Check to see if the camera should change its yaw

	bTurnToward = true;
/*	viewrot = rotator(p.location - location);
	PitchDif = rotation.yaw - viewrot.yaw;
	BaseHUD(p.MyHUD).DebugValA2 = PitchDif;
	if (PitchDif > -2000 && PitchDif < 2000)
	{
		BaseHUD(p.MyHUD).DebugString = "Not turning";
		bTurnToward = false;
	}
	else
	{
		BaseHUD(p.MyHUD).DebugString = "Turning";
		bTurnToward = true;
	}*/
}


	function BeginState()
	{
		CameraType = CAM_Test3;
		p.clientmessage("Camera switch to Test3 state");
		p.StandardTarget.TargetOffset = vect(75, 0 ,50);
	    CameraHeight	= 100.000000;
//	    CameraHeight	= 50.000000;
		CameraDistance	= 140.000;
//		CameraAimOffsetState = vect(80, 0, 0);
//		CameraAimOffsetState = vect(40, 0, 0);
		CameraAimOffsetState = vect(0, 0, 0);
//		CameraOffset = vect(140, -100, 0);
	}
	
	begin:
	loop:
		sleep (0.0005);
		if (bTurnToward)
		{
			if(!bShake)
			{
				turntoward(p.StandardTarget);
			}
		}
		goto 'loop';
}

/*-----------------------------------------------------*/

state PatrolState
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;


/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

	function Tick(float DeltaTime)
	{
		if (bInSpecialPause)
		{
			SaveState();
			gotostate('FreeCamState');
		}
		else
		{
			PositionCamera(DeltaTime);
		}
	}

	function PositionCamera(float DeltaTime)
	{
		local vector		TargetPoint;
		local float			fDistance;

		bCollide = true;
//		bcollideactors = true;

		if (NavP.location == LastNavP.location)
		{
			NextPatrolPoint();
		}
//		log("Nav point " $NavP.location.x $" "$NavP.location.y $" " $NavP.location.z);

		TargetPoint = NavP.location - LastNavP.location;
//		log("Target point " $TargetPoint.x $" "$TargetPoint.y $" " $TargetPoint.z);

		if (vsize(location - LastNavP.Location) >= vsize(location - p.Location))
		{
			fDistance = vsize(p.location - LastNavP.Location) + CameraDistance;
		}
		else
		{
			fDistance =  CameraDistance - vsize(p.location - LastNavP.Location);
		}

//		log("Distance " $fDistance);
//		log("Distance to Harry " $vsize(location - p.location));

		TargetPoint = TargetPoint * fDistance / vsize(TargetPoint);
//		log("New Target point " $TargetPoint.x $" "$TargetPoint.y $" " $TargetPoint.z);
		
		TargetPoint += LastNavP.location;

		TargetPoint.z = p.TargetEyeHeight + p.location.z + cameraHeight;

		if (CheckForReverseCameraCollision(TargetPoint))
		{
			// @PAB temp removal collision
			TargetPoint.z = p.Location.z + p.TargetEyeHeight;
//			bCollide = false;
		}

		trackingPoint = TargetPoint - location;

//		DoMove(trackingPoint, deltatime);
		throttleTrack(DeltaTime);
		movesmooth(trackingPoint);
		CheckPatrolPoint();

		// @PAB remove when you wish to go back to a colliding camera
		bCollide = false;
		SetCollisionState();
	}

	function CheckPatrolPoint()
	{
		if (abs(vsize(navp.location - p.location)) <= abs(vsize(location - p.location)))
		{
			NextPatrolPoint();
		}
	}

	function NextPatrolPoint()
	{
		tempNavP = navP;

		log("Next nav point");

		if( PatrolPoint(navP).NextPatrolPoint == none )
		{
			navP = FindClosestPatrolPoint( LastNavP, navP );  //Find closest, excluding Last one you were at, and the one you're currently at.
		}
		else
		{
			navP = PatrolPoint(navP).NextPatrolPoint;
		}

		LastNavP = tempNavP;
	}

	function PatrolPoint FindClosestPatrolPoint( actor ExclusionActor1, actor ExclusionActor2 )
	{
		local PatrolPoint     tempPatrolPoint;
		local float           fDist, fClosestDist;
		local PatrolPoint     ClosestActor;

		fClosestDist = 100000;

		//Hope this isn't too slow doing this...

		foreach AllActors(class'PatrolPoint', tempPatrolPoint)
		{
			fDist = VSize( Location - tempPatrolPoint.Location );

			if(   tempPatrolPoint != ExclusionActor1
			   && tempPatrolPoint != ExclusionActor2
			   && fDist < fClosestDist
			)
			{
				fClosestDist = fDist;
				ClosestActor = tempPatrolPoint;
			}
		}

		return ClosestActor;
	}

	function EndState()
	{
	}

	function BeginState()
	{
		CameraType = CAM_Patrol;
		p.clientmessage("Camera switch to Patrol state");
	    CameraHeight	= 160.000000;
		CameraDistance	= 400.000;
		CameraAimOffsetState = vect(0, 0, 0);
		// find the first patrol point

		if( navP == none )
		{
			if( firstPatrolPointTag != '' )
			{
				foreach allActors(class 'navigationPoint',navP,firstPatrolPointTag)
					break;
			}
			LastNavP = navP;
		}
	}

	begin:

/*			BaseHUD(p.MyHUD).DebugValX = NavP.location.x;
			BaseHUD(p.MyHUD).DebugValY = NavP.location.y;
			BaseHUD(p.MyHUD).DebugValZ = NavP.location.z;
*/
	loop:
		sleep (0.0005);
		if(!bShake)
		{
			turntoward(p);
		}

		goto 'loop';
}

/*-----------------------------------------------------*/

state TopDownstate
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;



/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

function Tick(float DeltaTime)
{
	if (bInSpecialPause)
	{
		SaveState();
		gotostate('FreeCamState');
	}
	else
	{
		PositionCamera(DeltaTime);
	}
}

function PositionCamera(float DeltaTime)
{
	local rotator	CurrentRotation;

	bCollide = false;

	trackingPoint = p.location;

	trackingpoint.z = p.location.z + CameraHeight;

	trackingPoint = trackingPoint - location;

	throttleTrack(DeltaTime);
	MoveSmooth(trackingPoint);
//	DoMove(trackingPoint, deltatime);

		// @PAB remove when you wish to go back to a colliding camera
//		bCollide = false;
		SetCollisionState();
}

	function BeginState()
	{
		CameraType = CAM_TopDown;
		p.clientmessage("Camera switch to TopDown state");
		p.StandardTarget.TargetOffset = vect(25, 0, 0);
	    CameraHeight	= 200.000000;
		CameraDistance	= 140.000;
		CameraAimOffsetState = vect(0, 0, 0);
	}

	begin:
	loop:
		sleep (0.0005);
		if(!bShake)
		{
			turntoward(p.StandardTarget);
		}

		goto 'loop';
}

state QuidditchState
{

ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;


/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

function Tick(float DeltaTime)
{
	if (bInSpecialPause)
	{
		SaveState();
		gotostate('FreeCamState');
	}
	else
	{
		PositionCamera(DeltaTime);
	}
}

function PositionCamera(float DeltaTime)
{
	local float		camTotal;

	local vector	PositionDif;
	local bool		bMoved;

	bCollide = true;

	locRot.pitch = camPitch;
	smoothRotate(p.ViewRotation, locRot, deltatime);

	// if(p.IsInState('playeraiming')) //AdamJD
	// {
		//cameraLock = true; //AdamJD
		if (!bWasAiming)
		{
			bWasAiming = true;
			NextTargetCam();
		}
	//}
	else
	{
		bWasAiming = false;
	}

	PositionDif = HarrysPreviousPosition - p.Location;

	if (PositionDif.x != 0 || PositionDif.y != 0 || PositionDif.z != 0)
	{
		bMoved = true;
		HarrysPreviousPosition = p.Location;
	}
	else
	{
		bMoved = false;
	}

//	if((bMoved && !cameraLock) && !p.bmovingbackwards)
//	{
//		BaseHUD(p.MyHUD).DebugString = "Moving";
//		GeneralMoveModeCamera(deltatime);
//	}
//	else		//Harry more or less stationary
//	{
//		BaseHUD(p.MyHUD).DebugString = "Not moving";
		GeneralStationaryModeCamera(deltatime);
//	}
			
	CheckCollisionState(deltatime);

		// @PAB remove when you wish to go back to a colliding camera
//		bCollide = false;
		SetCollisionState();
}

	function BeginState()
	{
		CameraType = CAM_Quiditch;
		p.clientmessage("Camera switch to Quidditch state");
		p.StandardTarget.TargetOffset = vect(100, 0 ,50);
		//not needed -AdamJD
	    // CameraHeight	= 60.000000;
		// CameraDistance	= 150.000;
		// CameraAimOffsetState = vect(0, 0, 0);
	}

	begin:
	
	//not needed -AdamJD
	// loop:
		// sleep (0.0005);
		// if(!bShake)
		// {
			// turntoward(p.StandardTarget);
		// }

		// goto 'loop';
}

state FreeCamState
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;



/*-----------------------------------------------------*/

function BeginState()
{
	CameraType = CAM_FreeCam;
	p.clientmessage("Camera switch to FreeCam state");
	//AdamJD
	fDistanceScalar		= 1.0f;
	rRotationStep		= rot(0,0,0);
	rSavedRotation		= rotation;
	bSyncPositionWithTarget	= false;
	bSyncRotationWithTarget	= false;
}

// this function is used to set the camera to a set location and give it something to look at
function Tick(float /*DeltaTime*/ fTimeDelta) //AdamJD
{
//	PositionCamera(DeltaTime);

	if (bInSpecialPause) 
	{
		//PositionCamera(DeltaTime);
		SetCamera(/*CAM_Standard*/); //AdamJD
	}
	
	//not needed -AdamJD
	// else
	// {
		// RestoreState(true);
	// }
	
	//AdamJD
	fMouseDeltaX = p.SmoothMouseX * fTimeDelta;
	fMouseDeltaY = p.SmoothMouseY * fTimeDelta;
		
	//cap mouseDelta x -AdamJD
	if( fMouseDeltaX > MAX_MOUSE_DELTA_X )		
	{
		fMouseDeltaX = MAX_MOUSE_DELTA_X;
	}
	
	else if( fMouseDeltaX < MIN_MOUSE_DELTA_X )
	{	
		fMouseDeltaX = MIN_MOUSE_DELTA_X;
	}
	
	//cap mouseDelta y -AdamJD	
	if( fMouseDeltaY > MAX_MOUSE_DELTA_Y )		
	{
		fMouseDeltaY = MAX_MOUSE_DELTA_Y;
	}
	
	else if( fMouseDeltaY < MIN_MOUSE_DELTA_Y ) 
	{
		fMouseDeltaY = MIN_MOUSE_DELTA_Y;
	}
//}

//not needed -AdamJD
// function PositionCamera(float DeltaTime)
// {
	/*local rotator	CurrentRotation;

	BaseHUD(p.MyHUD).Debugstring = string(victim.name);
	BaseHUD(p.MyHUD).DebugValx = SmoothMouseX;
	BaseHUD(p.MyHUD).DebugValy = SmoothMouseY;
	BaseHUD(p.MyHUD).DebugValz = p.aup;
	BaseHUD(p.MyHUD).DebugVala = p.TargetHitLocation.z;

	if (baseconsole(p.player.console).bForwardKeyDown)
	{
		trackingpoint = (vect(25, 0, 0) >> Rotation);
	}
	else if (baseconsole(p.player.console).bBackKeyDown)
	{
		trackingpoint = (vect(-25, 0, 0) >> Rotation);
	}

	if (baseconsole(p.player.console).bRightKeyDown)
	{
		trackingpoint = (vect(0, 25, 0) >> Rotation);
	}
	else if (baseconsole(p.player.console).bLeftKeyDown)
	{
		trackingpoint = (vect(0, -25, 0) >> Rotation);
	}

	if (baseconsole(p.player.console).bUpKeyDown)
	{
		trackingpoint = (vect(0, 0, 25) >> Rotation);
	}
	else if (baseconsole(p.player.console).bDownKeyDown)
	{
		trackingpoint = (vect(0, 0, -25) >> Rotation);
	}
	
	if (baseconsole(p.player.console).bRotateRightKeyDown)
	{
		CurrentRotation = Rotation;
		CurrentRotation.Yaw += 256;
		CurrentRotation.Yaw = CurrentRotation.Yaw & 0xffff;
		DesiredRotation = CurrentRotation;
	}
	else if (baseconsole(p.player.console).bRotateLeftKeyDown)
	{
		CurrentRotation = Rotation;
		CurrentRotation.Yaw -= 256;
		CurrentRotation.Yaw = CurrentRotation.Yaw & 0xffff;
		DesiredRotation = CurrentRotation;
	}

	if (baseconsole(p.player.console).bRotateUpKeyDown)
	{
		CurrentRotation = Rotation;
		CurrentRotation.Pitch += 256;
		CurrentRotation.Pitch = CurrentRotation.Pitch & 0xffff;
		DesiredRotation = CurrentRotation;
	}
	else if (baseconsole(p.player.console).bRotateDownKeyDown)
	{
		CurrentRotation = Rotation;
		CurrentRotation.Pitch -= 256;
		CurrentRotation.Pitch = CurrentRotation.Pitch & 0xffff;
		DesiredRotation = CurrentRotation;
	}

	throttleTrack(DeltaTime);
	movesmooth(trackingPoint);

	bCollide = false;
	SetCollisionState();*/
	
	//AdamJD
	if( baseconsole(p.player.console).bForwardKeyDown )
	{
		vDestPosition += (vect(1, 0, 0) >> Rotation) * fMoveSpeed  * fTimeDelta;
	}
		
	else if( baseconsole(p.player.console).bBackKeyDown )
	{
		vDestPosition += (vect(-1, 0, 0) >> Rotation) * fMoveSpeed * fTimeDelta;
	}	
		
	if( baseconsole(p.player.console).bRightKeyDown )
	{
		vDestPosition += (vect(0, 1, 0) >> Rotation) * fMoveSpeed  * fTimeDelta;
	} 
	
	else if( baseconsole(p.player.console).bLeftKeyDown )
	{
		vDestPosition += (vect(0, -1, 0) >> Rotation) * fMoveSpeed * fTimeDelta;
	}	
		
	if( baseconsole(p.player.console).bUpKeyDown )
	{
		vDestPosition += (vect(0, 0, 1) >> Rotation) * fMoveSpeed  * fTimeDelta;
		
	}
	
	else if( baseconsole(p.player.console).bDownKeyDown )
	{
		vDestPosition += (vect(0, 0, -1) >> Rotation) * fMoveSpeed * fTimeDelta;
	}
	
	//update rotation -AdamJD
	if( baseconsole(p.player.console).bRotateRightKeyDown)
	{
		rDestRotation.Yaw += fRotSpeed * fTimeDelta;
	}
	
	else if( baseconsole(p.player.console).bRotateLeftKeyDown)
	{
		rDestRotation.Yaw -= fRotSpeed * fTimeDelta;
	}
		
	if( baseconsole(p.player.console).bRotateUpKeyDown)
	{
		rDestRotation.Pitch += fRotSpeed * fTimeDelta;
	}
	
	else if( baseconsole(p.player.console).bRotateDownKeyDown)
	{
		rDestRotation.Pitch -= fRotSpeed * fTimeDelta;
	}
		
	//add rotation from mouse input -AdamJD
	rDestRotation.Yaw   += fMouseDeltaX * fRotSpeed;
	rDestRotation.Pitch += fMouseDeltaY * fRotSpeed;
		
	//smoothly update rotation -AdamJD
	rCurrRotation += (rDestRotation - rCurrRotation ) * FMin( 1.0f, fRotTightness * fTimeDelta );
	DesiredRotation = rCurrRotation;
	SetRotation( DesiredRotation );
}
	begin:
	//not needed -AdamJD
	// loop:
		// sleep (0.0005);
//		turntoward(p.StandardTarget);

		//goto 'loop';
}

/*-----------------------------------------------------*/
state Test2state
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;



/*-----------------------------------------------------*/

// this function is used to set the camera to a set location and give it something to look at

function Tick(float DeltaTime)
{
	if (bInSpecialPause)
	{
		SaveState();
		gotostate('FreeCamState');
	}
	else
	{
		PositionCamera(DeltaTime);
	}
}

function PositionCamera(float DeltaTime)
{
	local float		camTotal;

	local vector	PositionDif;
	local bool		bMoved;
	local rotator	viewrot;
	local float		PitchDif;

	bCollide = true;

/*	locRot.pitch = camPitch;
	smoothRotate(p.ViewRotation, locRot, deltatime);
*/
	// if(p.IsInState('playeraiming')) //AdamJD
	// {
		//cameraLock = true; //AdamJD
		if (!bWasAiming)
		{
			bWasAiming = true;
			NextTargetCam();
		}
	// }
	else
	{
		bWasAiming = false;
	}

	GeneralStationaryModeCamera(deltatime);
			
	StoreMove();

	CheckCollisionState(deltatime);

	// @PAB remove when you wish to go back to a colliding camera
	bCollide = false;
	SetCollisionState();

	// Check to see if the camera should change its yaw

	bTurnToward = true;
}

	function BeginState()
	{
		CameraType = CAM_Test2;
		p.clientmessage("Camera switch to Test2 state");
		p.StandardTarget.TargetOffset = vect(75, 0 ,50);
	    CameraHeight	= 100.000000;
//	    CameraHeight	= 50.000000;
		CameraDistance	= 140.000;
//		CameraAimOffsetState = vect(80, 0, 0);
//		CameraAimOffsetState = vect(40, 0, 0);
		CameraAimOffsetState = vect(0, 0, 0);
//		CameraOffset = vect(140, -100, 0);
	}

	begin:
	loop:
		sleep (0.0005);
		if (bTurnToward)
		{
			if(!bShake)
			{
				turntoward(p.StandardTarget);
			}
		}
		goto 'loop';
}

//AdamJD functions (some are copied from the HP2 proto, I was really struggling...)

//old mouse axis functions by me
/*
function xMouseAxis(float DeltaTime)
{
	local float   rotatespeed;
	
	rotvalX = p.SmoothMouseX * DeltaTime;
	rotatespeed = 4.0f;
	
	CurrentRot.Yaw = rotvalX * rotatespeed;
}

function yMouseAxis(float DeltaTime)
{
	local float   rotatespeed;
	
	rotvalY = p.SmoothMouseY * DeltaTime;
	rotatespeed = 4.0f;
	
	CurrentRot.Pitch = rotvalY * rotatespeed;
}
*/

//set up the camera settings
function InitSettings(bool bSyncWithTargetPos, bool bSyncWithTargetRot)
{
	fDistanceScalar = 1.0f;
	rRotationStep = rot(0,0,0);
	rSavedRotation = rotation;
	bSyncRotationWithTarget = bSyncWithTargetRot;
	bSyncPositionWithTarget	= bSyncWithTargetPos;
	fDistanceScalarMin = DISTANCE_SCALAR_MIN;
	fCurrLookAtDistance	= fLookAtDistance;
}

//set up cam target settings
function InitTarget(actor A)
{
	camTarget.SetAttachedTo(A);
	camTarget.SetOffset( vLookAtOffset );
}

//copied from the HP2 proto
function InitRotation( rotator rot )
{
	rDestRotation.yaw	= rot.yaw	& 0xFFFF;
	// rDestRotation.pitch	= rot.pitch & 0xFFFF; //BUG UPDATE (08/03/2020) [DD/MM/YYYY] This was making the camera shoot upwards after a cutscene... //AdamJD
	// rDestRotation.roll	= rot.roll  & 0xFFFF; //BUG UPDATE (08/03/2020) [DD/MM/YYYY] This was making the camera shoot upwards after a cutscene... //AdamJD
	vForward			= normal(vector(DesiredRotation));
	rCurrRotation		= rDestRotation;
	DesiredRotation		= rDestRotation;
	SetRotation( DesiredRotation );
}

//copied from the HP2 proto
function InitPosition( vector pos, optional float deltatime )
{
	vDestPosition  = pos;

	//check camera collision with world -AdamJD
	CheckCollisionWithWorld();

	vCurrPosition  = vDestPosition;
	SetLocation( vDestPosition );
}

//set up dest rotation
function SetDestRotation( rotator newRot )
{
	rDestRotation = newRot;
}

//set up position and rotation settings
function InitPositionAndRotation( bool bSnapToNewPosAndRot, optional float deltatime )
{
	if( bSnapToNewPosAndRot )
	{
		InitRotation( camTarget.rotation );
		InitPosition( camTarget.location+((vec(-fLookAtDistance,0,0))>>rDestRotation) );
	}
	else
	{
		SetDestRotation( CamTarget.rotation );
		
		vDestPosition = CamTarget.location + ((vec(-(fLookAtDistance),0,0))>>rDestRotation);
		
		//check camera collision with world
		CheckCollisionWithWorld();
	}
	rDestRotation.roll = 0;
	rCurrRotation.roll = 0;
}

//get mouse x axis
function ApplyMouseXToDestYaw( float fTimeDelta)
{
	fMouseDeltaX = p.SmoothMouseX * fTimeDelta;
	
	//cap the fMouseDeltaX
	if( fMouseDeltaX > MAX_MOUSE_DELTA_X )	
	{	
		fMouseDeltaX = MAX_MOUSE_DELTA_X;
	}
	
	else if( fMouseDeltaX < MIN_MOUSE_DELTA_X ) 
	{
		fMouseDeltaX = MIN_MOUSE_DELTA_X;
	}
	
	//update dest rotation	
	rDestRotation.Yaw += fMouseDeltaX * fRotSpeed;
}

//get mouse y axis
function ApplyMouseYToDestPitch( float fTimeDelta)
{
	fMouseDeltaY = p.SmoothMouseY * fTimeDelta;	
	
	//cap the fMouseDeltaY
	if( fMouseDeltaY > MAX_MOUSE_DELTA_Y )	
	{	
		fMouseDeltaY = MAX_MOUSE_DELTA_Y;
	}
	
	else if( fMouseDeltaY < MIN_MOUSE_DELTA_Y ) 
	{
		fMouseDeltaY = MIN_MOUSE_DELTA_Y;
	}
	
	//update dest rotation
	rDestRotation.Pitch += fMouseDeltaY * fRotSpeed;
		
	//cap the rDestRotation
	if( rDestRotation.Pitch > fCurrentMaxPitch )		
	{
		rDestRotation.Pitch  = fCurrentMaxPitch;
	}
	
	else if( rDestRotation.Pitch < fCurrentMinPitch )	
	{
		rDestRotation.Pitch = fCurrentMinPitch;
	}
}

//copied from the HP2 proto
function SetFinalRotation( rotator r )
{
	r += rExtraRotation;
	rExtraRotation = rot(0,0,0);

	DesiredRotation = r;
	SetRotation( r );
}

//update rotation
function UpdateRotation( float fTimeDelta )
{
	local float	fTravelScalar;
		
	rDestRotation += rRotationStep * fTimeDelta;
	
	//if true immediatly face target
	if( bSyncRotationWithTarget )
	{
		rCurrRotation = rotator(CamTarget.location - location);
	}
	
	else 
	{
		//clamp travel scalar 
		if( fRotTightness > 0.0f )
		{
			fTravelScalar = FMin( 1.0f, fRotTightness * fTimeDelta );
		}
		
		else
		{
			fTravelScalar = 1.0f;
		}
		
		rCurrRotation += ( rDestRotation - rCurrRotation ) * fTravelScalar;	
	}
	
	//update vForward
	vForward = normal(vector(rCurrRotation));
	
	SetFinalRotation( rCurrRotation );
}

//update position
function UpdatePosition( float fTimeDelta )
{
	local float fTravelScalar;
	
	if( bSyncPositionWithTarget )
	{
		vDestPosition = CamTarget.location + ((vec(-(fCurrLookAtDistance ),0,0)) >> rCurrRotation );	
	}
	
	//check camera collision with world -AdamJD
	CheckCollisionWithWorld();
	
	//clamp travel scalar
	if( fMoveTightness > 0.0f )
	{
		fTravelScalar = FMin( 1.0f, fMoveTightness * fTimeDelta );
	}
	
	else
	{
		fTravelScalar = 1.0f;
	}

	vCurrPosition += ( vDestPosition - vCurrPosition ) * fTravelScalar;
	SetLocation( vCurrPosition );
}

//update distance scalar
function UpdateDistanceScalar( float fTimeDelta )
{
	local float fDestLookAtDistance;
	
	if( rCurrRotation.Pitch > fPitchMovingInThreshold )
	{
		//calculate distance scalar
		fDistanceScalar = 1.0f - ( rCurrRotation.Pitch / fPitchMovingInSpread );
		
		//stop camera at harry's head
		if( fDistanceScalar < fDistanceScalarMin)
		{
			fDistanceScalar = fDistanceScalarMin;
		}
		
		fDestLookAtDistance = fLookAtDistance * fDistanceScalar;
	}
	else
	{
		fDistanceScalar = 1.0f;
		fDestLookAtDistance = fLookAtDistance;
	}
	
	//collision stuff
	if(	fCurrLookAtDistance < fDestLookAtDistance )
	{
		fCurrLookAtDistance += (fDestLookAtDistance - fCurrLookAtDistance ) * FMin( 1.0f, fMoveBackTightness * fTimeDelta );		 	
	}
	else
	{
		fCurrLookAtDistance = fDestLookAtDistance;
	}
} 

//finally add collision to camera
function bool CheckCollisionWithWorld()
{
	local vector	HitLocation;
	local vector	HitNormal;
	local actor		HitActor;
	local vector	LookAtPoint;
	local vector    LookFromPoint;
	local vector	vCusionFromWorld;

	LookAtPoint	= CamTarget.location;
	
	//do a trace with the line from the target actor's location to cam targets location 
	if( CamTarget.aAttachedTo != None && (CamTarget.vOffset.x != 0 || CamTarget.vOffset.y != 0 || CamTarget.vOffset.z != 0) )
	{
		//make sure that CamTarget.location is inside the level
		HitActor = Trace( HitLocation, HitNormal, camTarget.Location, camTarget.aAttachedTo.location, false );
		if( HitActor != None && HitActor.IsA('levelInfo') )
		{
			//the cam target has hit something
			LookAtPoint = HitLocation + ( normal(camTarget.aAttachedTo.location - HitLocation) * 5.0f) + HitNormal;
		}
	}
	
	vCusionFromWorld = normal(LookAtPoint-vDestPosition) * 5.0f;
	LookFromPoint = vDestPosition - vCusionFromWorld;
	
	foreach TraceActors(class'actor', HitActor, HitLocation, HitNormal, LookFromPoint, LookAtPoint )
	{
		if( HitActor == Owner )
		{
			continue;
		}
		
		if( HitActor.IsA('levelInfo') )
		{
			if(!IsInState('BossState')) //stop camera going right above Harrys head when hitting something in the boss state -AdamJD
			{
				//move camera a bit away from the hit location
				vDestPosition       = HitLocation + vCusionFromWorld;
				fCurrLookAtDistance = vsize(vDestPosition - LookAtPoint);

				return true;
			}
		}
	}
	
	return false;
}

/*-----------------------------------------------------*/

state Standardstate
{
	ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;



/*-----------------------------------------------------*/

	function BeginState()
	{
		//org not needed retail code -AdamJD
		// CameraType = CAM_Standard; 
		// p.clientmessage("Camera switch to Standard state"); 
		// p.StandardTarget.TargetOffset = vect(75, 0 ,50); 
		//SetPhysics(PHYS_NONE); 
	    // CameraHeight	= 80.000000; 
//	   // CameraHeight	= 50.000000;
		// CameraDistance	= 150.000; 
//		//CameraAimOffsetState = vect(80, 0, 0);
//		//CameraAimOffsetState = vect(40, 0, 0);
		// CameraAimOffsetState = vect(0, 0, 0); 
//		CameraOffset = vect(140, -100, 0);

		//Init the camera -AdamJD
		InitSettings(true, false);
		InitTarget(p);
		InitPositionAndRotation(true);
	}

	function EndState()
	{
//		SetPhysics(PHYS_ROTATING);

		//AdamJD
		rSavedRotation = rCurrRotation;
	}
	
	// this function is used to set the camera to a set location and give it something to look at
	function Tick(float DeltaTime)
	{
		local vector	tpoint;
		
		local float		camTotal;

		local vector	PositionDif;
		local bool		bMoved;
		local rotator	viewrot;
		local float		PitchDif;
		
		//bCollide = true;

	/*	locRot.pitch = camPitch;
		smoothRotate(p.ViewRotation, locRot, deltatime);
	*/
		
		// if(p.IsInState('playeraiming')) //AdamJD
		// {
			//cameraLock = true; //AdamJD
		//now not needed -AdamJD
		/*
		if (!bWasAiming)
		{
			bWasAiming = true;
			NextTargetCam();
		}
		//}
		else
		{
			bWasAiming = false;
		}

		GeneralStationaryModeCamera(deltatime, true);
				
		StoreMove();

		CheckCollisionState(deltatime);

		//@PAB remove when you wish to go back to a colliding camera
		SetCollisionState();

		Check to see if the camera should change its yaw

		bTurnToward = true;
		
		else
		{
			PositionCamera(DeltaTime);
		}
		
		tpoint = p.standardTarget.targetOffset;
		tpoint = tpoint >> p.rotation;
		tpoint += p.location;

		// if (!p.IsInState('playeraiming')) //AdamJD
		// {
		SetRotation(rotator(tpoint - location));
		DesiredRotation = rotator(tpoint - location);
		ViewRotation = rotator(tpoint - location);
		// }*/

		//retail commented out code
		/*SetRotation(rotator(p.StandardTarget.location - location));
		DesiredRotation = rotator(p.StandardTarget.location - location);
		ViewRotation = rotator(p.StandardTarget.location - location);*/
		
		//apply mouse input to dest rotation -AdamJD
		ApplyMouseXToDestYaw( DeltaTime);
		ApplyMouseYToDestPitch( DeltaTime );

		//update rotation -AdamJD
		UpdateRotation( DeltaTime );
		
		//update position -AdamJD
		UpdatePosition( DeltaTime );
			
		//update distance scalar -AdamJD
		UpdateDistanceScalar( DeltaTime );
		
		//goto free cam state if in special pause -AdamJD
		if (bInSpecialPause)
		{
			SaveState();
			gotostate('FreeCamState');
		}
	}

	begin:
	//not needed -AdamJD
	/*
	loop:
		sleep (0.0005);
		if (bTurnToward)
		{
			if (p.IsInState('playeraiming'))
			{
				turntoward(p.StandardTarget);
			}
		}
		goto 'loop';
	*/
//}
	
//retail commented out code -AdamJD
//	if (p.IsInState('playeraiming'))
//	{
//		tpoint = vect(0, 0, 50);
//
////		tpoint.z = 100 * (p.standardTarget.location.z - p.Location.z) / vsize(p.standardTarget.location - p.Location);
//
////		tpoint.z = p.standardTarget.targetOffset.z;
////		if (tpoint.z > 80)
////		{
////			tpoint.z -= 30;
////		}
////		else if (tpoint.z < 20)
////		{
////			tpoint.z += 30;
////		}
////		else
////		{
////			tpoint.z = 50;
////		}
////		tpoint = tpoint >> p.rotation;
//		SetRotation(rotator(p.location + tpoint - location));
//		DesiredRotation = rotator(p.location + tpoint - location);
//		ViewRotation = rotator(p.location + tpoint - location);
//	}
//	else
//	{
//		if(!bShake)
//		{
//			tpoint = vect(0, 0, 50);
////			tpoint.z = 100 * (p.standardTarget.location.z - p.Location.z) / vsize(p.standardTarget.location - p.Location);
////			tpoint.z = p.standardTarget.targetOffset.z;
////		tpoint = tpoint >> p.rotation;
//			SetRotation(rotator(p.location + tpoint - location));
//			DesiredRotation = rotator(p.location + tpoint - location);
//			ViewRotation = rotator(p.location + tpoint - location);
//		}
//	}
}

//old retail function (moved code to StandardState) -AdamJD
/*function PositionCamera(float DeltaTime)
{
	local float		camTotal;

	local vector	PositionDif;
	local bool		bMoved;
	local rotator	viewrot;
	local float		PitchDif;
	
	bCollide = true;*/

/*	locRot.pitch = camPitch;
	smoothRotate(p.ViewRotation, locRot, deltatime);
*/
	//AdamJD
/*	// if(p.IsInState('playeraiming')) //AdamJD
	// {
		//cameraLock = true; //AdamJD
		if (!bWasAiming)
		{
			bWasAiming = true;
			NextTargetCam();
		}
	//}
	else
	{
		bWasAiming = false;
	}

	GeneralStationaryModeCamera(deltatime, true);
			
	StoreMove();

	CheckCollisionState(deltatime);

	// @PAB remove when you wish to go back to a colliding camera
	SetCollisionState();

	// Check to see if the camera should change its yaw

	bTurnToward = true;
}

	function EndState()
	{
//		SetPhysics(PHYS_ROTATING);
	}

	function BeginState()
	{
		CameraType = CAM_Standard;
		p.clientmessage("Camera switch to Standard state");
		p.StandardTarget.TargetOffset = vect(75, 0 ,50);
//		SetPhysics(PHYS_NONE);
	    CameraHeight	= 80.000000;
//	    CameraHeight	= 50.000000;
		CameraDistance	= 150.000;
//		CameraAimOffsetState = vect(80, 0, 0);
//		CameraAimOffsetState = vect(40, 0, 0);
		CameraAimOffsetState = vect(0, 0, 0);
//		CameraOffset = vect(140, -100, 0);
	}

	begin:
	loop:
		sleep (0.0005);*/
		//AdamJD
		/*if (bTurnToward)
		{
			if (p.IsInState('playeraiming'))
			{
				turntoward(p.StandardTarget);
			}
		}*/
		// goto 'loop';
// }

/*-----------------------------------------------------*/

//auto state() splinefly
/*state() splinefly
{



function PostBeginPlay()
{

		
		hasPoints = false;

		Super.PostBeginPlay();




		foreach AllActors( class 'InterpolationPoint', i )
		{
		
			if( i.Position == 0 )
			{
				
				bCollideWorld = False;
				SetLocation(i.Location);
				SetRotation(i.Rotation);
				hasPoints = true;		
				StartInterpolation(i.Next, 1.0, true);
			}

		}
		setPhysics(PHYS_Flying);
}


function Tick(float DeltaTime)
{

		if(!hasPoints)
		{
			PostBeginPlayIP();
			gotostate ('StandardState');
		}


}


function FinishedInterpolation(InterpolationPoint Other)
{
	log("interpolation ended");
	PostBeginPlayIP();
	p.gotostate('playerwalking');
	gotostate ('StandardState');
}


}
*/
function CutMoveTo(actor dest,baseScript script,string cue)
{
	PositionActor = dest;
	CutNotifyScript = script;
	CutCueString = cue;

		//this is an error.
	if(dest == None)
	{
			//send this back to avoid a hang in the script.
		CutNotifyScript.CutCue(CutCueString);

		CutCueString = "";
		CutNotifyScript = None;

		return;
	}
}

/*state CutMovingTo
{

Begin:

moveLoop:
	
	do
	{
		moveTo(PositionActor.location);
//		sleep(0.05);
	} until (vsize(location - PositionActor.location) < 5.0);

/* How the hell did this _ever_ work. CutWalkDest isnt set anywhere. boggle.
	do
	{
		moveTo(CutWalkDest.location);
		sleep(0.05);
	} until (vsize(location - CutWalkDest.location) < 5.0);

*/

	if(CutNotifyScript != None)
	{
		//p.clientMessage(self $" Notifying:" $CutNotifyScript $" Cue:" $CutCueString);
		CutNotifyScript.CutCue(CutCueString);

		CutCueString = "";
		CutNotifyScript = None;
	}

	SetCamera();	// old state remembered
}

*/

//	 CameraType=CAM_Standard
//	 CameraType=CAM_Quiditch
//     RotationRate=(Pitch=20000,Yaw=20000,Roll=20000)

defaultproperties
{
	bRotateToDesired=false
	
	bHidden=true
	bBlockActors=false
	bBlockPlayers=false

 	bCanMoveInSpecialPause=true
	
	//retail not needed defaults -AdamJD
     //cameraLock=True
     //lockBias=1
     //bUseStrafing=True
     //bHidden=True
     //bCanMoveInSpecialPause=True
     //CollisionRadius=0.1
     //bBlockActors=False
     //bBlockPlayers=False
     //RotationRate=(Pitch=20000,Yaw=20000,Roll=20000)
	 
	//AdamJD defaults
	bSyncPositionWithTarget=true

	fCurrentMinPitch=-14000.0f	
	fCurrentMaxPitch=14000.0f

	fDistanceScalar=1.0f
	
	fMoveBackTightness=2.5f
	
	//standard cam settings -AdamJD
	vLookAtOffset=(X=0,Y=0,Z=55.0f)
	fLookAtDistance=128.0f
	fRotTightness=8.0f
	fRotSpeed=4.0f
	fMoveTightness=0.0f
	fMoveSpeed=0.0f
}
