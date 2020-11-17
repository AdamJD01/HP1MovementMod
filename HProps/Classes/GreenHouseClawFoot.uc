//===============================================================================
//  [GreenHouseClawFoot] 
//===============================================================================

class GreenHouseClawFoot extends HProps;
#exec MESH  MODELIMPORT MESH=GreenHouseClawFootMesh MODELFILE=models\GreenHouseClawFootMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GreenHouseClawFootMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GreenHouseClawFootAnims ANIMFILE=models\GreenHouseClawFootAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GreenHouseClawFootMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GreenHouseClawFootMesh ANIM=GreenHouseClawFootAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GreenHouseClawFootAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GreenHouseClawFootTex0  FILE=TEXTURES\GreenHouseClawFootTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GreenHouseClawFootMesh NUM=0 TEXTURE=GreenHouseClawFootTex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: clawfoot_128.bmp  Path: D:\Harry Potter\Art\Objects\Greenhouse\claw foot

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GreenHouseClawFootMesh'
}
