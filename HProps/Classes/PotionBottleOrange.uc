//===============================================================================
//  [PotionBottleOrange] 
//===============================================================================

class PotionBottleOrange extends HProps;
#exec MESH  MODELIMPORT MESH=PotionBottleOrangeMesh MODELFILE=models\PotionBottleOrangeMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionBottleOrangeMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionBottleOrangeAnims ANIMFILE=models\PotionBottleOrangeAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionBottleOrangeMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionBottleOrangeMesh ANIM=PotionBottleOrangeAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionBottleOrangeAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionBottleOrangeTex0  FILE=TEXTURES\PotionBottleOrangeTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionBottleOrangeMesh NUM=0 TEXTURE=PotionBottleOrangeTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: orangebt_128.bmp  Path: D:\Harry Potter\Art\Objects\Potions Class\Ingredient jars

defaultproperties
{
     hudIcon=Texture'HProps.Icons.OrangePotionIcon'
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionBottleOrangeMesh'
}
