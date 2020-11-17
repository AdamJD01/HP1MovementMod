//===============================================================================
//  [PotionBottlePurple] 
//===============================================================================

class PotionBottlePurple extends HProps;
#exec MESH  MODELIMPORT MESH=PotionBottlePurpleMesh MODELFILE=models\PotionBottlePurpleMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=PotionBottlePurpleMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=PotionBottlePurpleAnims ANIMFILE=models\PotionBottlePurpleAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=PotionBottlePurpleMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=PotionBottlePurpleMesh ANIM=PotionBottlePurpleAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=PotionBottlePurpleAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=PotionBottlePurpleTex0  FILE=TEXTURES\PotionBottlePurpleTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=PotionBottlePurpleMesh NUM=0 TEXTURE=PotionBottlePurpleTex0

// Original material [0] is [SKIN00] SkinIndex: 0 Bitmap: purplebt_128.bmp  Path: D:\Harry Potter\Art\Objects\Potions Class\Ingredient jars

defaultproperties
{
     hudIcon=Texture'HProps.Icons.PurplePotionIcon'
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.PotionBottlePurpleMesh'
}
