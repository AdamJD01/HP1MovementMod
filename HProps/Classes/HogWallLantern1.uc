//===============================================================================
//  [HogWallLantern1] 
//===============================================================================

class HogWallLantern1 extends HProps;
#exec MESH  MODELIMPORT MESH=HogWallLantern1Mesh MODELFILE=models\HogWallLantern1Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogWallLantern1Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogWallLantern1Anims ANIMFILE=models\HogWallLantern1Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogWallLantern1Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogWallLantern1Mesh ANIM=HogWallLantern1Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogWallLantern1Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogWallLantern1Tex0  FILE=TEXTURES\HogWallLantern1Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogWallLantern1Mesh NUM=0 TEXTURE=HogWallLantern1Tex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: pntylamp_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\lanterns\peaked lantern

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogWallLantern1Mesh'
}
