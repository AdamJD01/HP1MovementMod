//===============================================================================
//  [PotionBottleBlue] 
//===============================================================================

class PotionBottleBlue extends HProps;
#exec MESH  MODELIMPORT MESH=PotionBottleBlueMesh MODELFILE=models\PotionBottleBlueMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionBottleBlueMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionBottleBlueAnims ANIMFILE=models\PotionBottleBlueAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionBottleBlueMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionBottleBlueMesh ANIM=PotionBottleBlueAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionBottleBlueAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionBottleBlueTex0  FILE=TEXTURES\PotionBottleBlueTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionBottleBlueMesh NUM=0 TEXTURE=PotionBottleBlueTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: bluebotl_128.bmp  Path: D:\Harry Potter\Art\Objects\Potions Class\Ingredient jars 

#EXEC TEXTURE IMPORT NAME=BluePotionIcon  FILE=TEXTURES\BluePotionIcon.bmp FLAGS=2 MIPS=OFF GROUP=Icons
#EXEC TEXTURE IMPORT NAME=GreenPotionIcon  FILE=TEXTURES\GreenPotionIcon.bmp FLAGS=2 MIPS=OFF GROUP=Icons
#EXEC TEXTURE IMPORT NAME=OrangePotionIcon  FILE=TEXTURES\OrangePotionIcon.bmp FLAGS=2 MIPS=OFF GROUP=Icons
#EXEC TEXTURE IMPORT NAME=PurplePotionIcon  FILE=TEXTURES\PurplePotionIcon.bmp FLAGS=2 MIPS=OFF GROUP=Icons

defaultproperties
{
     hudIcon=Texture'HProps.Icons.BluePotionIcon'
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionBottleBlueMesh'
}
