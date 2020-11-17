class h2barron expands basechar;




#exec MESH  MODELIMPORT MESH=skbloodybaronMesh MODELFILE=..\harrypotter\SkeletalMeshes\skbloodybaronMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=skbloodybaronMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=skbloodybaronAnims ANIMFILE=..\harrypotter\Animations\skbloodybaronAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=skbloodybaronMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=skbloodybaronMesh ANIM=skbloodybaronAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=skbloodybaronAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=skbloodybaronTex0  FILE=..\harrypotter\TEXTURES\skbloodybaronTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=skbloodybaronMesh NUM=0 TEXTURE=skbloodybaronTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: BARON_SKIN00.bmp  Path: H:\Art\Design\Character Development\BloodyBaron 



var float hitCount;
var sound peevesVoice;

var PathNode enterPoint;
var PathNode exitPoint;
var PathNode attackPoints[10];
var int curAttackPoint;
var bool bTriggered;
var int currentsound;
var (peeves) name orbitPoint;
var (peeves) float orbitDistance;
var (peeves) float orbitTime;
var (peeves) name exitpathtype;
var (peeves) name exitfirstPath;
var (peeves) name exitstationdestination;
var rotator orbitrot;
var actor orbitact;
var float orbitStartYaw;
var int orbitcount;
VAR float dancetime;
var vector randdir;
var basecam pcam;
var vector camoffset;
var bool hugcamera;




function float GetHealth()
{
return hitcount / 4;

}


function PostBeginPlay()
{
local baseWand weap;
local int i;
local PathNode node;

	Super.PostBeginPlay();

	weap=spawn(class'baseWand');
	weap.BecomeItem();
	AddInventory(weap);
	weap.WeaponSet(self);
	weap.GiveAmmo(self);
	weap.SelectSpell(Class'spellPeevesThrow');

		foreach allActors(class'actor', orbitact)
		{
			if( orbitact.name==orbitPoint)
			{
				break;
			}
		}


	curAttackPoint=0;

}

function timer()
{
	enable('bump');
	bblockplayers=true;
	bblockactors=true;

}
function bump(actor other)
{
	if(other==playerharry)
	{
		playerHarry.takeDamage(5,self,Location, Vect(0,0,1)*9,'exploded');
	}
		settimer(1,false);
		disable('bump');
		bblockplayers=false;
		bblockactors=false;
	

}

event TakeDamage( int Damage, Pawn EventInstigator, vector HitLocation, vector Momentum, name DamageType)
{
//	playerHarry.clientMessage(self $":I've been shot!");
//	gotostate ('shot');
}
function bool TakeSpellEffect(baseSpell spell)
{
local vector spawnLoc;
local actor newSpawn;

	if(spell.class==class'spellflip')
		{
		hitCount=hitcount-1;
		if(!IsInState('dieing'))
			gotostate ('shot');
		}

}

function rotator AdjustAim(float projSpeed, vector projStart, int aimerror, bool bLeadTarget, bool bWarnTarget)
{
	return Rotation;
}

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



auto state waitforTrigger
{
	
function Trigger( actor Other, pawn EventInstigator )
{

	gotostate('patrol');


}
	begin:
	

	loop:
		loopanim('look');
		sleep(2.4);
		turntoward(playerHarry);
		
		goto 'loop';

}




state waitforTrigger2
{
	
function Trigger( actor Other, pawn EventInstigator )
{
//	PlaySound(sound 'HPSounds.peeves_sfx.pee_009', SLOT_Talk, 3.2, false, 2000.0, 1.0);

	gotostate('attackcamera');


}
	begin:
	

	loop:
		loopanim('look');
		sleep(2.4);
		turntoward(playerHarry);
		
		goto 'loop';

}


