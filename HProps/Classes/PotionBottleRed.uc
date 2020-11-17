//===============================================================================
//  [PotionBottleRed] 
//===============================================================================

class PotionBottleRed extends HProps;
#exec MESH  MODELIMPORT MESH=PotionBottleRedMesh MODELFILE=models\PotionBottleRedMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionBottleRedMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionBottleRedAnims ANIMFILE=models\PotionBottleRedAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionBottleRedMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionBottleRedMesh ANIM=PotionBottleRedAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionBottleRedAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionBottleRedTex0  FILE=TEXTURES\PotionBottleRedTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionBottleRedMesh NUM=0 TEXTURE=PotionBottleRedTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: redbotle_128.bmp  Path: D:\Harry Potter\Art\Objects\Potions Class\Ingredient jars

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionBottleRedMesh'
}
