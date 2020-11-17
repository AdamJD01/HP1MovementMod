//===============================================================================
//  [Sundial] 
//===============================================================================

class Sundial extends HProps;
#exec MESH  MODELIMPORT MESH=SundialMesh MODELFILE=models\SundialMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SundialMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SundialAnims ANIMFILE=models\SundialAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SundialMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=SundialMesh ANIM=SundialAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SundialAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=SundialTex0  FILE=TEXTURES\SundialTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=SundialMesh NUM=0 TEXTURE=SundialTex0

// Original material [0] is [Material #2] SkinIndex: 0 Bitmap: sundial_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\sundial

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.SundialMesh'
}
