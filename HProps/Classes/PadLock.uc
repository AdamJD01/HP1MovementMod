//===============================================================================
//  [PadLock] 
//===============================================================================

class PadLock extends HProps;
#exec MESH  MODELIMPORT MESH=PadLockMesh MODELFILE=models\PadLockMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PadLockMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PadLockAnims ANIMFILE=models\PadLockAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PadLockMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PadLockMesh ANIM=PadLockAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PadLockAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PadLockTex0  FILE=TEXTURES\PadLockTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PadLockMesh NUM=0 TEXTURE=PadLockTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: PadLock.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures 

var (padlock) float timetoUnlock;
var (padlock)class<Actor> flash;

function Trigger( actor Other, pawn EventInstigator )

{

	if(bhidden==true)
	{
		bhidden=false;
		return;
	}
	spawn(flash);
	settimer(timetoUnlock,false);



}
event timer()
{
	destroy();
}

defaultproperties
{
     timetoUnlock=0.1
     flash=Class'HPParticle.Spawn_flash_4'
     attachedParticleClass=Class'HPParticle.Lock'
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PadLockMesh'
     AmbientGlow=75
}
