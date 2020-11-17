//===============================================================================
//  [PotionBottleGreen] 
//===============================================================================

class PotionBottleGreen extends HProps;
#exec MESH  MODELIMPORT MESH=PotionBottleGreenMesh MODELFILE=models\PotionBottleGreenMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionBottleGreenMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionBottleGreenAnims ANIMFILE=models\PotionBottleGreenAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionBottleGreenMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionBottleGreenMesh ANIM=PotionBottleGreenAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionBottleGreenAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionBottleGreenTex0  FILE=TEXTURES\PotionBottleGreenTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionBottleGreenMesh NUM=0 TEXTURE=PotionBottleGreenTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: greenbtl_128.bmp  Path: D:\Harry Potter\Art\Objects\Potions Class\Ingredient jars

defaultproperties
{
     hudIcon=Texture'HProps.Icons.GreenPotionIcon'
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionBottleGreenMesh'
}
