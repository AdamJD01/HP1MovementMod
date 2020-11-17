// HARRY POTTER camera code 
//________________________________________________________________________________________
 class QuidCam extends Pawn;

 

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


 var(camera) float CameraDistance;
 var(camera) float CameraHeight;
 var(camera) float CameraSpeed;
 var(camera) float lockBias;
 var(camera) float cameraRotSpeed;

	var (patrol) name stationDestination;
	var (patrol) int stationNumber;
	var (patrol) name pathType;
	var (patrol) name firstPath;



 	var actor forcelocation;
	var vector forcedir;
	var actor lookatMe;
var InterpolationPoint i;

var vector	CamAimOffset[5];
var int		CamIndex;
var	float	CamCountdown;

function PostBeginPlay()
{
	local int count;


	
	Super.PostBeginPlay();

	count=0;
	while(count<16)
	{
		previousLocations[count].X=0;
		previousLocations[count].Y=0;
		previousLocations[count].Z=0;
		count=count+1;
	}
	currentLocation=0;

	//@PAB
	trackingDistance=cameraDistance/20;
//	trackingDistance=cameraDistance/10;
	setPhysics(PHYS_Rotating);

	CamAimOffset[0].x = 0;
	CamAimOffset[0].y = 50;
	CamAimOffset[0].z = 45;
	CamAimOffset[1].x = 0;
	CamAimOffset[1].y = -50;
	CamAimOffset[1].z = 45;
	CamAimOffset[2].x = 0;
	CamAimOffset[2].y = 100;
	CamAimOffset[2].z = 0;
	CamAimOffset[3].x = 0;
	CamAimOffset[3].y = -100;
	CamAimOffset[3].z = 0;
	CamAimOffset[4].x = 0;
	CamAimOffset[4].y = 0;
	CamAimOffset[4].z = 0;

	CamIndex = 0;
	CamCountdown = 0;
	
	foreach AllActors(class'baseharry', p)
		{
			if( p.bIsPlayer&& p!=Self)
			{
				break;
			}
		}

	bCollideWorld = false;

	//	setrotation(p.ViewRotation);
}



function setCutCamera (actor cLocation, actor Clookat)
{
}




auto state camstate
{
ignores takeDamage, SeePlayer, EnemyNotVisible, HearNoise, KilledBy, Trigger, Bump, HitWall, HeadZoneChange, FootZoneChange, ZoneChange, Falling, WarnTarget, Died, LongFall, PainTimer;



function setCutCamera (actor cLocation, actor Clookat)
{

	disable('tick');
	forcelocation=cLocation;
	lookatMe=Clookat;
	p.clientmessage("in setcutcamera");
	gotostate('cut');

	
}





	begin:

		sleep (0.0005);
//			turntoward(harry(p).StandardTarget);

		turntoward(p);
		goto 'begin';
}


// this function is used to set the camera to a set location and give it something to look at


function smoothRotate(rotator goalrot, out rotator dest,float deltatime)
{
	local int dist;


	dist=goalrot.yaw-dest.yaw;
	dist=(dist*cameraRotspeed)*deltatime;
	if(dist>1024)
	{
		dist=10024;
	}
	if(dist<-10024)
	{
		dist=-10024;
	}
	dest.yaw=dest.yaw+dist;
	dest.roll=goalrot.roll;
	

}

function throttleTrack(float deltatime)
// scales the tracking speed of the camera
{
	local float camTotal;

	camTotal=VSize(trackingPoint);
	trackingPoint=Normal(trackingPoint);

	cameraSpeed = p.AirSpeed / 500 * 7;
	if(cameraSpeed < 1)
		cameraSpeed = 1;
	if(cameraSpeed > 7)
		cameraSpeed = 7;


//	p.clientmessage(" "$cameraSpeed);

	camTotal=(camTotal*cameraSpeed)*deltatime;
	
	if(camTotal>100)
	{
		camTotal=100;
	}

	trackingPoint=trackingPoint*camtotal;

}

