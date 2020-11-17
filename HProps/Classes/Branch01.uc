//===============================================================================
//  [Branch01] 
//===============================================================================

class Branch01 extends HProps;
#exec MESH  MODELIMPORT MESH=Branch01Mesh MODELFILE=models\Branch01Mesh.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=Branch01Mesh X=0 Y=0 Z=0 YAW=0 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=Branch01Anims ANIMFILE=models\Branch01Anims.PSA COMPRESS=1 MAXKEYS=999999 IMPORTSEQS=1
#exec MESHMAP   SCALE MESHMAP=Branch01Mesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=Branch01Mesh ANIM=Branch01Anims

// Digest and compress the animation data. Must come after the sequence declarations.
// 'VERBOSE' gives more debugging info in UCC.log 
#exec ANIM DIGEST  ANIM=Branch01Anims VERBOSE

#EXEC TEXTURE IMPORT NAME=Branch01Tex0  FILE=TEXTURES\Branch01Tex0.bmp  GROUP=Skins

#EXEC MESHMAP SETTEXTURE MESHMAP=Branch01Mesh NUM=0 TEXTURE=Branch01Tex0

// Original material [0] is [Material #1] SkinIndex: 0 Bitmap: brownbark00.bmp  Path: C:\Project Files\Harry Potter PC\HP Object Textures

defaultproperties
{
     bStatic=False
     DrawType=DT_Mesh
     Mesh=SkeletalMesh'HProps.Branch01Mesh'
}
