//===============================================================================
//  [SavePointFloatBook] 
//===============================================================================

class SavePointFloatBook extends HProps;
#exec MESH  MODELIMPORT MESH=SavePointFloatBookMesh MODELFILE=models\SavePointFloatBookMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=SavePointFloatBookMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=SavePointFloatBookAnims ANIMFILE=models\SavePointFloatBookAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=SavePointFloatBookMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=SavePointFloatBookMesh ANIM=SavePointFloatBookAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=SavePointFloatBookAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=SavePointFloatBookTex0  FILE=TEXTURES\SavePointFloatBookTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=SavePointFloatBookMesh NUM=0 TEXTURE=SavePointFloatBookTex0

// Original material [0] is [Material #8] SkinIndex: 0 Bitmap: floatbok_128.bmp  Path: D:\Harry Potter\Art\Objects\General Objects\books

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HPModels.SavePointFloatBookMesh'
}
