//===============================================================================
//  [GregorySmarmy] 
//===============================================================================

class GregorySmarmy extends HProps;
#exec MESH  MODELIMPORT MESH=GregorySmarmyMesh MODELFILE=models\GregorySmarmyMesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=GregorySmarmyMesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=GregorySmarmyAnims ANIMFILE=models\GregorySmarmyAnims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=GregorySmarmyMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=GregorySmarmyMesh ANIM=GregorySmarmyAnims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=GregorySmarmyAnims VERBOSE

#EXEC TEXTURE IMPORT NAME=GregorySmarmyTex0  FILE=TEXTURES\GregorySmarmyTex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=GregorySmarmyMesh NUM=0 TEXTURE=GregorySmarmyTex0

// Original material [0] is [Material #13] SkinIndex: 0 Bitmap: gregory1.bmp  Path: \\Baker\HPotterPC\Art\Models\Objects\Hogwarts Props\Gregory

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.GregorySmarmyMesh'
}
