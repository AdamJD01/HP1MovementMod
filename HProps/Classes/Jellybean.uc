//===============================================================================
//  [Jellybean] 
//===============================================================================

class Jellybean extends HProps;
#exec MESH  MODELIMPORT MESH=JellybeanMesh MODELFILE=models\JellybeanMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=JellybeanMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=JellybeanAnims ANIMFILE=models\JellybeanAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=JellybeanMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=JellybeanMesh ANIM=JellybeanAnims

#exec ANIM DIGEST  ANIM=JellybeanAnims VERBOSE
#EXEC TEXTURE IMPORT NAME=JellybeanTex0  FILE=TEXTURES\JellybeanTex0.bmp  GROUP=Skins
#exec OBJ LOAD FILE=..\textures\HP_FX.utx PACKAGE=HPBase.FXPackage
#EXEC MESHMAP SETTEXTURE MESHMAP=JellybeanMesh NUM=0 TEXTURE=HPBase.FXPackage.jelly1

var()	Sound good, bad;
var float fPickupFlyTime;

var bool	bTiming;
var float	fTimeout;

function PreBeginPlay(){
	Super.PreBeginPlay();
}

function Spawned(){
	SetPhysics(PHYS_Falling);
	bTiming = false;
}

function touch (actor other){
	if (other.IsA('Tut1Gnome')){
		// AE:
		PlaySound(sound'HPSounds.magic_sfx.pickup11');
		Destroy();
	}

	if(other==playerharry && GetStateName()!='killbean')
		gotostate('killbean');
}

state deadbean{
	begin:
		bhidden=true;
		setcollision(false,false,false);
		beanloop:
		sleep (1);
		goto 'beanloop';
}

auto state beano{
	function BeginState(){
		bTiming = false;
		fTimeout = 5.0;
	}

	function tick(float deltatime){
		local Rotator	NewRotation;

		NewRotation = Rotation;
		NewRotation.Yaw += (30000 * deltatime);
		NewRotation.Yaw = NewRotation.Yaw & 0xffff;

		SetRotation(NewRotation);
		if(vsize(location-playerharry.location)<60)
			gotostate('killbean');

		if (bTiming)
			fTimeout -= deltatime;
	}

	function HitWall( vector HitNormal, actor Wall ){
		Velocity *= 0.5;
		Velocity = MirrorVectorByNormal( Velocity, HitNormal );

		bTiming = true;
		if (bTiming && fTimeout >= 0){
			if (abs(Velocity.z) > 5)
				playsound(sound'HPSounds.Magic_sfx.bean_bounce');
		}
	}

	begin:
	loop:
		sleep(1);
		goto 'loop';
}

state killbean{
	ignores touch;

	event tick(float delta){
		local vector dest;
		fPickupFlyTime-=delta;

		Move((playerharry.CameraToWorld(vect(0.75,0.75,150))-location)/(fPickupFlyTime/delta));
	}

	begin:
		// AE:
		PlaySound(sound'HPSounds.magic_sfx.pickup11');
		bCollideWorld=false;
		fPickupFlyTime=0.25;
		playerHarry.AddBeans(1);
		while(fPickupFlyTime>0){
			sleep(0.1);
		}
		destroy();
}

defaultproperties{
     bDoBob=True
     bStatic=False
     Physics=PHYS_Walking
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.JellybeanMesh'
     AmbientGlow=200
     CollisionRadius=10
     CollisionHeight=10
     bCollideWorld=True
     bBounce=True
}