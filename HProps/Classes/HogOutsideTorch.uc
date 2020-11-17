//===============================================================================
//  [HogOutsideTorch] 
//===============================================================================

class HogOutsideTorch extends HProps;
#exec MESH  MODELIMPORT MESH=HogOutsideTorchMesh MODELFILE=models\HogOutsideTorchMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=HogOutsideTorchMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=HogOutsideTorchAnims ANIMFILE=models\HogOutsideTorchAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=HogOutsideTorchMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=HogOutsideTorchMesh ANIM=HogOutsideTorchAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=HogOutsideTorchAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=HogOutsideTorchTex0  FILE=TEXTURES\HogOutsideTorchTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=HogOutsideTorchMesh NUM=0 TEXTURE=HogOutsideTorchTex0

// Original material [0] is [SKIN00.MASKED] SkinIndex: 0 Bitmap: outsidet_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\candle sticks

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.HogOutsideTorchMesh'
}