state attackCamera
{


function tick(float delta)
{
	local vector vect;

	if(hugcamera==true)
	{
		camoffset.z=-30;
		camoffset.y=0;
		camoffset.x=60;
		camoffset=camoffset>>pcam.rotation;
		camoffset=camoffset+pcam.location;
		vect=camoffset-location;
		if(abs(vsize(vect))>60)
		{
			move(normal(vect)*(delta*1000));
			
		}
		else
		{
			hugcamera=false;
		}
	}

}
function findcam()
{
		foreach allActors(class'basecam', pcam)
		{
			break;
		}


}

begin:
	
	findcam();
	hugcamera=true;
	pcam.gotostate('cutstate');
	SetPhysics(PHYS_rotating);
//	PlaySound(sound 'HPSounds.peeves_sfx.pee_009', SLOT_Talk, 3.2, false, 2000.0, 1.0);

	
loop:
//	turntoward(pcam);
	sleep(0.5);
	if(abs(vsize(camoffset-location))>80)
	{
		goto'loop';
	}


	turntoward(pcam);
	playanim('grab');
	finishanim();
	airspeed=800;
	pcam.gotostate('standardstate');
	gotostate('taunt');
	
	goto 'loop';





}



state taunt
{


	
function Trigger( actor Other, pawn EventInstigator )
{


	gotostate('patrol');


}

function setup()
	{
		foreach allActors(class 'navigationPoint',navP)
		{
			destP=baseStation(navP);

			if(destP.Name=='basestation2')
			{
				break;
			}
		}

	}
	begin:
		setup();
		SetPhysics(PHYS_flying);
		playerharry.clientmessage("moving to "$navp);
		movetoward(navp);
		SetPhysics(PHYS_rotating);
	loop:
		
		turntoward(playerharry);
		loopanim('scheming');
		sleep(3.5);
		playanim('seeharry');
		switch(	currentSound)
		{
		case 0:
		
		//	PlaySound(sound 'HPSounds.peeves_sfx.pee_004', SLOT_Talk, 3.2, true, 2000.0, 1.0);
			currentSound=1;
			break;
		case 1:
		//	PlaySound(sound 'HPSounds.peeves_sfx.pee_008', SLOT_Talk, 3.2, true, 2000.0, 1.0);
			currentSound=2;
			break;
		case 2:
		//	PlaySound(sound 'HPSounds.peeves_sfx.pee_010', SLOT_Talk, 3.2, true, 2000.0, 1.0);
			currentSound=3;
			break;
		case 3:
		//	PlaySound(sound 'HPSounds.peeves_sfx.pee_003', SLOT_Talk, 3.2, true, 2000.0, 1.0);
			currentSound=0;
			break;

		}
		finishanim();

		goto 'loop';




	
}
state attackHarry
{


function tick(float deltatime)
{

	dancetime=dancetime+deltatime;
	if(dancetime>0.3)
	{
		randdir=200*vrand();
		dancetime=0;

	}
	if(randdir.z<0)
	{
		randdir.z=0;
	}
	setlocation(location+(randdir*deltatime));


}

	begin:
		switch(	currentSound)
		{
		case 0:
		//	PlaySound(sound 'HPSounds.peeves_sfx.pee_004', SLOT_Talk, 3.2, true, 2000.0, 1.0);
			currentSound=1;
			break;
		case 1:
		//	PlaySound(sound 'HPSounds.peeves_sfx.pee_008', SLOT_Talk, 3.2, true, 2000.0, 1.0);
			currentSound=2;
			break;
		case 2:
		//	PlaySound(sound 'HPSounds.peeves_sfx.pee_010', SLOT_Talk, 3.2, true, 2000.0, 1.0);
			currentSound=3;
			break;
		case 3:
		//	PlaySound(sound 'HPSounds.peeves_sfx.pee_003', SLOT_Talk, 3.2, true, 2000.0, 1.0);
			currentSound=0;
			break;

		}

		cam.gotostate('bossstate');
		loopAnim('attackfloat');
//		AirSpeed=+00200.000000;

	wait:
		TurnTo(playerHarry.location);
		playanim('scheming',1.3);

		dancetime=0;
		settimer(0.1+(frand()*2),false);
		randdir=200*vrand();

		finishanim();
		
		
		gotostate('throwing');
//		MoveToward(playerHarry);
		goto 'wait';


}


// patrol state moves the characters around a path described by hpath and basestations

