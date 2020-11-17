//===============================================================================
//  [FlipendoVaseBronzeShard] 
//===============================================================================

class FlipendoVaseBronzeShard extends hprops;
#exec MESH  MODELIMPORT MESH=FlipendoVaseBronzeShardMesh MODELFILE=models\FlipendoVaseBronzeShardMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=FlipendoVaseBronzeShardMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=FlipendoVaseBronzeShardAnims ANIMFILE=models\FlipendoVaseBronzeShardAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=FlipendoVaseBronzeShardMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=FlipendoVaseBronzeShardMesh ANIM=FlipendoVaseBronzeShardAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=FlipendoVaseBronzeShardAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=FlipendoVaseBronzeShardTex0  FILE=TEXTURES\FlipendoVaseBronzeShardTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=FlipendoVaseBronzeShardMesh NUM=0 TEXTURE=FlipendoVaseBronzeShardTex0

// Original material [0] is [SKIN00.TWOSIDED] SkinIndex: 0 Bitmap: fvbrzbrk_64.bmp  Path: D:\Harry Potter\Art\Objects\Flipendo Vases 

var rotator randrot;
var bool tickOn;


auto state fall
{



function tick(float deltaTime)
{
	local vector loc;
	loc=location;
	if(tickOn)
	{
	//	if(fasttrace(velocity*deltaTime))
			move(velocity*deltaTime);
		if(vsize(loc-location)>0.1)
		{
			velocity.z=velocity.z-(100*deltatime);
			setrotation(rotation+randrot);	
		}
	}



}


function touch(actor other)
{

	if(other==playerHarry)
		destroy();

}

function initfall()
{
	local rotator randx;
		randrot=rotrand();
		randx=rotation;
		randx.yaw=randx.yaw+rand(20000);
		randx.yaw=randx.yaw-10000;
		velocity=normal(vector(randx))*10;
		velocity.z=30+rand(100);	
	

}

	begin:
	
		initfall();
		tickOn=true;

	loop:
		sleep(5.5);
		tickon=false;
		goto 'loop';
		destroy();




}

defaultproperties
{
     bStatic=False
     Physics=PHYS_Flying
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.FlipendoVaseBronzeShardMesh'
     CollisionRadius=1
     CollisionHeight=1
     bCollideWorld=True
}
