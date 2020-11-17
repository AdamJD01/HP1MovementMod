//===============================================================================
//  [PotionBeaker] 
//===============================================================================

class PotionBeaker extends HProps;
#exec MESH  MODELIMPORT MESH=PotionBeakerMesh MODELFILE=models\PotionBeakerMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionBeakerMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionBeakerAnims ANIMFILE=models\PotionBeakerAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionBeakerMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionBeakerMesh ANIM=PotionBeakerAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionBeakerAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionBeakerTex0  FILE=TEXTURES\PotionBeakerTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionBeakerMesh NUM=0 TEXTURE=PotionBeakerTex0


// Original material [0] is [SKIN00.TRANSLUCENT] SkinIndex: 0 Bitmap: HWBeaker_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\General Objects 

var()  Sound pickup;

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionBeakerMesh'
}