state patrol
{
	function startup()
	{
		foreach allActors(class'baseHarry', p)
		{
			if( p.bIsPlayer&& p!=Self)
			{
				break;
			}
		}

		foreach allActors(class 'navigationPoint',navP)
		{
			destP=baseStation(navP);

			if(destP.Name==stationDestination)
			{
				break;
			}
		}

		foreach allActors(class 'navigationPoint',navP)
		{
			if(navp.Name==firstPath)
			{
				break;
			}
		}
	}

  Begin:
  

	enable( 'Tick' );
	startup();
	SetPhysics(PHYS_flying);

	if(firstPath=='')
	{
			goto 'idleloop';

	}
	loopAnim('float');

  moveLoop:
	
	next=findPath(navP,stationDestination);
	p.clientmessage("next in patrol is "$next);
	p.clientmessage("station destionation is "$stationDestination);
/*	if(next==none)
	{
		goto 'idleloop';
	}
*/
	do
	{
		moveTo(navP.location);
		impartinformation();
		sleep(0.005);
	}until(vsize(location-(navP.location)) < fNavPointColRadius);

	if(destp==navP)
	{
		PawnAtStation();
	}

	navP=navigationPoint(next);
	if(navP==none)
	{
	  idleLoop:
		while( true )
		{
			loopAnim('breath');
			impartinformation();
			sleep(speechTime);
			speechTime=0;
			sleep(0.5);

			//If loop path, just start the whole patrol process over again by setting navp to firstPath.
			if( bLoopPath )
			{
				foreach allActors(class 'navigationPoint',navP)
					if(navp.Name==firstPath)
						break;
				break; //break the while loop
			}

			//goto 'idleloop';
		}
	}

	
	next=none;
	
	goto 'moveLoop';
}


state atStation
{

	begin:


	SetPhysics(PHYS_Rotating);

	
	desiredRotation=(destP.rotation);


	sleep(destP.aiData[stationNumber].pauseTime);
	stationDestination=destP.aiData[stationNumber].stationDestination;
	pathType=destP.aiData[stationNumber].pathType;
	firstPath=destP.aiData[stationNumber].firstPath;
	stationNumber=destP.aiData[stationNumber].nextStationGroup;



	if(destP.aiData[stationNumber].behavior==bh_die)
	{
		destroy();
	}
	if(destP.aiData[stationNumber].behavior==bh_idle2)
	{
		if(false)
		{
			gotostate('orbit');
			orbitCount=0;
		}
		else
		{
			orbitCount=orbitCount+1;
			gotostate('attackHarry');
		}
	}
	if(destP.aiData[stationNumber].behavior==bh_idle1)
	{
		
		gotostate('patrol');
	
	}

	gotostate('patrol');
}




state shot
{
begin:
//	PlaySound(sound 'HPSounds.peeves_sfx.pee_009', SLOT_Talk, 3.2, false, 2000.0, 1.0);
	playAnim('reaction2harry');
	finishanim();
	if(hitCount<=0)
		gotostate('dieing');
	gotoState('patrol');

}
state dieing
{


function causetrigger()
{

	local actor a;



	foreach AllActors( class 'Actor', A, Event )
	{
		A.Trigger( self, self.Instigator );
	}


}

function findpstart()
{
		foreach allActors(class 'navigationPoint',navP)
		{
			if(navp.Name==firstPath)
			{
				break;
			}
		}
}
begin:
	cam.gotostate('standardstate');
	playerharry.underattack=false;
	bCollideWorld=false;
	SetPhysics(PHYS_flying);
	airspeed=100;
	causetrigger();
//	PlaySound(sound 'HPSounds.peeves_sfx.pee_011', SLOT_Talk, 3.2, false, 2000.0, 1.0);
	stationDestination=exitstationdestination;
	pathType=exitpathtype;
	firstPath=exitfirstpath;
	findpstart();
	p.clientmessage("move toward "$navp);
	turntoward(navp);
	sleep(1);
	gotostate('patrol');






}

defaultproperties
{
     hitCount=4
     bFlipTarget=True
     MenuName="Peeves"
     Physics=PHYS_Flying
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HarryPotter.skbloodybaronMesh'
     bCollideWorld=False
     bProjTarget=True
     RotationRate=(Pitch=100000,Yaw=100000,Roll=100000)
}