function Tick(float DeltaTime)
{

	local vector goalPoint;
	local vector camDistance;
	local float camTotal;
	local int offset;
	local float ftemp;
	local rotator tempRot;

	local vector HitLocation;
	local vector HitNormal;
	local actor PossibleVictim;
	local bool	bCantSeeTarget;
	
	camDistance=Location-p.Location;
	camTotal=VSize(camDistance);


	if(camTotal>40)
	{
		p.Style=STY_Normal;
		p.scaleGlow=1.0;
	}
	else
	{
		p.Style=STY_Translucent;
		p.scaleGlow=0.08;
	}
	


	camDistance.x=0;
	camDistance.y=0;
	camDistance.z=0;

	

	smoothRotate(p.ViewRotation,locRot,deltatime);
	locRot.pitch=camPitch;
// roll code
	locRot = Rotation;
	if(p.Rotation.roll < 32768)
		locRot.roll = p.Rotation.roll / 2;
	else
		locRot.roll = 65536 - (65536 - p.Rotation.roll)/2;
	
	SetRotation(locRot);
//
	offset=(currentLocation-trackingDistance)&15;
	goalPoint=previousLocations[offset]-camDistance;
	goalPoint.z=goalpoint.z+p.TargetEyeHeight+cameraHeight;
	trackingPoint=goalPoint-Location;
	

	camTotal=VSize(trackingPoint);

	if((camTotal>3&&!cameraLock))
	{
		smoothRotate(p.viewRotation,locRot,deltatime);
	//	Harry(p).bStationary = false;

		if(camPitch<-300)
		{
			camPitch=campitch+100;
		}

		if(camPitch>300)
		{
			camPitch=campitch-100;
		}
		locRot.pitch=campitch;	
		throttleTrack(deltatime);
		MoveSmooth(trackingPoint);
	}
	else		//Harry more or less stationary
	{
	//	Harry(p).bStationary = true;
		ftemp=abs(p.viewRotation.yaw-prevPlayerRotation.yaw);
		if(ftemp>lockbias)
		{
			if(cameraLock!=True)
			{
				currentLocation=0;
			}
			cameraLock=TRUE;
		}

		if(cameraLock)
		{
			smoothRotate(p.ViewRotation,locRot,deltatime);
			locRot.pitch=campitch;
			camDistance.x=CameraDistance;
			camDistance.y=0;
			camDistance.z=0;

//			bcollideactors=true;
//			bblockactors=true;
//			if(p.IsInState('playeraiming'))
			if(true)
			{
			//	bcollideactors=false;
			//	bblockactors=false;
			//	p.Style=STY_Translucent;
			//	camDistance.x=0;

				if(p.SmoothMouseY>64)
				{
					campitch=campitch+p.SmoothMouseY/32;
// @PAB was 2
					returnPitchTime=0;
					if(campitch>12000)
					{
						campitch=12000;
					}

				}

				if(p.SmoothMouseY<-64)
				{
					campitch=campitch+p.SmoothMouseY/32;
// @PAB was 2
					returnPitchTime=0;
					if(campitch<-12000)
					{
						campitch=-12000;
					}
				}
				if(p.SmoothMouseY==0)
				{
					
					returnPitchTime=returnPitchTime-deltaTime;
					if(returnPitchTime<=0&&campitch!=0)
					{
						
						if(campitch>0)
						{
							campitch=campitch+(10*returnpitchTime);
							if(campitch<0)
							{
								campitch=0;
							}
						}
						if(campitch<0)
						{
							campitch=campitch-(10*returnPitchTime);
							if(campitch>0)
							{
								campitch=0;
							}
						}

					}



				}
			}
			
			locRot.pitch=campitch;
			
			camdistance=camDistance>>locRot;
			goalPoint=p.location-camDistance;
			goalPoint.z=goalpoint.z+(p.TargetEyeHeight+cameraHeight) * p.DrawScale;
			trackingPoint=goalPoint-Location;
			throttleTrack(deltatime);
			MoveSmooth(trackingPoint);
		}
			
	}


// see if the player moved enough to record


	camTotal=VSize(previousLocations[currentLocation]-p.Location);
	if(abs(camTotal)>10.0)
	{
		prevPlayerRotation=p.ViewRotation;
		currentLocation=(currentLocation+1)&15;
		previousLocations[currentLocation]=p.Location;
		if(cameraLock)
		{
			
			if(currentLocation==0)
			{
				cameraLock=False;
			}
		}

		
	}

	if(!CanSee(p))
	{
	//	p.ClientMessage("can't see the player");
		
		bCollideWorld=False;
		bCollideActors=false;

	}
/*	else
	{
	//	p.ClientMessage("can see");
	//	bCollideWorld=True;
	//	bCollideActors=True;

	} */

}

state cut
{

function Tick(float DeltaTime)
{


}

 begin:
	 setrotation(forcelocation.rotation);
	 setlocation(forcelocation.location);	
	floop:
	turntoward(lookatMe);
	
	
	p.clientmessage("cam location is "$location);
	log("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! cam location is "$forcelocation);

	sleep(0.1);
	goto 'floop';
	

}

defaultproperties
{
     cameraLock=True
     CameraDistance=60
     CameraHeight=60
     CameraSpeed=4
     lockBias=1
     cameraRotSpeed=30
     bHidden=True
     CollisionRadius=10
     bBlockActors=False
     bBlockPlayers=False
     RotationRate=(Pitch=60000,Yaw=60000,Roll=20000)
}
