//===============================================================================
//  [PotionBottleEmpty] 
//===============================================================================

class PotionBottleEmpty extends HProps;
#exec MESH  MODELIMPORT MESH=PotionBottleEmptyMesh MODELFILE=models\PotionBottleEmptyMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionBottleEmptyMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionBottleEmptyAnims ANIMFILE=models\PotionBottleEmptyAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionBottleEmptyMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionBottleEmptyMesh ANIM=PotionBottleEmptyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionBottleEmptyAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionBottleEmptyTex0  FILE=TEXTURES\PotionBottleEmptyTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionBottleEmptyMesh NUM=0 TEXTURE=PotionBottleEmptyTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: emptybtl_128.bmp  Path: D:\Harry Potter\Art\Objects\Potions Class\Ingredient jars

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionBottleEmptyMesh'
}
