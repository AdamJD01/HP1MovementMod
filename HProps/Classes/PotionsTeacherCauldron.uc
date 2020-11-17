//===============================================================================
//  [PotionsTeacherCauldron] 
//===============================================================================

class PotionsTeacherCauldron extends HProps;
#exec MESH  MODELIMPORT MESH=PotionsTeacherCauldronMesh MODELFILE=models\PotionsTeacherCauldronMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionsTeacherCauldronMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionsTeacherCauldronAnims ANIMFILE=models\PotionsTeacherCauldronAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionsTeacherCauldronMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionsTeacherCauldronMesh ANIM=PotionsTeacherCauldronAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionsTeacherCauldronAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionsTeacherCauldronTex0  FILE=TEXTURES\PotionsTeacherCauldronTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionsTeacherCauldronMesh NUM=0 TEXTURE=PotionsTeacherCauldronTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: teccould_128.bmp  Path: D:\Harry Potter\A Lorian's Stuff\Hogwarts\Potions Class 

var ()Class<baseProps> bumpItemClass;

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionsTeacherCauldronMesh'
     CollisionRadius=44
}
