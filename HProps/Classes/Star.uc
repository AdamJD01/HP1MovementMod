//===============================================================================
//  [Star] 
//===============================================================================

class Star extends HProps;
#exec MESH  MODELIMPORT MESH=StarMesh MODELFILE=models\StarMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=StarMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=StarAnims ANIMFILE=models\StarAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=StarMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=StarMesh ANIM=StarAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=StarAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=StarTex0  FILE=TEXTURES\StarTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=StarMesh NUM=0 TEXTURE=StarTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: chalstar_64.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\Star 

var float ZoomDist;

function touch(actor other)
{

	if(other==playerharry && GetStateName()!='pickupstar')
	{
		gotostate('pickupstar');

	}


}
function faceCamera()
{
local Rotator r;

	r=playerharry.cam.Rotation;
	r.yaw+=65536/4;
	r.roll=r.pitch;
	r.pitch=0;
	DesiredRotation=r;
	SetRotation(r);
}
function ZoomToCamera()
{
local vector v;
		v.x=ZoomDist;
		SetLocation(playerharry.cam.location+(v >> playerharry.cam.Rotation));

}

state pickupstar
{
	event tick(float delta)
		{
		ZoomDist-=delta*400;
//		Move((playerharry.cam.location-location)/10);
		ZoomToCamera();
		faceCamera();
		}

	begin:
		disable('touch');
//		SetPhysics(PHYS_Rotating);
		playSound(Sound'HPSounds.magic_sfx.pickup_star');
		faceCamera();
		bCollideWorld=false;
		ZoomDist=160;
		while(ZoomDist>0)
			{
			sleep(0.2);
			}
		
		playerHarry.addStars(1);
		destroy();
}

defaultproperties
{
     attachedParticleClass=Class'HPParticle.Goldstar01'
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.StarMesh'
     AmbientGlow=200
}
